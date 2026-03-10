# ---------- 1) Build Stage ----------
# Use official Node 16 image to install deps and build the React app
FROM node:16 AS builder

# Set working directory
WORKDIR /app

# Install dependencies first (leverages Docker layer caching)
COPY package*.json ./
RUN npm ci --no-audit --no-fund

# Copy the rest of the source and build
COPY . .
RUN npm run build

# ---------- 2) Runtime Stage ----------
# Use a tiny Nginx image to serve static files
FROM nginx:alpine AS runner
# that supports client-side routing for SPAs
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the production build from the builder stage
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80 (Nginx default)
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]