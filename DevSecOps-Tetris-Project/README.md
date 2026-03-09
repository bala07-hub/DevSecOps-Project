# 🚀 DevSecOps Tetris Project (End-to-End CI/CD with Security)

## 📌 Overview

This project demonstrates a **complete End-to-End DevSecOps pipeline** that automates the process of **building, scanning, containerizing, and deploying an application to Kubernetes (AWS EKS)** using modern DevOps and security tools.

The pipeline ensures **code quality, security checks, container scanning, and GitOps deployment**, following real-world DevSecOps practices.

The application used for deployment is a **Tetris game**, which is containerized and deployed on **Amazon EKS**.

---

# 🏗️ Architecture

![Image](https://miro.medium.com/1%2AaQxXkvaJdn7E9nUTYShMJQ.gif)

![Image](https://miro.medium.com/v2/resize%3Afit%3A2000/1%2AIHSWVlM1ICBsMXMhGMT1ww.jpeg)

![Image](https://miro.medium.com/1%2AeHzvAx969hfeWJIwD7RdSQ.png)

![Image](https://miro.medium.com/v2/resize%3Afit%3A1400/1%2AN8t1vHZDhGxUYPupSqFRSg.png)

### High Level Flow

1️⃣ Developer pushes code to **GitHub**
2️⃣ **Jenkins Pipeline** starts automatically
3️⃣ **SonarQube** performs static code analysis
4️⃣ **Dependencies installed via NPM**
5️⃣ **OWASP Dependency Check** scans dependencies
6️⃣ **Trivy File Scan** scans project files
7️⃣ **Docker Image is built**
8️⃣ **Trivy Image Scan** checks container vulnerabilities
9️⃣ **Image pushed to DockerHub**
🔟 **Image tag updated in GitHub manifest**
1️⃣1️⃣ **ArgoCD detects change and deploys to EKS**

---

# 🧰 Tech Stack

| Category               | Tools Used             |
| ---------------------- | ---------------------- |
| Cloud                  | AWS                    |
| Infrastructure as Code | Terraform              |
| Containerization       | Docker                 |
| CI/CD                  | Jenkins                |
| Kubernetes             | Amazon EKS             |
| GitOps                 | ArgoCD                 |
| Code Quality           | SonarQube              |
| Security Scanning      | Trivy                  |
| Dependency Security    | OWASP Dependency Check |
| Container Registry     | DockerHub              |
| Source Control         | GitHub                 |

---

# ⚙️ DevSecOps Pipeline

### 🔹 CI Stage

- Code Checkout
- SonarQube Code Analysis
- Install Dependencies
- OWASP Dependency Check
- Trivy File Scan

### 🔹 Build Stage

- Docker Image Build

### 🔹 Security Stage

- Trivy Container Image Scan

### 🔹 Artifact Stage

- Push Docker Image to **DockerHub**

### 🔹 GitOps Stage

- Update Image Tag in Kubernetes Manifest
- Push changes to **GitHub**

### 🔹 CD Stage

- **ArgoCD** automatically syncs
- Deploys updated image to **EKS Cluster**

---

# ☁️ Infrastructure Provisioning

All infrastructure is provisioned using **Terraform**.

### Resources Created

- Jenkins Server (EC2)
- Amazon EKS Cluster
- EKS Node Group
- IAM Roles
- Networking Components

---

# 📂 Project Structure

```bash
DevSecOps-Tetris-Project
│
├── assets
│
├── EKS-TF
│   └── Terraform scripts for EKS cluster
│
├── Jenkins-Pipeline-Code
│   └── Jenkinsfile and pipeline configuration
│
├── Jenkins-Server-TF
│   └── Terraform code for Jenkins EC2 setup
│
├── Manifest-file
│   ├── deployment-service.yml
│   └── ingress.yaml
│
├── Tetris-V1
│   └── Application source code
│
├── Tetris-V2
│   └── Updated version of the application
│
└── README.md
```

---

# 🔐 Security Implemented

This project integrates multiple **DevSecOps security layers**.

### ✔ Code Security

- SonarQube Static Code Analysis

### ✔ Dependency Security

- OWASP Dependency Check

### ✔ File System Security

- Trivy File Scan

### ✔ Container Security

- Trivy Docker Image Scan

---

# 🚀 Deployment Workflow

### Step 1 — Create Jenkins Server

```bash
cd Jenkins-Server-TF
terraform init
terraform apply
```

---

### Step 2 — Create EKS Cluster

```bash
cd EKS-TF
terraform init
terraform apply
```

---

### Step 3 — Configure Jenkins

Install required tools:

- Docker
- Trivy
- OWASP Dependency Check
- SonarQube Scanner
- kubectl
- AWS CLI

---

### Step 4 — Configure ArgoCD

Install ArgoCD in Kubernetes:

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

---

### Step 5 — Deploy Application

ArgoCD monitors the **GitHub repository** and automatically deploys changes to the **EKS cluster**.

---

# 🎮 Application

The deployed application is a **Tetris Game** running inside a **Docker container on Kubernetes (EKS)**.

Features:

- Containerized deployment
- Scalable Kubernetes pods
- Secure CI/CD pipeline

---

# 📊 Key DevSecOps Concepts Demonstrated

- Infrastructure as Code
- CI/CD Automation
- GitOps Deployment
- Container Security
- Kubernetes Deployment
- Cloud Infrastructure Management
- Security Scanning in CI Pipeline

---

# 🧠 Skills Demonstrated

- AWS (EKS, EC2, IAM)
- Terraform
- Jenkins CI/CD
- Kubernetes
- Docker
- ArgoCD GitOps
- SonarQube
- Trivy Security Scanning
- OWASP Dependency Check

---

# 📬 Author

**BalaManikanta Anantha**

DevOps / Cloud / DevSecOps/MLOps Enthusiast
