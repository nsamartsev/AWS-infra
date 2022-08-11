data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "web_console_session" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = "WebConsoleAccess"
}

resource "aws_iam_instance_profile" "web_console_session_profile" {
  role = aws_iam_role.web_console_session.id
}

resource "aws_iam_role_policy_attachment" "web_console_session_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.web_console_session.id
}