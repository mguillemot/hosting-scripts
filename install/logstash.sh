#!/bin/bash

# Logstash installation script.
# Doc: http://logstash.net/docs/1.4.0/repositories

echo "Installing Logstash..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Setting-up APT repository..."
wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' >> /etc/apt/sources.list

echo
echo "Updating repositories..."
apt-get update

echo
echo "Installing package..."
apt-get -y install openjdk-7-jre logstash

echo
echo "Put your configuration files into /etc/logstash/conf.d"
