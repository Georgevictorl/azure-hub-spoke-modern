terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "4.66.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# RESOURCE GROUP
resource "azurerm_resource_group" "rg" {
  name     = "HEVNetRG3"
  location = "centralus"

  tags = {
    Project = "HubSpokeModern"
  }
}

# VNET
resource "azurerm_virtual_network" "vnet" {
  name                = "HEVNet3"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["172.16.0.0/16"]

  tags = {
    Project = "HubSpokeModern"
  }
}

# SUBNET
resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["172.16.0.0/24"]
}

# ROUTE TABLE
resource "azurerm_route_table" "rt" {
  name                = "DevRT"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  route {
    name                   = "DevToPrd"
    address_prefix         = "10.0.0.0/23"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.7.1.4"
  }

  tags = {
    Project = "HubSpokeModern"
  }
}

# ASSOCIAÇÃO SUBNET ↔ ROUTE TABLE
resource "azurerm_subnet_route_table_association" "rt" {
  subnet_id      = azurerm_subnet.default.id
  route_table_id = azurerm_route_table.rt.id
}

# NSG
resource "azurerm_network_security_group" "vm" {
  name                = "HEVM3-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    Project = "HubSpokeModern"
  }
}

# NIC
resource "azurerm_network_interface" "vm" {
  name                = "hevm3-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.default.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Project = "HubSpokeModern"
  }
}

# ASSOCIAÇÃO NIC ↔ NSG
resource "azurerm_network_interface_security_group_association" "vm" {
  network_interface_id      = azurerm_network_interface.vm.id
  network_security_group_id = azurerm_network_security_group.vm.id
}

# VM WINDOWS
resource "azurerm_windows_virtual_machine" "vm" {
  name                = "HEVM3"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  size           = "Standard_B1s"
  admin_username = "highexpert"
  admin_password = "SENHA_AQUI"

  network_interface_ids = [
    azurerm_network_interface.vm.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-smalldisk-g2"
    version   = "latest"
  }

  zone = "1"

  tags = {
    Project = "HubSpokeModern"
  }
}

# PEERING COM HUB
resource "azurerm_virtual_network_peering" "to_hub" {
  name                      = "HEVNet1-To-HEVNet3"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = "/subscriptions/5033dd87-aec9-4cd2-b1d4-008e415c6f53/resourceGroups/HEVNetRG1/providers/Microsoft.Network/virtualNetworks/HEVNet1"

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}