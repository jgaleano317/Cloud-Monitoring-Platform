# Cloud Monitoring Platform

A hands-on DevOps/SRE portfolio project demonstrating **containerized application deployment, CI/CD automation, AWS infrastructure, monitoring, and Infrastructure as Code**.

The project started as a simple Python/Flask application and was progressively built out with Docker, Bash automation, Jenkins, AWS services, CloudWatch monitoring, and Terraform.

## Architecture

```text
                         GitHub
                            │
                            ▼
                         Jenkins
                            │
                            ▼
                   Bash Deployment Script
                            │
                            ▼
                    Docker Container
                            │
                            ▼
                    Python / Flask App
                            │
                            ▼
                       Health Check
                            │
                            ▼
                         AWS EC2
                       /     |     \
                      /      |      \
             Security     IAM     CloudWatch
              Group                Monitoring
                                      │
                                      ▼
                                  CPU Alarm

                         AWS S3
                            │
                            ▼
                      Object Storage

                       Terraform
                            │
                            ▼
                 AWS Infrastructure
                 (Security Group)
```

## Technology Stack

- **Linux**
- **Python / Flask**
- **Bash**
- **Docker**
- **Jenkins**
- **Git / GitHub**
- **AWS EC2**
- **AWS S3**
- **AWS IAM**
- **AWS Security Groups**
- **AWS CloudWatch**
- **Terraform**

## Application

The project uses a lightweight Python/Flask application with a basic application endpoint and health-check endpoint.

### Endpoints

```text
/
```

Returns a basic response confirming the application is running.

```text
/health
```

Returns a JSON health status:

```json
{
  "status": "healthy"
}
```

The health endpoint is also used by the deployment script to verify that a newly deployed container is responding correctly.

---

## Docker

The Flask application is containerized using Docker.

Build the image:

```bash
docker build -t cloud-monitoring-app ./app
```

Run the container:

```bash
docker run -d \
  --name cloud-monitoring-app \
  -p 5001:5001 \
  cloud-monitoring-app
```

Test the application:

```bash
curl http://127.0.0.1:5001
```

Test the health endpoint:

```bash
curl http://127.0.0.1:5001/health
```

---

## Automated Deployment

The `scripts/deploy.sh` script automates the Docker deployment process.

The script:

1. Builds the Docker image
2. Removes the existing container when necessary
3. Starts the new container
4. Waits for the application to initialize
5. Runs a health check
6. Reports the deployment status
7. Returns a failure if the health check does not pass

Instead of manually running several Docker commands, the deployment can be performed with:

```bash
./scripts/deploy.sh
```

This provided hands-on practice with **Bash automation, deployment workflows, and basic application health monitoring**.

---

## Jenkins CI/CD

Jenkins was used to automate the deployment workflow.

The general pipeline is:

```text
GitHub
   │
   ▼
Jenkins
   │
   ▼
Clone Repository
   │
   ▼
Run deploy.sh
   │
   ▼
Build Docker Image
   │
   ▼
Deploy Container
   │
   ▼
Health Check
   │
   ▼
Build Success / Failure
```

The Jenkins job executes the deployment script rather than requiring each deployment step to be performed manually.

This provided practical experience with **CI/CD concepts, Jenkins, GitHub integration, Docker, and automated deployment validation**.

---

# AWS Infrastructure & Monitoring

The project was expanded into AWS to gain hands-on experience with cloud infrastructure, networking, permissions, storage, and monitoring.

## EC2

An Amazon EC2 Linux instance was used as the compute environment.

Hands-on work included:

- Launching and configuring a Linux EC2 instance
- Connecting through SSH
- Working with instance networking
- Managing Security Group access
- Monitoring instance resource usage

## Security Groups

AWS Security Groups were used to control network access to the EC2 instance.

The project included troubleshooting SSH connectivity by reviewing:

- Security Group rules
- SSH access
- Network routing
- Internet Gateway configuration
- EC2 connectivity

This provided practical experience troubleshooting AWS networking rather than simply configuring the instance once and moving on.

## IAM

AWS IAM was used to work with AWS permissions and access control.

The project provided hands-on experience understanding how AWS resources and services use **users, policies, roles, and permissions** to control access.

## S3

An Amazon S3 bucket was created for object storage.

During the project, an `AccessDenied` error was encountered while working with S3 permissions. Troubleshooting the issue provided practical experience with:

- S3 bucket permissions
- AWS access control
- Object access
- Understanding `AccessDenied` responses

## CloudWatch

Amazon CloudWatch was used to monitor the EC2 environment.

A CPU utilization alarm was created to detect increased resource usage on the instance.

The alarm was tested by generating CPU activity and observing the resulting CloudWatch metrics and alarm state.

This provided hands-on experience with **AWS monitoring, metrics, thresholds, and alerting**.

---

# Terraform

Terraform was introduced toward the end of the project to practice **Infrastructure as Code (IaC)**.

The Terraform configuration was used to provision and manage an AWS Security Group.

### Terraform files

```text
terraform/
├── main.tf
├── security-group.tf
├── variables.tf
├── terraform.tfvars
└── .gitignore
```

The configuration includes:

- AWS provider configuration
- Terraform variables
- AWS Security Group configuration
- SSH access restricted to a specified IP
- HTTP access
- Outbound access
- Terraform state management

The project used common Terraform workflows including:

```bash
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
terraform state list
terraform show
```

Sensitive/local Terraform state and variable files are excluded from version control where appropriate.

The current Terraform implementation is intentionally small and serves as an introduction to managing AWS infrastructure through code.

---

# Running Locally

## Python

Create a virtual environment:

```bash
cd app
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

Start the application:

```bash
python app.py
```

Test the application:

```bash
curl http://127.0.0.1:5001
```

Health check:

```bash
curl http://127.0.0.1:5001/health
```

## Docker

From the project root:

```bash
docker build -t cloud-monitoring-app ./app
```

Start the container:

```bash
docker run -d \
  --name cloud-monitoring-app \
  -p 5001:5001 \
  cloud-monitoring-app
```

## Automated Deployment

```bash
./scripts/deploy.sh
```

The script builds the image, deploys the container, and verifies the application using the health endpoint.

---

# What I Learned

This project was built as a hands-on exercise to strengthen my understanding of:

- Linux administration
- Bash scripting and automation
- Git and GitHub workflows
- Python/Flask
- Docker containerization
- Jenkins and CI/CD
- Application health checks
- AWS EC2
- AWS Security Groups
- AWS IAM
- AWS S3
- AWS CloudWatch
- AWS monitoring and alarms
- Terraform and Infrastructure as Code
- Troubleshooting cloud infrastructure and permissions

The main goal was to understand how these technologies work together rather than learning each one in isolation.

---

# Future Improvements

Potential future improvements include:

- Expand Terraform coverage to additional AWS resources
- Introduce reusable Terraform modules
- Add automated application testing
- Expand application and infrastructure monitoring
- Improve logging and observability
- Further automate the AWS deployment process
- Explore additional AWS services

---

## Project Status

**Completed**

- Python/Flask application
- Docker containerization
- Bash deployment automation
- Jenkins CI/CD
- AWS EC2
- AWS Security Groups
- AWS IAM
- AWS S3
- AWS CloudWatch monitoring
- CloudWatch CPU alarm
- Introductory Terraform infrastructure provisioning

**Future work**

- Expanded Terraform infrastructure
- Automated testing
- Additional observability
- Further AWS automation
