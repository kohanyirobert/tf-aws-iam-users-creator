# Quick AWS IAM user creator

Quick and dirty IAM user creator for demos, etc.

- Add usernames to `usernames.txt` (see `usernames.txt.sample`)
- Set `AWS_PROFILE`
- Run `terraform apply`
- Run `./passwords.sh`
    - Set `PASSWORD_RESET_REQUIRED` and `DEFAULT_PASSWORD` environment variables
    - Save the password in `password.txt` (ignored by Git) to not forget it
- Clear `usernames.txt` and run `terraform apply` to delete/remove users
- Or `terraform destroy` to destroy them completely
- Run [`aws-nuke`](https://github.com/ekristen/aws-nuke) to clean up (see [`aws-nuke-config.yaml.sample`](aws-nuke-config.yaml.sample))
    - Usage: `/path/to/aws-nuke run -c aws-nuke-config.some-config.yaml`
