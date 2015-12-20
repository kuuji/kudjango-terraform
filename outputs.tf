output "ip.front" {
  value = "${aws_instance.kudjango-front.aws_instance}"
}

output "ip.app00" {
  value = "${aws_instance.kudjango-app00.aws_instance}"
}

output "ip.app01" {
  value = "${aws_instance.kudjango-app01.aws_instance}"
}

output "ip.db" {
  value = "${aws_instance.kudjango-db.aws_instance}"
}
