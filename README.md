# Reactive Ops Technical Challenge

## How to Use
- Create aws key pair
  - I performed via their web console on the appropriate region
  - I believe this can be automated via the aws cli or even terraform itself
- Configure env vars
  - TF_VAR_priv_key_path: Path to a suitable Private key for ssh access
  - TF_VAR_region: region to deploy ec2 instance into
  - TF_VAR_username: key-pair username from aws key pair creation
- Run Terraform commands
  - In this case, run
    ```bash
    terraform apply --auto-approve
    ```
- If successful, stdout should have an output variable that is the public ip of
  the instance
- To test access, perform
  ```bash
  curl <public_ip_here>
  ```

## Endgame
- Functioning EC2 host with a web app running accessible via web address
- Single script execution with terminal output line of web address

## Strategy
- [x] Develop Simple Application w/ Flask and Pipenv
- [x] Dockerize web application
- [x] Publish to docker registry
- [x] Manually create Key Pairs in EC2 for myself (unsure of automation
  available)
- [x] Automate Instance/SecGroup/Ingress/Egress creation via Terraform
- [x] Automate Docker Installation on webhost
- [x] Automate Docker container pull, start, and network exposing

## User Configuration
- [x] Handle environment variable definition (TF, AWS)
