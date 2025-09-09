# 🌟 Kubernetes Pet Project

This is an **educational Kubernetes project** using **Minikube** that demonstrates:

- Pods 🐳
- Deployments 📦
- Services 🌐
- ConfigMaps 🗂️
- Flask Application 🐍
- Liveness & Readiness Probes 💓
- Self-recovering application after crash simulation 💥➡️♻️

---

## 🗂 Project Structure

```text
k8s-pet-project/
├── app2.py                  # Flask app 2 with crash endpoint (/sysexc1)
├── Dockerfile               # Dockerfile for first Flask app
├── Dockerfile.app2          # Dockerfile for second Flask app
├── requirements.txt         # Python dependencies
├── configmap/
│   └── configmap.yaml       # ConfigMap for Flask app 1
├── configmap2.yaml          # ConfigMap for Flask app 2
├── deployment/
│   └── deployment.yaml      # Deployment for Flask app 1
├── deployment2.yaml         # Deployment for Flask app 2
├── service/
│   └── service.yaml         # Service for Flask app 1
├── service2.yaml            # Service for Flask app 2
├── README.md                # This file
├── LICENSE                  # License file
└── minikube-linux-amd64     # Minikube binary (optional)



⚙️ Requirements

Minikube

kubectl

Docker 🐳

🚀 How to run locally
1️⃣ Start Minikube cluster
minikube start --memory=2048 --cpus=2


💡 Tip: Optional addons for metrics and dashboard:

minikube addons enable metrics-server
minikube addons enable dashboard

2️⃣ Build Flask Docker images inside Minikube

Switch to Minikube's Docker daemon:

eval $(minikube docker-env)


Build the first app:

docker build -t flask-app:1.0 -f Dockerfile .


Build the second app (with crash endpoint and probes):

docker build -t flask-app2:1.0 -f Dockerfile.app2 .


Check that images exist:

docker images

3️⃣ Apply Kubernetes manifests

ConfigMaps:

kubectl apply -f configmap.yaml
kubectl apply -f configmap2.yaml


Deployments:

kubectl apply -f deployment.yaml
kubectl apply -f deployment2.yaml


Services:

kubectl apply -f service.yaml
kubectl apply -f service2.yaml


Restart deployments if needed:

kubectl rollout restart deployment flask-deployment
kubectl rollout restart deployment flask-deployment2

4️⃣ Check resources

Pods (watch live updates):

kubectl get pods -w


Services:

kubectl get svc

5️⃣ Access the applications

Open service in browser:

minikube service flask-service
minikube service flask-service2


Or use curl for Flask App 2:

MINIKUBE_IP=$(minikube ip)
NODE_PORT=$(kubectl get svc flask-service2 -o jsonpath='{.spec.ports[0].nodePort}')

# Access homepage
curl http://$MINIKUBE_IP:$NODE_PORT/

# Simulate crash
curl -X POST http://$MINIKUBE_IP:$NODE_PORT/sysexc1


💡 Tip: Watch how Kubernetes restarts the pod automatically after crash.

6️⃣ Notes

Flask App 2 has liveness and readiness probes configured so Kubernetes can check app health and restart it if needed.

POST /sysexc1 triggers a Python crash for testing self-recovery.

Minikube’s NodePort exposes services to your local machine.

Use:

kubectl get pods -w


to watch pods restart automatically.