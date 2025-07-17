#!/bin/bash

# Set variables
HZ_VERSION="5.0.5"
HZ_USER="hazelcast"
HZ_GROUP="hazelcast"
HZ_INSTALL_DIR="/opt/hazelcast"
HZ_DOWNLOAD_DIR="/opt/hazelcast/downloads"
HZ_CONFIG_DIR="/opt/hazelcast/config"
HZ_LOGS_DIR="/opt/hazelcast/logs"
HZ_LOGS_ARCHIVED_DIR="/opt/hazelcast/logs/archived"
HZ_GITHUB_URL="https://github.com/hazelcast/hazelcast/releases/download/v$HZ_VERSION/hazelcast-$HZ_VERSION.zip"
HZ_BINARY_ZIP="hazelcast-$HZ_VERSION.zip"
HZ_SERVICE_FILE="/etc/systemd/system/hazelcast.service"

echo "Starting Hazelcast $HZ_VERSION installation..."

# Step 1: Create Hazelcast user and group if they don't exist
if ! id "$HZ_USER" &>/dev/null; then
    echo "Creating user: $HZ_USER"
    sudo useradd -r -s /bin/false "$HZ_USER"
fi

# Step 2: Ensure required directories exist
echo "Creating required directories..."
for DIR in "$HZ_DOWNLOAD_DIR" "$HZ_INSTALL_DIR" "$HZ_CONFIG_DIR" "$HZ_LOGS_DIR" "$HZ_LOGS_ARCHIVED_DIR"; do
    sudo mkdir -p "$DIR"
    sudo chown "$HZ_USER:$HZ_GROUP" "$DIR"
    sudo chmod 0755 "$DIR"
done

# Step 3: Download Hazelcast from GitHub
echo "Downloading Hazelcast $HZ_VERSION..."
sudo wget -q "$HZ_GITHUB_URL" -O "$HZ_DOWNLOAD_DIR/$HZ_BINARY_ZIP"

# Step 4: Extract Hazelcast zip file
echo "Extracting Hazelcast..."
sudo unzip -q "$HZ_DOWNLOAD_DIR/$HZ_BINARY_ZIP" -d "$HZ_INSTALL_DIR"
sudo chown -R "$HZ_USER:$HZ_GROUP" "$HZ_INSTALL_DIR"

# Step 5: Set execute permissions for Hazelcast scripts
echo "Setting execute permissions..."
sudo chmod 0760 "$HZ_INSTALL_DIR/bin/start.sh"
sudo chmod 0760 "$HZ_INSTALL_DIR/bin/stop-all.sh"

# Step 6: Ensure symlink to latest Hazelcast folder
echo "Creating symlink to latest Hazelcast installation..."
sudo ln -sfn "$HZ_INSTALL_DIR" "$HZ_DOWNLOAD_DIR/latest"
sudo chown -h "$HZ_USER:$HZ_GROUP" "$HZ_DOWNLOAD_DIR/latest"


# Step 8: Reload systemd, enable, and start Hazelcast service
echo "Enabling and starting Hazelcast service..."
sudo systemctl daemon-reload
sudo systemctl enable hazelcast
sudo systemctl start hazelcast

# Step 9: Verify Hazelcast is running
echo "Checking Hazelcast status..."
sudo systemctl status hazelcast --no-pager

echo "Hazelcast $HZ_VERSION installation completed successfully!"



######
sudo ln -sfn /opt/hazelcast /opt/hazelcast/latest && sudo chown -h hazelcast:hazelcast /opt/hazelcast/latest

 