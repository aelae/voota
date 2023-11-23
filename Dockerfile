FROM teddysun/xray:1.8.6
WORKDIR /app
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
    apk update && \
    apk add nginx bash
ENV SERVER_DOMAIN="example.com" \
    SSL_CRT="/etc/xray/ssl/cert.pem" \
    SSL_KEY="/etc/xray/ssl/cert.key" 
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./config.json /etc/xray/config.json
COPY ./start.sh /app/start.sh
CMD ["/app/start.sh"]
