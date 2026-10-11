variable "identity_tags" {
  description = <<EOT
Map of identity_tags, attributes below
Required:
    - description
    - name
    - tag_namespace_id
Optional:
    - defined_tags
    - freeform_tags
    - is_cost_tracking
    - is_retired
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
    - validator (block):
        - validator_type (required)
        - values (required)
EOT

  type = map(object({
    description      = string
    name             = string
    tag_namespace_id = string
    defined_tags     = optional(map(string))
    freeform_tags    = optional(map(string))
    is_cost_tracking = optional(bool)
    is_retired       = optional(bool)
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    validator = optional(object({
      validator_type = string
      values         = list(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.identity_tags : (
        v.validator == null || (contains([for v in ["ENUM"] : lower(v)], lower(v.validator.validator_type)))
      )
    ])
    error_message = "must be one of: \"ENUM\""
  }
}

