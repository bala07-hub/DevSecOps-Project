#!/bin/bash
# ============================================
# TechPulse Blog Platform - EC2 Setup Script
# Run this script on a fresh Ubuntu EC2 instance
# ============================================

set -e

echo "🛤️  Setting up TechPulse Blog Platform..."
echo "==========================================="

# --- Update system ---
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# --- Install Node.js 20.x ---
echo "📦 Installing Node.js 20.x..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "Node.js version: $(node -v)"
echo "npm version: $(npm -v)"

# --- Install PostgreSQL ---
echo "📦 Installing PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib

# --- Install Nginx ---
echo "📦 Installing Nginx..."
sudo apt install -y nginx

# --- Install PM2 (process manager) ---
echo "📦 Installing PM2..."
sudo npm install -g pm2

# --- Configure PostgreSQL ---
echo "🗄️  Configuring PostgreSQL..."
sudo -u postgres psql <<EOF
CREATE USER techpulse_user WITH PASSWORD 'techpulse_pass_2026';
CREATE DATABASE techpulse_db OWNER techpulse_user;
GRANT ALL PRIVILEGES ON DATABASE techpulse_db TO techpulse_user;
\c techpulse_db
GRANT ALL ON SCHEMA public TO techpulse_user;
EOF

echo "✅ PostgreSQL configured"

# --- Set up project directory ---
echo "📁 Setting up project..."
sudo mkdir -p /var/www/techpulse
sudo chown -R $USER:$USER /var/www/techpulse

# Copy project files (assumes you've transferred them to ~/techpulse)
cp -r ~/DevSecOps-Project/DecSecOps-TechPulse-Project/. /var/www/techpulse/

# --- Install backend dependencies ---
echo "📦 Installing backend dependencies..."
cd /var/www/techpulse/Backend
npm install --production

# --- Build frontend ---
echo "🔨 Building frontend..."
cd /var/www/techpulse/Frontend
npm install
npm run build

# --- Configure Nginx ---
echo "🌐 Configuring Nginx..."
sudo cp /var/www/techpulse/deploy/techpulse-nginx.conf /etc/nginx/sites-available/techpulse
sudo ln -sf /etc/nginx/sites-available/techpulse /etc/nginx/sites-enabled/techpulse
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl enable nginx

# --- Start backend with PM2 ---
echo "🚀 Starting backend with PM2..."
cd /var/www/techpulse/Backend
pm2 start src/index.js --name techpulse-backend
pm2 save
pm2 startup systemd -u $USER --hp /home/$USER | tail -1 | sudo bash

echo ""
echo "==========================================="
echo "🎉 techpulse is now live!"
echo "==========================================="
echo ""
echo "Access your blog at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null || echo '<your-ec2-public-ip>')"
echo ""
echo "Useful commands:"
echo "  pm2 status          - Check backend status"
echo "  pm2 logs            - View backend logs"
echo "  pm2 restart all     - Restart backend"
echo "  sudo systemctl restart nginx - Restart Nginx"
echo ""