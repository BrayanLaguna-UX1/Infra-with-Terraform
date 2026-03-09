resource "aws_iam_instance_profile" "profinstance" {
    name = "instance-rule"
    role = aws_iam_role.ec2watch.name
}


resource "aws_iam_role" "ec2watch" {
   
    name = "ec2-Watch"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  
}


resource "aws_iam_role_policy_attachment" "attachpolicy" {
   role = aws_iam_role.ec2watch.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}