resource "aws_instance" "my_webserver" {
  ami                    = "ami-0c956e207f9d113d5"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver_security_group.id]
  user_data = templatefile("./utils/user_data.sh.tpl", {
    f_name = "Nikita",
    l_name = "Samartsev",
    names  = ["Vasya", "Petya"]
  })

  tags = {
    Name  = "My Web Server"
    Owner = "Nikita Samartsev"
  }

  depends_on = [aws_security_group.webserver_security_group]
}
