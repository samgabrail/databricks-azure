variable "prefix" {
  description = "This prefix will be included in the name of most resources."
  default = "samg"
}

variable "location" {
  description = "The region"
  default     = "centralus"
}

variable "spark_version" {
  description = "Spark Runtime Version for databricks clusters"
  default     = "7.3.x-scala2.12"
}

variable "node_type_id" {
  description = "Type of worker nodes for databricks clusters"
  default     = "Standard_DS3_v2"
}
