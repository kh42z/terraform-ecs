resource "aws_ecr_repository" "ecr" {
  count                = length(var.image_names)
  name                 = var.image_names[count.index]
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
