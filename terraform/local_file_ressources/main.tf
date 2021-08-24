terraform {
  required_version = ">= 0.15"
  required_providers {
    local = { source = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}
resource "local_file" "literature" {
  filename = "summender_suma.txt"
  content  = <<-EOT
	Su su su sum sum summ,
	ich bin die summende suma biene
 EOT
}