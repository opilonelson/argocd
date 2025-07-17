#!/bin/bash

# Define variables
TOMCAT_VERSION_NEW="9.0.100"
TOMCAT_VERSION_OLD="9.0.46"
TOMCAT_USER="tomcat"
INSTALL_DIR="/opt/tomcat"
BACKUP_DIR="/opt/tomcat_backup_$(date +%F_%T)"
TOMCAT_URL="https://downloads.apache.org/tomcat/tomcat-9/v$TOMCAT_VERSION_NEW/bin/apache-tomcat-$TOMCAT_VERSION_NEW.tar.gz"

echo "Starting Tomcat upgrade from $TOMCAT_VERSION_OLD to $TOMCAT_VERSION_NEW "

# Step 1: Stop Tomcat
echo "Stopping Tomcat service..."
sudo systemctl stop tomcat

# Step 2: Backup existing Tomcat installation
echo "Backing up current Tomcat version..."
sudo mv $INSTALL_DIR $BACKUP_DIR

# Step 3: Download and Extract new Tomcat version
echo "Downloading Apache Tomcat $TOMCAT_VERSION_NEW..."
wget -q $TOMCAT_URL -O /tmp/apache-tomcat.tar.gz

echo "Extracting Tomcat..."
sudo mkdir -p $INSTALL_DIR
sudo tar -xzf /tmp/apache-tomcat.tar.gz -C $INSTALL_DIR --strip-components=1

# Step 4: Restore configuration and web apps
echo "Restoring configuration and web applications..."
sudo cp -r $BACKUP_DIR/conf $INSTALL_DIR/
sudo cp -r $BACKUP_DIR/webapps $INSTALL_DIR/
sudo cp -r $BACKUP_DIR/lib $INSTALL_DIR/
sudo cp -r $BACKUP_DIR/logs $INSTALL_DIR/
sudo cp -r $BACKUP_DIR/temp $INSTALL_DIR/
sudo cp -r $BACKUP_DIR/work $INSTALL_DIR/

# Step 5: Set appropriate permissions
echo "Setting file permissions..."
sudo chown -R $TOMCAT_USER:$TOMCAT_USER $INSTALL_DIR
sudo chmod -R 755 $INSTALL_DIR

# Step 6: Start Tomcat service
echo "Starting Tomcat..."
sudo systemctl start tomcat

# Step 7: Verify installation
echo "Checking Tomcat version..."
curl -s http://localhost:8080 | grep "Apache Tomcat" || echo "Tomcat may not be running. Check logs."

echo "Tomcat upgrade to version $TOMCAT_VERSION_NEW completed successfully!"


###################
Steps to follow