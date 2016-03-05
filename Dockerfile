FROM scratch
MAINTAINER Ivan Porto Carrero <ivan@flanders.co.nz>

# add ca-certificates from january 2016
ADD ./ca-certificates.crt /etc/ssl/certs/ca-certificates.txt

# add apaches mime.types
ADD https://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types /etc/mime.types

# extract executable to root
ADD ./caddy.tar.gz /
ADD Caddyfile /etc/caddy/Caddyfile

VOLUME /etc/caddy
VOLUME /var/www
VOLUME /var/run/caddy

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/caddy", "-agree=true", "-conf=/etc/caddy/Caddyfile"]
