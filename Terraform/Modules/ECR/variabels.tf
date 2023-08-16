variable "ecr_repositories" {
  type = map(object({
    image_tag_mutability = string
    scan_on_push         = bool
    force_delete         = bool
  }))

  #   default = {
  #     repo1 = {
  #       image_tag_mutability = "MUTABLE"
  #       scan_on_push         = true
  #     },
  #     repo2 = {
  #       image_tag_mutability = "IMMUTABLE"
  #       scan_on_push         = false
  #     }
  #   }
}
