This project demonstrates a full CI/CD pipeline for a Python Flask app, leveraging Jenkins, Docker, Kubernetes, ArgoCD, and Traefik with IP whitelisting and TLS.
Project Structure

.
├── argocd/                 # ArgoCD app manifests and ingress
│   ├── applications/       # Dev & staging app CRs
│   └── ingress/            # Traefik IngressRoute manifests
├── base/                   # Kustomize base resources
│   ├── cert/               # TLS certs (optional)
│   ├── rbac/               # Cluster-wide RBAC manifests
│   ├── ingressroute.yaml   # Base ingress config
│   ├── service.yaml        # Kubernetes Service
│   ├── deployment.yaml     # Kubernetes Deployment
│   └── kustomization.yaml
├── overlays/
│   ├── dev/                # Dev environment overlays
│   └── staging/            # Staging environment overlays

---

## 🔄 CI/CD Pipeline

### 🔧 Jenkins

- Triggered on Git commits  
- Builds Flask app Docker image  
- Pushes images to Docker Hub  
- Publishes build results  

### 🎯 ArgoCD

- Watches dev & staging overlays  
- Syncs Kubernetes manifests automatically  
- Manages app deployment and updates  

### ☸️ Kubernetes Setup

- Local cluster (Kind, Minikube, or K3s)  
- Traefik ingress controller using IngressRoute CRDs  
- IP whitelisting for security  
- TLS via self-signed certs or Let’s Encrypt  

---

## 🔐 RBAC Access Model

| Group       | Access                                  |
|-------------|---------------------------------------|
| 👷 DevOps      | Full cluster-admin                     |
| 🧪 QA          | Full access except delete in dev & staging |
| 👨‍💻 Developer  | Read-only access in dev namespace     |

- RBAC manifests located in `base/rbac/` and environment overlays.

---

## 🌐 Usage Notes

- Ingress example host for dev:  
  `python-app.192.168.1.165.nip.io`

- Ingress example host for staging:  
  `python-app-staging.192.168.1.165.nip.io`

- Ensure Traefik CRDs use:  
  `apiVersion: traefik.io/v1alpha1`

- Docker image tagging example:  
  `docker.io/<your-username>/python-app:<tag>`

---

## 📝 Commands

- ArgoCD sync apps:  
  ```bash
  argocd app sync flask-app-dev
  argocd app sync flask-app-staging


Project Overview

    Jenkins pipeline builds, dockerizes, and pushes the Flask app.

    Kubernetes cluster with Traefik ingress exposes the app securely.

    ArgoCD manages deployment using GitOps principles.

    Separate dev and staging namespaces with isolated RBAC.

    IP whitelisting middleware enhances security.

    TLS certificates enable HTTPS access.

    Docker images are versioned with tags.

    Git-based Infrastructure as Code and automation for reproducibility.

Decisions

    Traefik ingress chosen for middleware flexibility.

    Namespaces + RBAC to secure team access.

    ArgoCD GitOps for declarative, automated deployment.

    Docker image tagging for clear version control.

    Jenkinsfile for pipeline maintainability.

Future Work

    Add automated tests and Jenkins test reporting.

    Implement monitoring and alerting for apps.

    Support canary or blue-green deployments.

    Enable rollbacks and advanced deployment strategies.

    Refine RBAC for more granular permissions.

Decisions

    Chose Traefik ingress for flexibility and easy middleware integration.

    Used namespaces + RBAC to provide controlled access for teams.

    ArgoCD allows GitOps and automatic sync from repo.

    Docker images versioned by tags for clear deployment control.

    Jenkins pipeline uses a Jenkinsfile for maintainability.

Future Work

    Add automated tests and publish test results to Jenkins.

    Implement monitoring and alerting on deployed apps.

    Add canary or blue-green deployments for zero downtime.

    Support rollbacks and more sophisticated deployment strategies.

    Extend RBAC for finer-grained permissions per team.

