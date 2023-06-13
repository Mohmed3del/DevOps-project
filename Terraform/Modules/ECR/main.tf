# resource "aws_ecr_repository" "ecr" {
#   name                 = "repo"
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }
resource "aws_ecr_repository" "ecr" {
  for_each = var.ecr_repositories

  name                 = each.key
  image_tag_mutability = each.value.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }
}