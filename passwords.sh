#!/bin/bash
set -o errexit
export AWS_PROFILE="${AWS_PROFILE:?Default AWS profile must be set}"
PASSWORD_RESET_REQUIRED="${PASSWORD_RESET_REQUIRED:?Whether require password reset must be set to YES or NO}"
DEFAULT_PASSWORD="${DEFAULT_PASSWORD:?Default password must be set}"
while read -r username
do
    if aws iam get-login-profile --user-name "$username" &> /dev/null
    then
        if [[ "$PASSWORD_RESET_REQUIRED" == "YES" ]]
        then
            output="$(aws iam update-login-profile \
                --user-name "$username" \
                --password "$DEFAULT_PASSWORD" \
                --password-reset-required)"
        else
            output="$(aws iam update-login-profile \
                --user-name "$username" \
                --password "$DEFAULT_PASSWORD" \
                --no-password-reset-required)"
        fi
        if [ $? -eq 0 ]
        then
            echo "OK update $username"
        else
            echo "KO update $username ($output)"
        fi
    else
        if [[ "$PASSWORD_RESET_REQUIRED" == "YES" ]]
        then
            output="$(aws iam create-login-profile \
                --user-name "$username" \
                --password "$DEFAULT_PASSWORD" \
                --password-reset-required)"
        else
            output="$(aws iam create-login-profile \
                --user-name "$username" \
                --password "$DEFAULT_PASSWORD" \
                --no-password-reset-required)"
        fi
        if [ $? -eq 0 ]
        then
            echo "OK create $username"
        else
            echo "KO create $username ($output)"
        fi
    fi
done < usernames.txt
