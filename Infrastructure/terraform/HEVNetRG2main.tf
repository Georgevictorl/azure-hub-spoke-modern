############################################
# RESOURCE GROUP
############################################

resource "azurerm_resource_group" "rg2" {
  name     = "HEVNetRG2"
  location = "Central US"
}

############################################
# APP SERVICE PLAN
############################################

resource "azurerm_service_plan" "app_plan" {
  name                = "ASP-HEVNetRG2-90e1"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name

  os_type  = "Linux"
  sku_name = "B1"
}

############################################
# APP SERVICE
############################################

resource "azurerm_linux_web_app" "app" {
  name                = "hewp001"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {}
}

############################################
# STORAGE ACCOUNT
############################################

resource "azurerm_storage_account" "storage" {
  name                     = "hewp001eed2886a83"
  resource_group_name      = azurerm_resource_group.rg2.name
  location                 = azurerm_resource_group.rg2.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
}

############################################
# MYSQL FLEXIBLE SERVER
############################################

resource "azurerm_mysql_flexible_server" "mysql" {
  name                   = "hewp001-eed2886a83-wpdbserver"
  resource_group_name    = azurerm_resource_group.rg2.name
  location               = azurerm_resource_group.rg2.location

  administrator_login    = "mysqladmin"
  administrator_password = "ChangeMe123!"

  sku_name = "B_Standard_B1ms"

  storage {
    size_gb = 32
  }

  version = "8.0"
}

############################################
# NETWORK SECURITY GROUP
############################################

resource "azurerm_network_security_group" "nsg" {
  name                = "HEWpNSG"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
}

resource "azurerm_network_security_rule" "mysql_rule" {
  name                        = "AllowDataTierInboundTCP3306"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = "10.0.0.0/25"
  destination_address_prefix  = "10.0.1.0/25"

  resource_group_name         = azurerm_resource_group.rg2.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

############################################
# ROUTE TABLE
############################################

resource "azurerm_route_table" "app_rt" {
  name                = "AppRT"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
}

resource "azurerm_route" "app_to_mgmt" {
  name                   = "AppToMgmt"
  resource_group_name    = azurerm_resource_group.rg2.name
  route_table_name       = azurerm_route_table.app_rt.name
  address_prefix         = "10.7.0.0/25"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.7.1.4"
}

############################################
# MANAGED IDENTITY
############################################

resource "azurerm_user_assigned_identity" "identity" {
  name                = "hewp001-eed2886a83-wpidentity"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
}

############################################
# FRONT DOOR PROFILE
############################################

resource "azurerm_cdn_frontdoor_profile" "fd" {
  name                = "afdheweb"
  resource_group_name = azurerm_resource_group.rg2.name
  sku_name            = "Premium_AzureFrontDoor"
}

############################################
# WAF POLICY
############################################

resource "azurerm_cdn_frontdoor_firewall_policy" "waf" {
  name                = "afdheweb"
  resource_group_name = azurerm_resource_group.rg2.name
  sku_name            = "Premium_AzureFrontDoor"

  enabled = true
  mode    = "Detection"
}