#!/usr/bin/env sh

KEY_INFO="$(/garage json-api GetKeyInfo '{"search": "storage-user", "showSecretKey": true}')"
AWS_ACCESS_KEY_ID="$(echo "$KEY_INFO" | jq -r '.accessKeyId')"
AWS_SECRET_ACCESS_KEY="$(echo "$KEY_INFO" | jq -r '.secretAccessKey')"

curl -s http://lakekeeper:8181/management/v1/bootstrap \
    --json '{ "accept-terms-of-use": true }'

curl -s http://lakekeeper:8181/management/v1/warehouse \
    --json '{
        "warehouse-name": "datastore",
        "storage-profile": {
            "type": "s3",
            "bucket": "datastore",
            "endpoint": "http://garage:3900",
            "flavor": "s3-compat",
            "path-style-access": true,
            "region": "garage",
            "sts-enabled": false
        },
        "storage-credential": {
            "type": "s3",
            "credential-type": "access-key",
            "aws-access-key-id": "'"${AWS_ACCESS_KEY_ID}"'",
            "aws-secret-access-key": "'"${AWS_SECRET_ACCESS_KEY}"'"
        }
    }'
