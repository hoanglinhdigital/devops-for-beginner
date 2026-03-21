# Lab 3: Request tracing using OpenTelemetry and Jaeger

## Step 1: Install prerequisite Operators
The tracing configuration uses Custom Resource Definitions (CRDs) like `Jaeger`, `Instrumentation`, and `OpenTelemetryCollector`. These require their respective operators to be installed first.

Run the following commands to install them:

```bash
# 1. Install cert-manager (required by OpenTelemetry Operator)
kubectl apply -f cert-manager.yaml
# Check cert-manager status
kubectl get pods -n cert-manager

# 2. Install Jaeger Operator
kubectl create namespace observability
kubectl apply -f jaeger-operator.yaml -n observability
kubectl get all -n observability
kubectl get pods -n observability

# 3. Wait a minute for cert-manager to be completely ready, then install OpenTelemetry Operator
kubectl apply -f opentelemetry-operator.yaml
kubectl get all -n opentelemetry-operator-system
kubectl get pods -n opentelemetry-operator-system
```

*Note: Allow a minute or two for the operator pods to be fully initialized before proceeding.*


## Step 2: Apply tracing configuration
```bash
kubectl apply -f tracing.yaml
kubectl get pods -n monitoring
```
## Step 3: Apply new configuration to add annotation
Annotation to be added:
``` yaml
# Dòng quan trọng: Inject cấu hình tracing cho Node.js
instrumentation.opentelemetry.io/inject-nodejs: "monitoring/nodejs-instrumentation"   
```
Run below command to apply new setting.  
```bash
kubectl apply -f todo-app-minikube-local-with-mongo-exporter.yaml
```

Rolling out new version of application.
```bash
kubectl rollout restart deployment/backend-deployment -n default
kubectl rollout restart deployment/frontend-deployment -n default

kubectl rollout status deployment/backend-deployment -n default
kubectl rollout status deployment/frontend-deployment -n default

kubectl get pods
kubectl describe pod <pod-name> -n default
```
## Step 4: Access Jaeger UI

To view the traces, you can use the `minikube service` command to access the Jaeger UI which runs in the `monitoring` namespace. This will automatically open the Jaeger UI in your default browser.

```bash
minikube service jaeger-all-in-one-query -n monitoring
```

## Step 5: Generate Traces and View Data

1. Open your application (Frontend) and interact with it (e.g., create a new Todo, delete a Todo).
2. Go to the Jaeger UI that was opened in your browser.
3. Under the **Service** dropdown on the left pane, you should now see your `frontend` and `backend` services listed.
4. Select `frontend` or `backend` and click **Find Traces**.
5. Click on any of the traces that appear on the right to see the detailed spanning of the request as it passed through the components.


## Clear resources

```bash
kubectl delete -f tracing.yaml
kubectl delete -f opentelemetry-operator.yaml
kubectl delete -f jaeger-operator.yaml -n observability
kubectl delete -f cert-manager.yaml
```
