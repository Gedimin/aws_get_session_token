# aws_get_session_token
Getting session token

To get session token you should create in AWS Access Keys and put created credentials into mfa profile of aws credentials file.

Your file with aws credentials should be like:
```
[mfa]
aws_access_key_id = xxxx
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxx

[profile1]
aws_access_key_id = xxxx
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxx

[profile2]
aws_access_key_id = xxxx
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxx

....

[default]
aws_access_key_id = xxxx
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxx
```
