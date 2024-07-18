#!/bin/sh

# Fetch the URL from the environment variable, use default if not set
url=${URL:-"http://192.168.1.1/cgi-bin/json/diagnoseStatus.json"}

# Cloudflare credentials from environment variables
zone_id=${CF_ZONE_ID}
dns_record_id=${CF_DNS_RECORD_ID}
auth_token=${CF_AUTH_TOKEN}
record_name=${CF_RECORD_NAME}
ttl=${CF_TTL:-3600}

# Fetch the JSON data
response=$(curl -s "$url")

# Extract the WanIP4 field using jq and get the first IP address
ip4=$(echo "$response" | jq -r '.WanIP4' | cut -d ',' -f 1)

# Print the extracted IP address
echo "Extracted IP: $ip4"

# Update Cloudflare DNS record
curl --request PUT \
  --url https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records/$dns_record_id \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer $auth_token" \
  --data '{
    "type": "A",
    "name": "'"${record_name}"'",
    "content": "'"${ip4}"'",
    "ttl": '"${ttl}"',
    "proxied": false
  }'

echo "DNS record updated successfully!"
