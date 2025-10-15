# Stage 1: Base backend image
FROM tripleaio/transfer-api-server AS backend

# Stage 2: Nginx + Supervisor
FROM nginx:1.25-alpine

RUN apk add --no-cache supervisor curl

# Copy nginx and supervisor configs
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY supervisord.conf /etc/supervisord.conf

# Copy everything from the backend image (safe and small)
COPY --from=backend / /backend

# Expose the backend API port
EXPOSE 8860

# Start both backend and nginx via supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
