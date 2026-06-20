#!/bin/bash
set -e

KIBANA_URL="${kibana_url}"

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

cat >/etc/yum.repos.d/elastic.repo <<'EOF'
[elastic-8.x]
name=Elastic repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

dnf update -y
dnf install -y java-17-amazon-corretto elasticsearch logstash kibana

cat >/etc/elasticsearch/elasticsearch.yml <<'EOF'
cluster.name: roboshop-elk
node.name: elk-single-node
network.host: 0.0.0.0
http.port: 9200

discovery.type: single-node

xpack.security.enabled: false
xpack.security.enrollment.enabled: false
xpack.security.http.ssl.enabled: false
xpack.security.transport.ssl.enabled: false
EOF

cat >/etc/logstash/conf.d/roboshop.conf <<'EOF'
input {
  beats {
    port => 5044
  }
}

filter {
  if [kubernetes][namespace] {
    mutate {
      add_field => { "k8s_namespace" => "%%{[kubernetes][namespace]}" }
    }
  }
}

output {
  elasticsearch {
    hosts => ["http://127.0.0.1:9200"]
    index => "roboshop-logs-%%{+YYYY.MM.dd}"
  }

  stdout {
    codec => rubydebug
  }
}
EOF

cat >/etc/kibana/kibana.yml <<EOF
server.port: 5601
server.host: "0.0.0.0"
server.publicBaseUrl: "${KIBANA_URL}"

elasticsearch.hosts: ["http://127.0.0.1:9200"]
EOF

systemctl daemon-reload

systemctl enable elasticsearch
systemctl restart elasticsearch

sleep 40

systemctl enable logstash
systemctl restart logstash

systemctl enable kibana
systemctl restart kibana