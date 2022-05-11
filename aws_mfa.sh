#!/bin/bash

ACCOUNT_ID=111111111111111
USER=test@test.com
E_BADARGS=65
MFA_DEVICE="arn:aws:iam::$ACCOUNT_ID:mfa/$USER"
AWS_CRED_FILE=~/.aws/credentials

if [ $# -ne 1 ]
then
  echo "Usage: `basename $0` <TOKEN_CODE from MFA device>"
  exit $E_BADARGS
fi

AWS_TEMP_CREDENTIALS=$(aws sts get-session-token --serial-number $MFA_DEVICE --token-code $1 --output text --profile mfa)
AWS_ACCESS_KEY_ID=$(echo "$AWS_TEMP_CREDENTIALS" | awk '{print $2}')
AWS_SECRET_ACCESS_KEY=$(echo "$AWS_TEMP_CREDENTIALS" | awk '{print $4}')
AWS_SESSION_TOKEN=$(echo "$AWS_TEMP_CREDENTIALS" | awk '{print $5}')

# Find [default] section and delete it till the EOF. Thus, the [default] section must be the latest.
sed -i '13,$ d' $AWS_CRED_FILE

# Populate [default] section with new session credentials
cat << EOF >> $AWS_CRED_FILE
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
aws_session_token = $AWS_SESSION_TOKEN
EOF
