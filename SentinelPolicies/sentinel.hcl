module "tfplan-functions" {
    // source = "./tfplan-functions.sentinel"
    source = "https://github.com/hashicorp/terraform-guides/blob/master/governance/third-generation/common-functions/tfplan-functions/tfplan-functions.sentinel"
}

policy "restrict-databricks-clusters" {
    enforcement_level = "soft-mandatory"
}