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
  name       = "HEVNetRG1"
  tags       = {}
}
resource "azurerm_linux_virtual_machine" "res-1" {
  admin_password                                         = "" # Masked sensitive attribute
  admin_username                                         = "highexpert"
  allow_extension_operations                             = true
  availability_set_id                                    = ""
  bypass_platform_safety_checks_on_user_schedule_enabled = false
  capacity_reservation_group_id                          = ""
  computer_name                                          = "HEVM1"
  custom_data                                            = "" # Masked sensitive attribute
  dedicated_host_group_id                                = ""
  dedicated_host_id                                      = ""
  disable_password_authentication                        = false
  disk_controller_type                                   = "SCSI"
  edge_zone                                              = ""
  encryption_at_host_enabled                             = false
  eviction_policy                                        = ""
  extensions_time_budget                                 = "PT1H30M"
  license_type                                           = ""
  location                                               = "centralus"
  max_bid_price                                          = -1
  name                                                   = "HEVM1"
  network_interface_ids                                  = [azurerm_network_interface.res-6.id]
  os_managed_disk_id                                     = "/subscriptions/5033dd87-aec9-4cd2-b1d4-008e415c6f53/resourceGroups/HEVNetRG1/providers/Microsoft.Compute/disks/HEVM1_OsDisk_1_8895df683905451bb16b96f21efe4ae3"
  patch_assessment_mode                                  = "ImageDefault"
  patch_mode                                             = "ImageDefault"
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
  user_data                         = ""
  virtual_machine_scale_set_id      = ""
  vm_agent_platform_updates_enabled = false
  vtpm_enabled                      = false
  zone                              = ""
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
    name                             = "HEVM1_OsDisk_1_8895df683905451bb16b96f21efe4ae3"
    secure_vm_disk_encryption_set_id = ""
    security_encryption_type         = ""
    storage_account_type             = "StandardSSD_LRS"
    write_accelerator_enabled        = false
  }
  source_image_reference {
    offer     = "ubuntu-24_04-lts"
    publisher = "canonical"
    sku       = "server"
    version   = "latest"
  }
}
resource "azurerm_firewall" "res-2" {
  dns_proxy_enabled   = false
  dns_servers         = []
  firewall_policy_id  = azurerm_firewall_policy.res-4.id
  location            = "centralus"
  name                = "AzureFirewall"
  private_ip_ranges   = []
  resource_group_name = azurerm_resource_group.res-0.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Basic"
  tags = {
    Project = "HubSpokeModern"
  }
  threat_intel_mode = "Alert"
  zones             = []
  ip_configuration {
    name                 = "AzureFirewall-PI"
    public_ip_address_id = azurerm_public_ip.res-13.id
    subnet_id            = azurerm_subnet.res-18.id
  }
  management_ip_configuration {
    name                 = "AzureFirewall-Mgmt-PI"
    public_ip_address_id = azurerm_public_ip.res-12.id
    subnet_id            = "/subscriptions/5033dd87-aec9-4cd2-b1d4-008e415c6f53/resourceGroups/HEVNetRG1/providers/Microsoft.Network/virtualNetworks/HEVNet1/subnets/AzureFirewallManagementSubnet"
  }
}
resource "azurerm_bastion_host" "res-3" {
  copy_paste_enabled        = true
  file_copy_enabled         = false
  ip_connect_enabled        = false
  kerberos_enabled          = false
  location                  = "centralus"
  name                      = "AzureBastion"
  resource_group_name       = azurerm_resource_group.res-0.name
  scale_units               = 2
  session_recording_enabled = false
  shareable_link_enabled    = false
  sku                       = "Basic"
  tags = {
    Project = "HubSpokeModern"
  }
  tunneling_enabled  = false
  virtual_network_id = ""
  zones              = []
  ip_configuration {
    name                 = "IpConf"
    public_ip_address_id = azurerm_public_ip.res-15.id
    subnet_id            = azurerm_subnet.res-17.id
  }
}
resource "azurerm_firewall_policy" "res-4" {
  auto_learn_private_ranges_enabled = false
  base_policy_id                    = ""
  location                          = "centralus"
  name                              = "AzureFirewall"
  private_ip_ranges                 = []
  resource_group_name               = azurerm_resource_group.res-0.name
  sku                               = "Basic"
  tags                              = {}
  threat_intelligence_mode          = "Alert"
}
resource "azurerm_firewall_policy_rule_collection_group" "res-5" {
  firewall_policy_id = azurerm_firewall_policy.res-4.id
  name               = "DefaultNetworkRuleCollectionGroup"
  priority           = 200
  network_rule_collection {
    action   = "Allow"
    name     = "NRC"
    priority = 1000
    rule {
      description           = ""
      destination_addresses = ["*"]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports     = ["*"]
      name                  = "Allow-Any"
      protocols             = ["Any"]
      source_addresses      = ["*"]
      source_ip_groups      = []
    }
  }
}
resource "azurerm_network_interface" "res-6" {
  accelerated_networking_enabled = false
  auxiliary_mode                 = ""
  auxiliary_sku                  = ""
  dns_servers                    = []
  edge_zone                      = ""
  internal_dns_name_label        = ""
  ip_forwarding_enabled          = false
  location                       = "centralus"
  name                           = "hevm1205"
  resource_group_name            = azurerm_resource_group.res-0.name
  tags = {
    Project = "HubSpokeModern"
  }
  ip_configuration {
    gateway_load_balancer_frontend_ip_configuration_id = ""
    name                                               = "ipconfig1"
    primary                                            = true
    private_ip_address                                 = "10.7.2.4"
    private_ip_address_allocation                      = "Dynamic"
    private_ip_address_version                         = "IPv4"
    public_ip_address_id                               = azurerm_public_ip.res-14.id
    subnet_id                                          = azurerm_subnet.res-19.id
  }
}
resource "azurerm_network_interface_security_group_association" "res-7" {
  network_interface_id      = azurerm_network_interface.res-6.id
  network_security_group_id = azurerm_network_security_group.res-8.id
}
resource "azurerm_network_security_group" "res-8" {
  location            = "centralus"
  name                = "HEVM1-nsg"
  resource_group_name = azurerm_resource_group.res-0.name
  security_rule = [{
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "*"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "22"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "SSH"
    priority                                   = 300
    protocol                                   = "Tcp"
    source_address_prefix                      = "*"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
  }]
  tags = {
    Project = "HubSpokeModern"
  }
}
resource "azurerm_network_security_rule" "res-9" {
  access                                     = "Allow"
  description                                = ""
  destination_address_prefix                 = "*"
  destination_address_prefixes               = []
  destination_application_security_group_ids = []
  destination_port_range                     = "22"
  destination_port_ranges                    = []
  direction                                  = "Inbound"
  name                                       = "SSH"
  network_security_group_name                = "HEVM1-nsg"
  priority                                   = 300
  protocol                                   = "Tcp"
  resource_group_name                        = azurerm_resource_group.res-0.name
  source_address_prefix                      = "*"
  source_address_prefixes                    = []
  source_application_security_group_ids      = []
  source_port_range                          = "*"
  source_port_ranges                         = []
  depends_on = [
    azurerm_network_security_group.res-8,
  ]
}
resource "azurerm_private_dns_zone" "res-10" {
  name                = "highexpert.corp"
  resource_group_name = azurerm_resource_group.res-0.name
  tags = {
    Project = "HubSpokeModern"
  }
  soa_record {
    email        = "azureprivatedns-host.microsoft.com"
    expire_time  = 2419200
    minimum_ttl  = 10
    refresh_time = 3600
    retry_time   = 300
    tags         = {}
    ttl          = 3600
  }
}
resource "azurerm_private_dns_zone_virtual_network_link" "res-11" {
  name                  = "HEVNet1VNL"
  private_dns_zone_name = "highexpert.corp"
  registration_enabled  = true
  resolution_policy     = ""
  resource_group_name   = azurerm_resource_group.res-0.name
  tags                  = {}
  virtual_network_id    = azurerm_virtual_network.res-16.id
  depends_on = [
    azurerm_private_dns_zone.res-10,
  ]
}
resource "azurerm_public_ip" "res-12" {
  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  edge_zone               = ""
  idle_timeout_in_minutes = 4
  ip_tags                 = {}
  ip_version              = "IPv4"
  location                = "centralus"
  name                    = "AzureFirewall-Mgmt-PI"
  resource_group_name     = azurerm_resource_group.res-0.name
  sku                     = "Standard"
  sku_tier                = "Regional"
  tags = {
    Project = "HubSpokeModern"
  }
  zones = []
}
resource "azurerm_public_ip" "res-13" {
  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  edge_zone               = ""
  idle_timeout_in_minutes = 4
  ip_tags                 = {}
  ip_version              = "IPv4"
  location                = "centralus"
  name                    = "AzureFirewall-PI"
  resource_group_name     = azurerm_resource_group.res-0.name
  sku                     = "Standard"
  sku_tier                = "Regional"
  tags = {
    Project = "HubSpokeModern"
  }
  zones = []
}
resource "azurerm_public_ip" "res-14" {
  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  edge_zone               = ""
  idle_timeout_in_minutes = 4
  ip_tags                 = {}
  ip_version              = "IPv4"
  location                = "centralus"
  name                    = "HEVM1-PI"
  resource_group_name     = azurerm_resource_group.res-0.name
  sku                     = "Standard"
  sku_tier                = "Regional"
  tags = {
    Project = "HubSpokeModern"
  }
  zones = ["1", "2", "3"]
}
resource "azurerm_public_ip" "res-15" {
  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  edge_zone               = ""
  idle_timeout_in_minutes = 4
  ip_tags                 = {}
  ip_version              = "IPv4"
  location                = "centralus"
  name                    = "HEVNet1-IPv4"
  resource_group_name     = azurerm_resource_group.res-0.name
  sku                     = "Standard"
  sku_tier                = "Regional"
  tags = {
    Project = "HubSpokeModern"
  }
  zones = ["1", "2", "3"]
}
resource "azurerm_virtual_network" "res-16" {
  address_space                  = ["10.7.0.0/20"]
  bgp_community                  = ""
  dns_servers                    = []
  edge_zone                      = ""
  flow_timeout_in_minutes        = 0
  location                       = "centralus"
  name                           = "HEVNet1"
  private_endpoint_vnet_policies = "Disabled"
  resource_group_name            = azurerm_resource_group.res-0.name
  subnet = [{
    address_prefixes                              = ["10.7.1.0/26"]
    default_outbound_access_enabled               = false
    delegation                                    = []
    id                                            = "/subscriptions/5033dd87-aec9-4cd2-b1d4-008e415c6f53/resourceGroups/HEVNetRG1/providers/Microsoft.Network/virtualNetworks/HEVNet1/subnets/AzureFirewallSubnet"
    name                                          = "AzureFirewallSubnet"
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    route_table_id                                = ""
    security_group                                = ""
    service_endpoint_policy_ids                   = []
    service_endpoints                             = []
    }, {
    address_prefixes                              = ["10.7.2.0/25"]
    default_outbound_access_enabled               = false
    delegation                                    = []
    id                                            = "/subscriptions/5033dd87-aec9-4cd2-b1d4-008e415c6f53/resourceGroups/HEVNetRG1/providers/Microsoft.Network/virtualNetworks/HEVNet1/subnets/Management"
    name                                          = "Management"
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    route_table_id                                = ""
    security_group                                = ""
    service_endpoint_policy_ids                   = []
    service_endpoints                             = []
    }, {
    address_prefixes                              = ["10.7.4.0/26"]
    default_outbound_access_enabled               = false
    delegation                                    = []
    id                                            = "/subscriptions/5033dd87-aec9-4cd2-b1d4-008e415c6f53/resourceGroups/hevnetrg1/providers/Microsoft.Network/virtualNetworks/hevnet1/subnets/AzureFirewallManagementSubnet"
    name                                          = "AzureFirewallManagementSubnet"
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    route_table_id                                = ""
    security_group                                = ""
    service_endpoint_policy_ids                   = []
    service_endpoints                             = []
    }, {
    address_prefixes                              = ["10.7.5.0/26"]
    default_outbound_access_enabled               = false
    delegation                                    = []
    id                                            = "/subscriptions/5033dd87-aec9-4cd2-b1d4-008e415c6f53/resourceGroups/HEVNetRG1/providers/Microsoft.Network/virtualNetworks/HEVNet1/subnets/AzureBastionSubnet"
    name                                          = "AzureBastionSubnet"
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    route_table_id                                = ""
    security_group                                = ""
    service_endpoint_policy_ids                   = []
    service_endpoints                             = []
  }]
  tags = {
    Project = "HubSpokeModern"
  }
}
resource "azurerm_subnet" "res-17" {
  address_prefixes                              = ["10.7.5.0/26"]
  default_outbound_access_enabled               = false
  name                                          = "AzureBastionSubnet"
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = true
  resource_group_name                           = azurerm_resource_group.res-0.name
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
  sharing_scope                                 = ""
  virtual_network_name                          = "HEVNet1"
  depends_on = [
    azurerm_virtual_network.res-16,
  ]
}
resource "azurerm_subnet" "res-18" {
  address_prefixes                              = ["10.7.1.0/26"]
  default_outbound_access_enabled               = false
  name                                          = "AzureFirewallSubnet"
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = true
  resource_group_name                           = azurerm_resource_group.res-0.name
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
  sharing_scope                                 = ""
  virtual_network_name                          = "HEVNet1"
  depends_on = [
    azurerm_virtual_network.res-16,
  ]
}
resource "azurerm_subnet" "res-19" {
  address_prefixes                              = ["10.7.2.0/25"]
  default_outbound_access_enabled               = false
  name                                          = "Management"
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = true
  resource_group_name                           = azurerm_resource_group.res-0.name
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
  sharing_scope                                 = ""
  virtual_network_name                          = "HEVNet1"
  depends_on = [
    azurerm_virtual_network.res-16,
  ]
}
resource "azurerm_virtual_network_peering" "res-20" {
  allow_forwarded_traffic                = true
  allow_gateway_transit                  = false
  allow_virtual_network_access           = true
  local_subnet_names                     = []
  name                                   = "HEVNet3-To-HEVNet1"
  only_ipv6_peering_enabled              = false
  peer_complete_virtual_networks_enabled = true
  remote_subnet_names                    = []
  remote_virtual_network_id              = "/subscriptions/5033dd87-aec9-4cd2-b1d4-008e415c6f53/resourceGroups/HEVNetRG3/providers/Microsoft.Network/virtualNetworks/HEVNet3"
  resource_group_name                    = azurerm_resource_group.res-0.name
  use_remote_gateways                    = false
  virtual_network_name                   = "HEVNet1"
  depends_on = [
    azurerm_virtual_network.res-16,
  ]
}
resource "azurerm_virtual_network_peering" "res-21" {
  allow_forwarded_traffic                = true
  allow_gateway_transit                  = false
  allow_virtual_network_access           = true
  local_subnet_names                     = []
  name                                   = "HEWpVNet-to-HEVNet1"
  only_ipv6_peering_enabled              = false
  peer_complete_virtual_networks_enabled = true
  remote_subnet_names                    = []
  remote_virtual_network_id              = "/subscriptions/5033dd87-aec9-4cd2-b1d4-008e415c6f53/resourceGroups/HEVNetRG2/providers/Microsoft.Network/virtualNetworks/hewp001-eed2886a83-vnet"
  resource_group_name                    = azurerm_resource_group.res-0.name
  use_remote_gateways                    = false
  virtual_network_name                   = "HEVNet1"
  depends_on = [
    azurerm_virtual_network.res-16,
  ]
}
resource "azurerm_private_dns_a_record" "res-22" {
  name                = "gsa-9129e8dc-629b000000"
  records             = ["10.7.4.5"]
  resource_group_name = "hevnetrg1"
  tags                = {}
  ttl                 = 10
  zone_name           = "highexpert.corp"
  depends_on = [
    azurerm_private_dns_zone.res-10,
  ]
}
resource "azurerm_private_dns_a_record" "res-23" {
  name                = "gsa-9129e8dc-629b000001"
  records             = ["10.7.4.6"]
  resource_group_name = "hevnetrg1"
  tags                = {}
  ttl                 = 10
  zone_name           = "highexpert.corp"
  depends_on = [
    azurerm_private_dns_zone.res-10,
  ]
}
resource "azurerm_private_dns_a_record" "res-24" {
  name                = "hevm1"
  records             = ["10.7.2.4"]
  resource_group_name = "hevnetrg1"
  tags                = {}
  ttl                 = 10
  zone_name           = "highexpert.corp"
  depends_on = [
    azurerm_private_dns_zone.res-10,
  ]
}
resource "azurerm_private_dns_a_record" "res-25" {
  name                = "vm000000"
  records             = ["10.7.5.4"]
  resource_group_name = "hevnetrg1"
  tags                = {}
  ttl                 = 10
  zone_name           = "highexpert.corp"
  depends_on = [
    azurerm_private_dns_zone.res-10,
  ]
}
resource "azurerm_private_dns_a_record" "res-26" {
  name                = "vm000001"
  records             = ["10.7.5.5"]
  resource_group_name = "hevnetrg1"
  tags                = {}
  ttl                 = 10
  zone_name           = "highexpert.corp"
  depends_on = [
    azurerm_private_dns_zone.res-10,
  ]
}
resource "azurerm_subnet" "res-28" {
  address_prefixes                              = ["10.7.4.0/26"]
  default_outbound_access_enabled               = false
  name                                          = "AzureFirewallManagementSubnet"
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = true
  resource_group_name                           = "hevnetrg1"
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
  sharing_scope                                 = ""
  virtual_network_name                          = "hevnet1"
  depends_on = [
    azurerm_virtual_network.res-16,
  ]
}
