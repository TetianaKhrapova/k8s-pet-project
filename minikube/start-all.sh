#!/bin/bash
# Script to quickly launch all Kubernetes objects in Minikube

# Create a standalone Pod (nginx example)
kubectl apply -f ../pod/nginx-pod.yaml

# Create Nginx Deployment (manages replicas of nginx pods)
kubectl apply -f ../deployment/nginx-deployment.yaml

# Create Nginx Service (exposes Deployment to the cluster / outside world)
kubectl apply -f ../service/nginx-service.yaml

# Create ConfigMap (stores configuration data for the Flask app)
kubectl apply -f ../configmap/configmap.yaml

# Deploy the Flask Application (Deployment + Service)
kubectl apply -f ../flask-app/flask-app.yaml
kubectl apply -f ../flask-app/flask-service.yaml

# Show status of Pods and Services
echo "📦 Pods:"
kubectl get pods 
echo "🌐 Services:"
kubectl get svc

# Open Nginx service in browser (via NodePort)
echo "➡ Opening Nginx service..."
minikube service nginx-service --url

# Open Flask service in browser (via NodePort)
echo "➡ Opening Flask service..."
minikube service flask-service --url
