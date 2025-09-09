Kubernetes Pet Project

This is an educational Kubernetes project using **Minikube** that demonstrates:
- Pod
- Deployment
- Service
- ConfigMap
- Flask Application
- Liveness and Readiness Probes
- Self-recovering application after crash simulation

---

## Project Structure

k8s-pet-project/
├── app2.py # Flask app 2 with crash endpoint (/sysexc1)
├── Dockerfile # Dockerfile for first Flask app
├── Dockerfile.app2 # Dockerfile for second Flask app
├── requirements.txt # Python dependencies
├── configmap/
│ └── configmap.yaml # ConfigMap for Flask app 1
├── configmap2.yaml # ConfigMap for Flask app 2
├── deployment/
│ └── deployment.yaml # Deployment for Flask app 1
├── deployment2.yaml # Deployment for Flask app 2
├── service/
│ └── service.yaml # Service for Flask app 1
├── service2.yaml # Service for Flask app 2
├── README.md # This file
├── LICENSE # License file
└── minikube-linux-amd64 # Minikube binary (optional)

text

---

## Requirements

- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Docker

---

## How to run locally

### 1. Start Minikube cluster

minikube start --memory=2048 --cpus=2

text

(Optional) Enable Minikube addons for metrics and dashboard:

minikube addons enable metrics-server
minikube addons enable dashboard

text

### 2. Build Flask Docker images inside Minikube

Use Minikube's Docker daemon:

eval $(minikube docker-env)

text

Build the first app:

docker build -t flask-app:1.0 -f Dockerfile .

text

Build the second app (with crash endpoint and probes):

docker build -t flask-app2:1.0 -f Dockerfile.app2 .

text

Check that images are built:

docker images

text

### 3. Apply Kubernetes manifests

Apply ConfigMaps:

kubectl apply -f configmap.yaml
kubectl apply -f configmap2.yaml

text

Apply Deployments:

kubectl apply -f deployment.yaml
kubectl apply -f deployment2.yaml

text

Apply Services:

kubectl apply -f service.yaml
kubectl apply -f service2.yaml

text

Restart deployments if needed:

kubectl rollout restart deployment flask-deployment
kubectl rollout restart deployment flask-deployment2

text

### 4. Check resources

Pods:

kubectl get pods -w

text

Services:

kubectl get svc

text

### 5. Access the applications

Open service in browser:

minikube service flask-service
minikube service flask-service2

text

Or use curl for second app:

MINIKUBE_IP=$(minikube ip)
NODE_PORT=$(kubectl get svc flask-service2 -o jsonpath='{.spec.ports.nodePort}')

Access homepage
curl http://$MINIKUBE_IP:$NODE_PORT/

Simulate crash
curl -X POST http://$MINIKUBE_IP:$NODE_PORT/sysexc1

text

### 6. Notes

- Flask App 2 has liveness and readiness probes configured so Kubernetes can check if the app is healthy and automatically restart it if it crashes.
- POST /sysexc1 endpoint triggers a Python crash to test self-recovery.
- Minikube’s NodePort is used to access services from your local machine.
- You can watch pods restart automatically using `kubectl get pods -w`.