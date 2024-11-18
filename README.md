# Quick AWS IAM user creator

Quick and dirty IAM user creator for demos, etc.

- Add usernames to `usernames.txt` (see `usernames.txt.sample`)
- Set `AWS_PROFILE`
- Run `terraform apply`
- Run `./passwords.sh`
    - Set `PASSWORD_RESET_REQUIRED` and `DEFAULT_PASSWORD` environment variables
- Clear `usernames.txt` and run `terraform apply` to delete users
- Run [`aws-nuke`](https://github.com/ekristen/aws-nuke) to clean up (see [`aws-nuke-config.yaml.sample`](aws-nuke-config.yaml.sample))