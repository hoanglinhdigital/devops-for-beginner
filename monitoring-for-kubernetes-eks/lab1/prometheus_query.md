# Prometheus Queries for Todo App Monitoring

This document contains useful Prometheus queries to monitor your backend and frontend services in the todo-app deployment.

## Requirement
Deploy prometheus, grafana, alertmanager to minikube successfully.
Access Prometheus via Minikube port forward command

## Pod Status Monitoring

### Check Pod Status (Up/Down)

Check if backend pods are up:
```promql

up{kubernetes_pod_name=~"backend.*"}

```

Check if frontend pods are up:
```promql
up{kubernetes_pod_name=~"frontend.*"}
```

Check all application pods:
```promql
up{kubernetes_namespace="default"}
```

## Resource Usage

### Memory Usage

Backend memory usage (bytes):
```promql
container_memory_usage_bytes{pod=~"backend.*"}
```

Mongo Memory usage:
```promql
container_memory_usage_bytes{pod=~"mongo.*"} 
```

Memory usage as percentage(%) of limit:
```promql
(container_memory_usage_bytes{pod=~"backend.*"} / container_spec_memory_limit_bytes{pod=~"backend.*"}) * 100
```



### CPU Usage

Backend CPU usage rate (5-minute average):
```promql
rate(container_cpu_usage_seconds_total{pod=~"backend.*"}[5m])
```

Frontend CPU usage rate (5-minute average):
```promql
rate(container_cpu_usage_seconds_total{pod=~"frontend.*"}[5m])
```
CPU usage total second:
```promql
container_cpu_usage_seconds_total{pod=~"backend.*"}
```
---


## Service Health

### Service Availability

Check if backend service endpoints are available:
```promql
up{job="kubernetes-pods", kubernetes_pod_name=~"backend.*"}
```

Check if frontend service endpoints are available:
```promql
up{job="kubernetes-pods", kubernetes_pod_name=~"frontend.*"}
```

---

## Scrape Metrics

### Scrape Success Rate

Check if Prometheus is successfully scraping targets:
```promql
up{job="kubernetes-pods"}
```

Scrape duration:
```promql
scrape_duration_seconds{job="kubernetes-pods"}
```


## Advanced Queries

### Top 5 Pods by Memory Usage
```promql
topk(5, container_memory_usage_bytes{namespace="default"})
```

### Top 5 Pods by CPU Usage
```promql
topk(5, rate(container_cpu_usage_seconds_total{namespace="default"}[5m]))
```

