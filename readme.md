
This project demonstrates a full CI/CD pipeline for a Python app using Jenkins, Docker, Kubernetes, and ArgoCD. The deployment is exposed through Traefik with IP whitelisting and optional TLS support.

---

## 🧱 Project Structure

```bash
.
├── argocd/                 # ArgoCD app definitions & ingress
│   ├── applications/       # ArgoCD App CRs for dev & staging
│   └── ingress/            # ArgoCD IngressRoute
├── base/                   # Kustomize base resources
│   ├── cert/               # TLS certs (optional)
│   ├── rbac/               # Cluster-wide RBAC (DevOps, QA, Devs)
│   ├── ingressroute.yaml   # Base ingress config
│   ├── service.yaml        # K8s Service
│   ├── deployment.yaml     # K8s Deployment
│   └── kustomization.yaml
├── overlays/
│   ├── dev/                # Dev overlay
│   └── staging/            # Staging overlay
├── namespace.yaml
├── tls.crt / tls.key       # TLS certs (self-signed or from Let's Encrypt)
├── Jenkinsfile             # Jenkins CI pipeline
└── readme.md

🚀 CI/CD Pipeline
✅ Jenkins

    Triggered on Git commit

    Builds hello_world.py into a Docker image

    Pushes to Docker Hub

    Publishes results + image info

✅ ArgoCD

    Watches dev and staging overlays

    Applies changes automatically

    Syncs app to Kubernetes

☁️ Kubernetes

    Cluster: local (e.g., K3s, Kind, Minikube)

    Ingress: Traefik with IngressRoute CRDs

    TLS: via self-signed cert or Let's Encrypt

    IP Whitelisting via Traefik middleware

🔐 RBAC Access
Group	Access
DevOps	Full cluster-admin
QA	Full access (except delete) in dev & staging
Developer	Read-only access in dev

RBAC manifests live in:

    base/rbac/ (cluster-wide roles)

    overlays/*/rbac/ (namespaced bindings)

🧪 Bonus (Staging Tests)

    Staging namespace is isolated

    Used for integration/unit testing

    Test results pushed to Jenkins

🌐 Ingress Example

match: Host(`python-app.192.168.1.165.nip.io`)

For staging:

match: Host(`python-app-staging.192.168.1.165.nip.io`)

🔄 Quick Commands
ArgoCD Sync (CLI)

argocd app sync flask-app-dev
argocd app sync flask-app-staging

Jenkins Build (Manual)

# Trigger pipeline if not automated
curl -X POST <jenkins-job-url>/build

📌 Notes

    Ensure the cluster has traefik.io/v1alpha1 CRDs installed

    All IngressRoute manifests must use:

    apiVersion: traefik.io/v1alpha1

📤 Docker Image Example

docker.io/<your-username>/python-app:<git-sha>
