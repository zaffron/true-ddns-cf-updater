# DNS updater for True Online Fiber
This docker image will help you update the DNS record with ipv4 address for your website for those routers where if you enter the following you get the router status:

http://192.168.1.1/cgi-bin/json/diagnoseStatus.json

Network mode must be host


Log into your Cloudflare account and go to your API Tokens under 'My Profile'.

Create a new API token (or use an existing one) with permissions to edit DNS settings. Make sure to store the token securely.

With the token ready, use a tool like cURL or Postman to make a request to the Cloudflare API endpoint to list your DNS records.
Here's a cURL example:

```
curl --location 'https://api.cloudflare.com/client/v4/zones/{ZONE_ID}/dns_records' \
--header 'Authorization: Bearer {TOKEN_WITH_DNS_EDIT_PERMISSION}'
```

Replace [ZONE_ID] with your Cloudflare zone ID (you can find this in your site's dashboard), and [TOKEN_WITH_DNS_EDIT_PERMISSION] with the actual API token.

The response will include details about each DNS record, including the record IDs.

checkout the docker compose for setup
