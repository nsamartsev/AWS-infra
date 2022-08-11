module "webserver" {
  source           = "./instance-module"
  instance_profile = aws_iam_instance_profile.web_console_session_profile.id
  security_group   = aws_security_group.webserver_security_group.id
}