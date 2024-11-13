#!/bin/bash

bios_id=$(sudo dmidecode -s system-serial-number)

# Print greeting
echo "initializing on $bios_id"

# Load environment variables
if [ -e ".env" ]; then
  source .env
else
  echo ".env file does not exist."
  exit 1
fi