# Introduction to Monitoring on EKS
## Preparation:
- Install Docker on Local machine
- Install Minikube on Local machine
Make sure you are using Docker Desktop and Minikube latest:
Check: `minikube update-check`
Update: 
```
minikube stop
minikube delete
choco upgrade minikube
minikube start
```
- Install kubectl on Local machine
## Preparation: Deploy TODO app to mimikube  
- Step 1: Checkout below repository:  
https://github.com/hoanglinhdigital/react-express-mongodb
Follow steps to deploy to Minikube Local:
- Getting Started
- Deploy to minikube on local. * NOTE: at step 4, use `todo-app-minikube-local-with-mongo-exporter.yaml` instead of `minikube-local.yaml`
```
kubectl apply -f todo-app-minikube-local-with-mongo-exporter.yaml
```
## Deploy Monitoring Stack
- Step 1: Deploy needed monitoring tools  
`kubectl apply -f todo-app-monitoring-stack.yaml`  
Check deployment result:  
```
kubectl get pods -n monitoring
kubectl get services -n monitoring
kubectl get deployments -n monitoring
```

- Step 2: Access the services:
Access Grafana:  
`minikube service grafana -n monitoring`  
Login to Grafana with username/password: `admin/admin`
Access Prometheus:  
`minikube service prometheus -n monitoring`  
Access AlertManager:  
`minikube service alertmanager -n monitoring`

## Interact with Prometheus and Grafana  
- Step 1: Access Prometheus UI  
  Run some query to get data. See: `prometheus_query.md` for example.

- Step 2: Access Grafana UI  
  Create some widget. See `grafana-dashboard.md` for example.

- Step 3: Access Alert manager.
  Configure some Alert using `alertmanager.md`.

- Step 4: Configure Slack Notification.
  See `slack-notification.md` for example.

## Clear resource
Run below command to clear resource:
`kubectl delete -f todo-app-monitoring-stack.yaml`
`kubectl delete -f todo-app-minikube-local-with-mongo-exporter.yaml`