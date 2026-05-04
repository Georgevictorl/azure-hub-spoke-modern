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
resource "azurerm_resource_group" "res-0" {
  location   = "centralus"
  managed_by = ""
  name       = "HEVNetRG3"
  tags       = {}
}
resource "azurerm_windows_virtual_machine" "res-1" {
  admin_password                                         = "" # Masked sensitive attribute
  admin_username                                         = "highexpert"
  allow_extension_operations                             = true
  automatic_updates_enabled                              = true
  availability_set_id                                    = ""
  bypass_platform_safety_checks_on_user_schedule_enabled = false
  capacity_reservation_group_id                          = ""
  computer_name                                          = "HEVM3"
  custom_data                                            = "" # Masked sensitive attribute
  dedicated_host_group_id                                = ""
  dedicated_host_id                                      = ""
  disk_controller_type                                   = "SCSI"
  edge_zone                                              = ""
  enable_automatic_updates                               = true
  encryption_at_host_enabled                             = false
  eviction_policy                                        = ""
  extensions_time_budget                                 = "PT1H30M"
  hotpatching_enabled                                    = false
  license_type                                           = ""
  location                                               = "centralus"
  max_bid_price                                          = -1
  name                                                   = "HEVM3"
  network_interface_ids                                  = [azurerm_network_interface.res-2.id]
  os_managed_disk_id                                     = "/subscriptions/5033dd87-aec9-4cd2-b1d4-008e415c6f53/resourceGroups/HEVNetRG3/providers/Microsoft.Compute/disks/HEVM3_OsDisk_1_045bc83d216d4d4abb12324dd8553c10"
  patch_assessment_mode                                  = "ImageDefault"
  patch_mode                                             = "AutomaticByOS"
  platform_fault_domain                                  = -1
  priority                                               = "Regular"
  provision_vm_agent                                     = true
  proximity_placement_group_id                           = ""
  reboot_setting                                         = ""
  resource_group_name                                    = azurerm_resource_group.res-0.name
  secure_boot_enabled                                    = false
  size                                                   = "Standard_B1s"
  source_image_id                                        = ""
  tags = {
    Project = "HubSpokeModern"
  }
  timezone                          = ""
  user_data                         = ""
  virtual_machine_scale_set_id      = ""
  vm_agent_platform_updates_enabled = true
  vtpm_enabled                      = false
  zone                              = "1"
  additional_capabilities {
    hibernation_enabled = false
    ultra_ssd_enabled   = false
  }
  boot_diagnostics {
    storage_account_uri = ""
  }
  os_disk {
    caching                          = "ReadWrite"
    disk_encryption_set_id           = ""
    disk_size_gb                     = 30
    name                             = "HEVM3_OsDisk_1_045bc83d216d4d4abb12324dd8553c10"
    secure_vm_disk_encryption_set_id = ""
    security_encryption_type         = ""
    storage_account_type             = "Premium_LRS"
    write_accelerator_enabled        = false
  }
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2022-datacenter-smalldisk-g2"
    version   = "latest"
  }
}
resource "azurerm_network_interface" "res-2" {
  accelerated_networking_enabled = false
  auxiliary_mode                 = ""
  auxiliary_sku                  = ""
  dns_servers                    = []
  edge_zone                      = ""
  internal_dns_name_label        = ""
  ip_forwarding_enabled          = false
  location                       = "centralus"
  name                           = "hevm3494_z1"
  resource_group_name            = azurerm_resource_group.res-0.name
  tags = {
    Project = "HubSpokeModern"
  }
  ip_configuration {
    gateway_load_balancer_frontend_ip_configuration_id = ""
    name                                               = "ipconfig1"
    primary                                            = true
    private_ip_address                                 = "172.16.0.4"
    private_ip_address_allocation                      = "Dynamic"
    private_ip_address_version                         = "IPv4"
    public_ip_address_id                               = ""
    subnet_id                                          = "/subscriptions/5033dd87-aec9-4cd2-b1d4-008e415c6f53/resourceGroups/HEVNetRG3/providers/Microsoft.Network/virtualNetworks/HEVNet3/subnets/default"
  }
  depends_on = [
    # One of azurerm_subnet.res-8,azurerm_subnet_route_table_association.res-9 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_network_interface_security_group_association" "res-3" {
  network_interface_id      = azurerm_network_interface.res-2.id
  network_security_group_id = azurerm_network_security_group.res-4.id
}
resource "azurerm_network_security_group" "res-4" {
  location            = "centralus"
  name                = "HEVM3-nsg"
  resource_group_name = azurerm_resource_group.res-0.name
  security_rule       = []
  tags = {
    Project = "HubSpokeModern"
  }
}
resource "azurerm_route_table" "res-5" {
  bgp_route_propagation_enabled = true
  location                      = "centralus"
  name                          = "DevRT"
  resource_group_name           = azurerm_resource_group.res-0.name
  route = [{
    address_prefix         = "10.0.0.0/23"
    name                   = "DevToPrd"
    next_hop_in_ip_address = "10.7.1.4"
    next_hop_type          = "VirtualAppliance"
  }]
  tags = {
    Project = "HubSpokeModern"
  }
}
resource "azurerm_route" "res-6" {
  address_prefix         = "10.0.0.0/23"
  name                   = "DevToPrd"
  next_hop_in_ip_address = "10.7.1.4"
  next_hop_type          = "VirtualAppliance"
  resource_group_name    = azurerm_resource_group.res-0.name
  route_table_name       = "DevRT"
  depends_on = [
    azurerm_route_table.res-5,
  ]
}
resource "azurerm_virtual_network" "res-7" {
  address_space                  = ["172.16.0.0/16"]
  bgp_community                  = ""
  dns_servers                    = []
  edge_zone                      = ""
  flow_timeout_in_minutes        = 0
  location                       = "centralus"
  name                           = "HEVNet3"
  private_endpoint_vnet_policies = "Disabled"
  resource_group_name            = azurerm_resource_group.res-0.name
  subnet = [{
    address_prefixes                              = ["172.16.0.0/24"]
    default_outbound_access_enabled               = false
    delegation                                    = []
    id                                            = azurerm_subnet_route_table_association.res-9.id
    name                                          = "default"
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    route_table_id                                = azurerm_route_table.res-5.id
    security_group                                = ""
    service_endpoint_policy_ids                   = []
    service_endpoints                             = []
  }]
  tags = {
    Project = "HubSpokeModern"
  }
}
resource "azurerm_subnet" "res-8" {
  address_prefixes                              = ["172.16.0.0/24"]
  default_outbound_access_enabled               = false
  name                                          = "default"
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = true
  resource_group_name                           = azurerm_resource_group.res-0.name
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
  sharing_scope                                 = ""
  virtual_network_name                          = "HEVNet3"
  depends_on = [
    azurerm_virtual_network.res-7,
  ]
}
resource "azurerm_subnet_route_table_association" "res-9" {
  route_table_id = azurerm_route_table.res-5.id
  subnet_id      = azurerm_subnet.res-8.id
}
resource "azurerm_virtual_network_peering" "res-10" {
  allow_forwarded_traffic                = true
  allow_gateway_transit                  = false
  allow_virtual_network_access           = true
  local_subnet_names                     = []
  name                                   = "HEVNet1-To-HEVNet3"
  only_ipv6_peering_enabled              = false
  peer_complete_virtual_networks_enabled = true
  remote_subnet_names                    = []
  remote_virtual_network_id              = "/subscriptions/5033dd87-aec9-4cd2-b1d4-008e415c6f53/resourceGroups/HEVNetRG1/providers/Microsoft.Network/virtualNetworks/HEVNet1"
  resource_group_name                    = azurerm_resource_group.res-0.name
  use_remote_gateways                    = false
  virtual_network_name                   = "HEVNet3"
  depends_on = [
    azurerm_virtual_network.res-7,
  ]
}
