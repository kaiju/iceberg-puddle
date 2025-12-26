#!/usr/bin/env sh

GARAGE_RPC_HOST="$(/garage node id -q)"
CLUSTER_STATUS="$(/garage json-api GetClusterStatus)"
NODE_ID="$(echo "$CLUSTER_STATUS" | jq -r .'nodes[0].id')"

# If we haven't already applied a layout, let's do that
LAYOUT_VERSION="$(echo "$CLUSTER_STATUS" | jq -r '.layoutVersion')"
if [ "$LAYOUT_VERSION" -eq "0" ]; then
    /garage layout assign -z dc1 -c 1G "${NODE_ID}"
    /garage layout apply --version 1
fi

# Create our S3 bucket if we haven't already
if ! /garage bucket info datastore > /dev/null; then
    /garage bucket create datastore
fi

# Create our access key if we haven't already
if ! /garage key info storage-user > /dev/null; then
    /garage key create storage-user
fi

# Give our access key ownership over the bucket
/garage bucket allow --read --write --owner datastore --key storage-user

KEY_INFO="$(/garage json-api GetKeyInfo '{"search": "storage-user", "showSecretKey": true}')"

echo "$(echo "$KEY_INFO" | jq -r '.accessKeyId')" > /run/secrets/aws-access-key-id
echo "$(echo "$KEY_INFO" | jq -r '.secretAccessKey')" > /run/secrets/aws-secret-access-key

echo "-----------------------------------------"
echo "🎉 GARAGE BOOTSTRAP COMPLETE"
echo "-----------------------------------------"

echo "Access your object storage with the following config:" 
echo "export AWS_ACCESS_KEY_ID=$(cat /run/secrets/aws-access-key-id)"
echo "export AWS_SECRET_ACCESS_KEY=$(cat /run/secrets/aws-secret-access-key)"
echo "export AWS_DEFAULT_REGION=garage"
echo "export AWS_ENDPOINT_URL=http://localhost:3900"
