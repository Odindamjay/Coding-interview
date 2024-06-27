# AWS Monitoring and Automation Solution

## Project Overview

This project provides a comprehensive monitoring and automation solution for a web application hosted on AWS. It leverages AWS Lambda for automated actions, Sumo Logic for monitoring and alerts, and Terraform for infrastructure as code (IaC) deployment. The goal is to automatically handle performance issues by restarting an EC2 instance when specific conditions are met.

## Prerequisites

- **AWS CLI**: Configured with appropriate credentials.
- **Terraform**: Installed on your machine.
- **LocalStack** (Optional for local testing): For simulating AWS services locally.
- **Docker** (Required if using LocalStack): For running LocalStack in a container.

## Repository Structure

- `/lambda_function/`: Contains the Python code for the AWS Lambda function.
- `/terraform/`: Contains Terraform configuration files for setting up AWS resources.
- `/sumo_logic_query.txt`: Contains the Sumo Logic query used for monitoring.
- `README.md`: This file, explaining the project setup and deployment.

## Setup Instructions

### 1. Terraform Setup

Navigate to the `terraform/` directory:

```bash
cd terraform
```

Initialize Terraform:

```bash
terraform init
```

Apply the Terraform configuration to deploy the AWS resources:

```bash
terraform apply
```

### 2. Sumo Logic Configuration

- Ensure that your Sumo Logic environment is set up to receive logs from your AWS resources.
- Import the query from `sumo_logic_query.txt` into your Sumo Logic dashboard to monitor the application.

### 3. Lambda Function Deployment

Navigate to the `lambda_function/` directory:

```bash
cd lambda_function
```

Deploy the Lambda function using the AWS CLI:

```bash
aws lambda create-function --function-name RestartEC2Instance --zip-file fileb://function.zip --handler lambda_function.lambda_handler --runtime python3.8 --role <role-arn>
```

### 4. Local Testing (Optional)

For local testing with LocalStack:

- Start LocalStack using Docker:

  ```bash
  docker-compose up
  ```

- Use the AWS CLI or SDK to interact with the local AWS services at `http://localhost:4566`.

## Monitoring and Alerts

Configure alerts in Sumo Logic to trigger the Lambda function whenever the query conditions are met. Set the Lambda function to listen to SNS notifications for automated execution.

- alert condition: If the number of results is greater than 5 in the last 10 minutes

## Contributing

Contributions are welcome! Please fork the repository and submit pull requests with your enhancements.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
# SRE
