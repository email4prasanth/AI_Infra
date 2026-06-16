// Create Network Security Group for Virtual Machine backend
resource "azurerm_network_security_group" "vm_sg_backend" {
  name                = "${terraform.workspace}-${local.project_name.name}-vm-sg-backend"
  resource_group_name = azurerm_resource_group.aitest_assist_resource_group.name
  location            = azurerm_resource_group.aitest_assist_resource_group.location
  tags                = local.tags
}

// Rule for Virtual Machine backend network security group
resource "azurerm_network_security_rule" "vm_sg_rule_backend" {
  for_each                    = { for rule in local.backend_security_group_rules[terraform.workspace] : rule.name => rule }
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.aitest_assist_resource_group.name
  network_security_group_name = azurerm_network_security_group.vm_sg_backend.name
  depends_on                  = [azurerm_network_security_group.vm_sg_backend]
}

// Network group association for Virtual Machine Subnet
resource "azurerm_subnet_network_security_group_association" "network_group_association_backend" {
  subnet_id                 = azurerm_subnet.vm_backend_subnet.id
  network_security_group_id = azurerm_network_security_group.vm_sg_backend.id
}