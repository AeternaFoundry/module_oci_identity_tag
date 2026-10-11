resource "oci_identity_tag" "identity_tags" {
  for_each = var.identity_tags

  description      = each.value.description
  name             = each.value.name
  tag_namespace_id = each.value.tag_namespace_id
  defined_tags     = each.value.defined_tags
  freeform_tags    = each.value.freeform_tags
  is_cost_tracking = each.value.is_cost_tracking
  is_retired       = each.value.is_retired

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }

  dynamic "validator" {
    for_each = each.value.validator != null ? [each.value.validator] : []
    content {
      validator_type = validator.value.validator_type
      values         = validator.value.values
    }
  }
}

