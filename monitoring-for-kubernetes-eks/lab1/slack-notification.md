# Setting up Slack Notifications for AlertManager

This guide will walk you through setting up Slack notifications for your Prometheus alerts via Alertmanager.

## 1. Create a Slack Incoming Webhook
1. Go to your Slack workspace and navigate to **Settings & administration > Manage apps** (or visit [Slack App Directory](https://slack.com/apps)).
2. Search for **Incoming WebHooks** and click **Add to Slack**.
3. Choose the channel where you want your alerts to be sent (e.g., `#monitoring` or `#alerts`).
4. Click **Add Incoming WebHooks integration**.
5. Copy the **Webhook URL** provided (it will look like `https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX`). You will need this URL for the Alertmanager configuration.

## 2. Update Alertmanager Configuration
Update file: `todo-app-monitoring-stack.yaml`.
Replace: # AlertManager ConfigMap with content in the file: `alert-manager-configmap-for-slack.yaml`. *Dont forget to replace slack webhook url and channel name with your own.

## 3. Apply the Configuration
Apply the updated ConfigMap to your Kubernetes cluster:

```bash
kubectl apply -f todo-app-monitoring-stack.yaml
```

Restart the Alertmanager pod for the new configuration to take effect:

```bash
kubectl rollout restart deployment alertmanager -n monitoring
```


## 4. Test the Slack Notification
To verify that alerts are being sent to Slack, you can artificially trigger an alert.
For example, scale down the backend deployment:

```bash
kubectl scale deployment backend-deployment --replicas=0 -n default
```

1. Wait for about 1 minute.
2. Check the Prometheus UI Alerts tab (`http://localhost:9090/alerts`) to see `BackendPodDown` state change to `Firing`.
3. Check the Alertmanager UI (`http://localhost:9093`) to confirm the alert is received.
4. You should receive a payload notification in your configured Slack channel.

Don't forget to restore the application by scaling it back up:
```bash
kubectl scale deployment backend-deployment --replicas=2 -n default
```
