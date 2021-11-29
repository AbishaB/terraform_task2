#working output.tf

output "firewall_rules" {
  value       = module.firewall_rules.firewall_rules
  description = "The created firewall rule resources"
}


#org output.tf-----
# output "firewall_rules" {
#   value       = google_compute_firewall.rules
#   description = "The created firewall rule resources"
# }
