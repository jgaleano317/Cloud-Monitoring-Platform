# Cloud Application Deployment & Monitoring Platform

A hands-on DevOps/SRE portfolio project focused on containerized application deployment, CI/CD automation, health checks, and cloud monitoring.

The project is being built incrementally to demonstrate how I approach application deployment, automation, monitoring, and troubleshooting using tools commonly found in DevOps and cloud environments.

## Architecture

### Current

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
Docker Build
   │
   ▼
Docker Container
   │
   ▼
Python / Flask Application
   │
   ▼
/health Endpoint
```

### Planned AWS Architecture

```text
GitHub
   │
   ▼
Jenkins
   │
   ▼
Docker
   │
   ▼
AWS EC2
   │
   ├── NGINX
   │
   └── Flask Application
          │
          ▼
     Health Endpoint
          │
          ▼
      CloudWatch
          │
          ▼
       Alarms
```

## Current Technology Stack

- Python
- Flask
- Docker
- Bash
- Jenkins
- Git
- GitHub

## Current Features

### Flask Application

The application is a simple Python/Flask service with two endpoints:

- `/` — confirms that the application is running
- `/health` — returns a JSON health status

Example:

```json
{
  "status": "healthy"
}
```

### Docker

The Flask application is packaged into a Docker image using a Dockerfile.

The container exposes port `5001`.

Example:

```bash
docker build -t cloud-monitoring-app ./app

docker run -d \
  --name cloud-monitoring-app \
  -p 5001:5001 \
  cloud-monitoring-app
```

### Automated Deployment

The `scripts/deploy.sh` script automates the deployment process.

It:

1. Builds the Docker image
2. Removes the existing container
3. Starts a new container
4. Waits for the application to start
5. Runs a health check
6. Displays container information
7. Fails the deployment if the health check fails

This removes the need to manually perform each Docker command during deployment.

### Jenkins CI/CD

Jenkins is connected to this GitHub repository.

The current workflow is:

```text
GitHub Push
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
Build SUCCESS / FAILURE
```

The Jenkins job currently runs:

```bash
./scripts/deploy.sh
```

A successful Jenkins build confirms that the application was deployed and passed its health check.

## Running Locally

### Run with Python

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

Test it:

```bash
curl http://127.0.0.1:5001
```

Health check:

```bash
curl http://127.0.0.1:5001/health
```

### Run with Docker

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

Test the application:

```bash
curl http://127.0.0.1:5001/health
```

## Automated Deployment Script

The deployment script can be run directly:

```bash
./scripts/deploy.sh
```

A successful deployment should end with:

```text
Health check PASSED!
Deployment successful!
```

## Project Roadmap

This project is intentionally being built in stages.

### Completed

- [x] Create Flask application
- [x] Add application health endpoint
- [x] Containerize application with Docker
- [x] Create automated Bash deployment script
- [x] Add Docker health validation
- [x] Create GitHub repository
- [x] Connect Jenkins to GitHub
- [x] Automate deployment through Jenkins

### Planned

- [ ] Deploy application to AWS EC2
- [ ] Configure AWS security groups
- [ ] Add NGINX reverse proxy
- [ ] Configure CloudWatch monitoring
- [ ] Create CloudWatch alarms
- [ ] Add application/log monitoring
- [ ] Add automated failure/recovery behavior
- [ ] Add automated testing
- [ ] Add Terraform infrastructure
- [ ] Improve production deployment architecture
- [ ] Document troubleshooting scenarios

## What I'm Demonstrating

This project is designed to demonstrate practical experience with:

- Linux administration
- Bash automation
- Git/GitHub workflows
- CI/CD concepts
- Jenkins
- Docker
- Python
- Application health checks
- Deployment troubleshooting
- AWS infrastructure
- Monitoring and observability
- Infrastructure as Code

The goal is not simply to deploy an application, but to build an understanding of the entire workflow from source code through deployment, monitoring, and recovery.

