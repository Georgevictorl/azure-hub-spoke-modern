# Azure Modern Hub-Spoke Architecture

> Enterprise-grade Azure Hub-Spoke architecture focused on cloud-native modernization, centralized security, private connectivity, and modern application delivery.

---

# 📌 Overview

This project demonstrates the implementation of a modern enterprise architecture in Microsoft Azure using:

* Hub-Spoke Networking
* Azure Firewall
* Azure Bastion
* Azure Front Door
* Web Application Firewall (WAF)
* Private Endpoints
* Azure App Service
* Azure Database for MySQL Flexible Server
* Route Tables (UDR)
* Network Security Groups (NSGs)
* Private DNS Zones
* VNet Peering
* Cloud-native application architecture

The goal of this project was to simulate a secure and scalable enterprise environment following modern Azure architecture best practices.

---

# 🏗️ Architecture Overview

## 🔹 Resource Groups

| Resource Group | Purpose                       |
| -------------- | ----------------------------- |
| HEVNetRG1      | Hub Infrastructure            |
| HEVNetRG2      | Spoke Application Environment |

---

# 🌐 Hub-Spoke Topology

## Hub Network

```plaintext
HEVNet1
10.7.0.0/20
```

### Hub Subnets

| Subnet                        | Address Range | Purpose              |
| ----------------------------- | ------------- | -------------------- |
| Management                    | 10.7.2.0/25   | Management resources |
| AzureFirewallSubnet           | 10.7.1.0/26   | Azure Firewall       |
| AzureFirewallManagementSubnet | 10.7.4.0/26   | Firewall management  |
| AzureBastionSubnet            | 10.7.5.0/26   | Azure Bastion        |

---

## Spoke Network

The Spoke environment hosts the cloud-native WordPress application and database services.

### Components

* Azure App Service
* Azure Database for MySQL Flexible Server
* Azure Front Door
* Web Application Firewall (WAF)
* Private Endpoints
* NSGs
* Route Tables

---

# 🖥️ Virtual Machine

## Management VM

| VM    | Purpose                             |
| ----- | ----------------------------------- |
| HEVM1 | Management and connectivity testing |

### Features

* Ubuntu Server 24.04
* SSH access
* DNS resolution testing
* MySQL connectivity testing
* Bastion access

---

# 🚀 Application Architecture

## WordPress on Azure App Service

The application layer uses Azure App Service instead of traditional IIS virtual machines.

### Benefits

* PaaS architecture
* Managed scaling
* Reduced operational overhead
* Automatic patching
* Improved availability
* Cloud-native modernization

---

# 🗄️ Database Layer

## Azure Database for MySQL Flexible Server

The database layer was implemented using Azure Database for MySQL Flexible Server.

### Features

* Managed database service
* Private connectivity
* Integrated backup
* High availability capabilities
* Reduced infrastructure management

---

# 🔐 Security Architecture

## Azure Firewall

Centralized traffic inspection and filtering.

### Features

* Centralized security
* Traffic inspection
* East-West traffic control
* North-South traffic control
* Network rule collections
* Secure routing

---

## Azure Bastion

Secure browser-based access to virtual machines.

### Benefits

* No public SSH exposure
* Zero Trust approach
* Secure management access
* Reduced attack surface

---

## Web Application Firewall (WAF)

Integrated with Azure Front Door.

### Features

* Layer 7 protection
* OWASP protection
* Global edge security
* HTTP/HTTPS inspection

---

## Network Security Groups (NSGs)

Implemented to restrict communication between subnets and services.

### Security Controls

* Controlled MySQL access
* Explicit allow rules
* Deny all inbound strategy
* Segmentation between tiers

---

# 🌍 Connectivity

## VNet Peering

Private connectivity between Hub and Spoke VNets.

### Benefits

* Low latency
* Microsoft backbone network
* Secure communication
* Simplified network topology

---

# 🧭 Routing

## User Defined Routes (UDR)

Traffic routing through Azure Firewall.

### Example

```plaintext
0.0.0.0/0 → Azure Firewall
```

### Purpose

* Centralized inspection
* Forced tunneling
* Traffic control
* Security enforcement

---

# 🧠 Private DNS

## Azure Private DNS Zones

Used for internal name resolution between services.

### Features

* Private database resolution
* Internal-only communication
* Automatic registration
* Secure service discovery

---

# 🌐 Azure Front Door

Azure Front Door was used as the global entry point for the application.

### Features

* Global load balancing
* SSL offloading
* Edge security
* WAF integration
* Improved user latency
* Modern application delivery

---

# 🔒 Private Endpoints

Private Endpoints were implemented to eliminate public exposure of critical services.

### Benefits

* Private connectivity
* Reduced attack surface
* Secure PaaS integration
* Internal-only communication

---

# 🚦 Application Flow

```plaintext
Internet
   ↓
Azure Front Door + WAF
   ↓
Azure Firewall
   ↓
Azure App Service
   ↓
Private Endpoint
   ↓
Azure Database for MySQL
```

---

# 📚 Concepts Practiced

This project covered:

* Hub-Spoke Architecture
* Cloud-native modernization
* Azure App Service
* Azure Front Door
* Web Application Firewall
* Private Endpoints
* Azure Firewall
* Azure Bastion
* NSGs
* Route Tables
* VNet Peering
* Private DNS
* PaaS Architecture
* Zero Trust concepts
* Secure application delivery
* Azure networking
* Cloud security

---

# 💰 FinOps Considerations

## Hidden Costs Identified

* Azure Firewall hourly cost
* Bastion hourly cost
* Front Door requests and bandwidth
* WAF policy charges
* VNet peering traffic
* Private Endpoint charges
* Log Analytics ingestion
* MySQL backup storage
* Public IP charges

---

# ⚖️ Architecture Comparison

| Traditional Architecture | Modern Architecture   |
| ------------------------ | --------------------- |
| IIS on VM                | Azure App Service     |
| SQL Server on VM         | MySQL Flexible Server |
| Internal Load Balancer   | Azure Front Door      |
| Public DB access         | Private Endpoint      |
| Manual patching          | Managed services      |
| VM-centric               | PaaS / Cloud-native   |

---

# 🎯 Learning Objectives

This project was designed to:

* Learn modern Azure architecture
* Understand cloud-native services
* Implement secure networking
* Practice enterprise security concepts
* Simulate real-world environments
* Prepare for Azure Solutions Architect scenarios
* Understand modernization strategies
* Practice FinOps analysis

---

# 🛠️ Technologies Used

* Microsoft Azure
* Azure Virtual Network
* Azure Firewall
* Azure Bastion
* Azure Front Door
* Web Application Firewall (WAF)
* Azure App Service
* Azure Database for MySQL Flexible Server
* Azure NSG
* Azure Route Tables
* Azure Private DNS
* Private Endpoints
* Ubuntu Server
* WordPress
* SSH
* Terraform

---

# 📸 Screenshots

The following screenshots will be added:

* Resource Groups
* Hub topology
* Spoke topology
* VNet Peering
* Azure Firewall Policy
* Route Tables
* NSG Rules
* Azure Front Door
* WAF Policy
* Private Endpoint
* App Service Networking
* MySQL Private DNS
* WordPress Application
* Bastion Overview

---

# 📦 Infrastructure as Code

## Terraform

Terraform templates will be included for:

* Resource Groups
* VNets
* Subnets
* NSGs
* Route Tables
* Azure Firewall
* Bastion
* App Service
* Front Door
* WAF
* Private Endpoints

---

# 🔄 Future Improvements

Planned future improvements:

* CI/CD pipelines
* GitHub Actions
* Azure DevOps
* AKS migration
* Application Gateway
* Defender for Cloud
* Azure Monitor
* Log Analytics
* Sentinel integration
* Terraform modules
* Landing Zones
* CAF implementation

---

# 👨‍💻 Author

Project developed for advanced studies in:

* Azure Architecture
* Cloud Engineering
* Cloud Security
* FinOps
* Application Modernization
* Azure Networking
* AZ-305 Preparation

---

# 📌 Notes

This project was created for educational and laboratory purposes.

The architecture demonstrates a transition from traditional infrastructure-based applications to modern cloud-native Azure services.

The environment was intentionally designed following enterprise-grade security and networking best practices.

---

# ⭐ Key Takeaways

This project demonstrates practical experience with:

* Enterprise networking
* Hub-Spoke topology
* Cloud-native modernization
* Azure security services
* PaaS adoption
* Private connectivity
* Secure application publishing
* Zero Trust principles
* Modern Azure architecture
