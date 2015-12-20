output "ipfront" {
  value = "${aws_instance.kudjango-front.public_ip}"
}

output "ipapp00" {
  value = "${aws_instance.kudjango-app00.public_ip}"
}

output "ipapp01" {
  value = "${aws_instance.kudjango-app01.public_ip}"
}

output "ipdb" {
  value = "${aws_instance.kudjango-db.public_ip}"
}
