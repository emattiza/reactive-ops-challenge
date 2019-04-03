# Reactive Ops Technical Challenge

## Wrapper Usage
- To utilize, simply enter:
```bash
./create-server.sh
```

## How to Use
- Configure env vars (via export, .envrc and direnv, etc.)
  - AWS_ACCESS_KEY_ID: Set to suitable access key id
  - AWS_SECRET_ACCESS_KEY: Set to AWS Secret Key
  - AWS_DEFAULT_REGION: Set to default region on access key id
  - TF_VAR_priv_key_path: Path to a suitable Private key for ssh access
  - TF_VAR_username: key-pair username from aws key pair creation
  - TF_VAR_pub_key: public key of ssh keypair on host
  - TF_VAR_key_pair_name: identifying name of keypair
- Application Requirements
  - Terraform
    - Installation: [Here](https://learn.hashicorp.com/terraform/getting-started/install.html)
  - AWSCLI
    - Installation: Package Manager or [Here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
  - curl
    - Installation: Package Manager

## What create_server wraps
- Run Terraform commands
  - In this case, run
    ```bash
    terraform apply --auto-approve
    ```
- If successful, stdout should have an output variable that is the public ip of
  the instance
  - You can also query the succesful provisioning via terraform output from the 
    current directory and will find an instance_ip variable like so
    ```bash
    terraform output | awk '/instance*/ {print $3}'
    ```
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
