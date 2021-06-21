resource "aws_cloudwatch_log_group" "cw" {
  name = "${var.env_prefix}-cw"
  retention_in_days = 1
}