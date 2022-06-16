#!/bin/sh

mkdir /srv/nginx/config

echo -e "user  nginx;\nworker_processes  auto;\n\nerror_log  /var/log/nginx/error.log notice;\npid        /var/run/nginx.pid;\n\n\nevents {\n    worker_connections  1024;\n}\n\n\nhttp {\n    include       /etc/nginx/mime.types;\n    default_type  application/octet-stream;\n\n    log_format  main  '\$remote_addr - \$remote_user [\$time_local] \"\$request\" '\n                      '\$status \$body_bytes_sent \"\$http_referer\" '\n                      '\"\$http_user_agent\" \"\$http_x_forwarded_for\"';\n\n    access_log  /var/log/nginx/access.log  main;\n\n    sendfile        on;\n    #tcp_nopush     on;\n\n    keepalive_timeout  65;\n\n    #gzip  on;\n\n    include /etc/nginx/conf.d/*.conf;\n}" >> /srv/nginx/config/nginx.conf

docker pull nginx
docker run -d --name=nginx -p 80:80 -v /srv/nginx/config/nginx.conf:/etc/nginx/nginx.conf nginx

