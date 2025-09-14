# Introduction to Monitoring on EKS

Prepare: Using repository below and deploy to Minikube on Local machine  
https://github.com/hoanglinhdigital/react-express-mongodb

- Step 1: Apply new config  
`kubectl apply -f minikube-local-with-monitoring.yaml`

- Step 2: Deploy needed monitoring tools  
`kubectl apply -f monitoring-stack.yaml`

- Step 3: Configure local DNS. Add local DNS entries (add to /etc/hosts on Linux/Mac or C:\Windows\System32\drivers\etc\hosts on Windows):
    ```
    127.0.0.1 grafana.local
    127.0.0.1 prometheus.local
    127.0.0.1 loki.local
    ```
- Step 4: Start tunnel  
`minikube addons enable ingress`  
`minikube tunnel`  
Expected result: 
    ```
    ✅  Tunnel successfully started
    🏃  Starting tunnel for service nginx-ingress.
    🏃  Starting tunnel for service monitoring-ingress.
    ```

- Step 5: Access the services:

    Grafana: http://grafana.local (admin/admin)  
    Prometheus: http://prometheus.local  
    Loki: http://loki.local  