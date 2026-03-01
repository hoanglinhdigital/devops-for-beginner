# Setting up Alerts with Prometheus and AlertManager

This guide will help you set up alerting rules for your Kubernetes cluster using Prometheus and AlertManager. We will configure alerts for the following scenarios:
- Backend pod down
- Frontend pod down
- Mongo pod down
- CPU high usage
- Memory high usage

## Step 1: Create the Alert Rules ConfigMap

First, we need to define the alert rules in a Kubernetes `ConfigMap`. Prometheus will read these rules to evaluate whether an alert should be fired.

Apply the new `ConfigMap` for Alert Rules:
```bash
kubectl apply -f alert-rules.yaml
```

## Step 2: Mount the Alert Rules in Prometheus

Now, we need to update the Prometheus deployment to mount and read the new `alert_rules.yml` file.

Open your `todo-app-monitoring-stack.yaml` file, un-comment line: 113 and 130.  

Apply the updated monitoring stack:
```bash
kubectl apply -f todo-app-monitoring-stack.yaml
```

## Step 3: Verify the Alerts

1. Give the Prometheus pod a moment to restart or reload its configuration.
2. Open the Prometheus UI. Depending on your Minikube setup, you can access it via NodePort or running `minikube service prometheus -n monitoring`.
3. Navigate to the **Alerts** tab on the top menu.
4. You should see all 5 alerts we just configured:
   - `BackendPodDown`
   - `FrontendPodDown`
   - `MongoPodDown`
   - `HighCPUUsage`
   - `HighMemoryUsage`
5. Their status should be in `Inactive` (green). If any condition is met, they will transition to `Pending` and then `Firing` (red), sending a notification to AlertManager.

6. Open the AlertManager UI (`minikube service alertmanager -n monitoring`) to verify any active fired alerts.

## Testing Your Alerts (Optional)
To test if an alert fires properly, you can temporarily scale down your backend deployment:
```bash
kubectl scale deployment backend-deployment --replicas=0 -n default
```
Wait for about 1 minute, and you will see the `BackendPodDown` alert state change to `Firing` in the Prometheus Alerts dashboard and appear in the AlertManager interface. Do not forget to scale it back up!
```bash
kubectl scale deployment backend-deployment --replicas=2 -n default
```
