module "tfplan-functions" {
    source = "tfplan-functions.sentinel"
}

policy "restrict-databricks-clusters" {
    enforcement_level = "soft-mandatory"
}