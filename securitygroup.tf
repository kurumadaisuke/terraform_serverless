############ フロント ############
resource "aws_security_group" "front-sg" {
  name        = "${var.project}-${var.environment}-front-sg"
  description = "web front role security group"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-front-sg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_security_group_rule" "http" {
  security_group_id = aws_security_group.front-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "80"
  to_port           = "80"
  cidr_blocks       = ["0.0.0.0/0"]
}

############ バックエンド ############

resource "aws_security_group" "web-sg" {
  name        = "${var.project}-${var.environment}-web-sg"
  description = "web backend role security group"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-web-sg"
    Project = var.project
    Env     = var.environment
  }
}

# resource "aws_security_group_rule" "http" {
#   security_group_id = aws_security_group.web-sg.id
#   type              = "ingress"
#   protocol          = "tcp"
#   from_port         = "80"
#   to_port           = "80"
#   cidr_blocks       = ["0.0.0.0/0"]
# }
