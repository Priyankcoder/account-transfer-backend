# Stage 1: Get the official backend image
FROM tripleaio/transfer-api-server AS backend

# Stage 2: Build a minimal Nginx proxy layer that adds CORS
FROM nginx:1.25-alpine

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Install supervisord to run both processes
RUN apk add --no-cache supervisor curl

# Copy supervisord config
COPY supervisord.conf /etc/supervisord.conf

# Copy backend binary from first image
COPY --from=backend /app /app

# Expose the same port as backend
EXPOSE 8860

CMD [\"/usr/bin/supervisord\", \"-c\", \"/etc/supervisord.conf\"]
