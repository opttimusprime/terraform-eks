output "elk_private_ip" {
  value = aws_instance.elk.private_ip
}

output "kibana_url" {
  value = "https://kibana.${var.domain_name}"
}

output "logstash_endpoint" {
  value = "${aws_instance.elk.private_ip}:5044"
}

output "elasticsearch_endpoint" {
  value = "http://${aws_instance.elk.private_ip}:9200"
}