FROM tripleaio/transfer-api-server AS backend
FROM nginx:1.25-alpine

RUN apk add --no-cache supervisor curl

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY supervisord.conf /etc/supervisord.conf

COPY --from=backend / /backend

EXPOSE 8860
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
