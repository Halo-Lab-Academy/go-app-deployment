resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.project_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  provisioner "local-exec" {
    command = <<EOF
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 695431053686.dkr.ecr.us-east-1.amazonaws.com
    docker build -t ${var.project_name} "../../"
    docker tag ${var.project_name}:latest 695431053686.dkr.ecr.us-east-1.amazonaws.com/${var.project_name}:latest
    docker push 695431053686.dkr.ecr.us-east-1.amazonaws.com/${var.project_name}:latest
    EOF
  }
}