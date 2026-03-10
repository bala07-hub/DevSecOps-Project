# ---------- 1) Build Stage ----------
# Use Node 16 to install dependencies and build the app
FROM node:16 AS builder
# Set working directory
WORKDIR /app
# Copy dependency manifests and install (cached layer)
COPY package*.json ./
RUN npm ci --no-audit --no-fund || npm install --no-audit --no-fund
COPY . .
RUN npm run build
# ---------- 2) Runtime Stage ----------
# Serve the static build with Nginx
FROM nginx:alpine AS runner
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Copy the production build from builder
COPY --from=builder /app/build /usr/share/nginx/html
# Expose Nginx port
EXPOSE 80
# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]