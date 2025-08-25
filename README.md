# Kubernetes Pet Project 

This is an educational Kubernetes project using **Minikube** that demonstrates:
- Pod
- Deployment
- Service
- ConfigMap
- Flask Application

---

## Requirements
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

---

##  How to run locally

1. **Start Minikube cluster**:
   ```bash
   minikube start --memory=2048 --cpus=2
Enable Minikube addons (optional, for dashboard & metrics):

minikube addons enable metrics-server
minikube addons enable dashboard


Build Flask app Docker image inside Minikube:

eval $(minikube docker-env)   # Use Minikube’s Docker daemon
docker build -t flask-app:1.0 .


Apply Kubernetes manifests:

kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml


Check resources:

kubectl get pods
kubectl get svc


Access the application:

minikube service flask-service


This will open the Flask app in your browser.
