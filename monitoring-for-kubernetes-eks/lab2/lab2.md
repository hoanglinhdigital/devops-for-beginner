# Lab 2: Log Collection with ELK Stack

In this lab, we will deploy the ElasticSearch, Logstash, and Kibana (ELK) stack to collect and visualize logs from our frontend and backend services. We'll use Filebeat as a DaemonSet to automatically discover and ship container logs to Logstash.

## Step 1: Apply the Log Collection Configuration

First, we need to deploy the ElasticSearch, Kibana, Logstash, and Filebeat resources to our Minikube cluster.

Run the following command to apply the configuration:

```bash
kubectl apply -f log-collection.yaml -n monitoring
```

## Step 2: Verify the Deployment

Verify that all the required pods are up and running:

```bash
kubectl get pods -n monitoring
```

You should see pods for `elasticsearch`, `kibana`, `logstash`, and `filebeat` in the `Running` state, along with your application pods (`frontend`, `backend`, `mongo`).

## Step 3: Access Kibana

Once the pods are running, you can expose the Kibana dashboard to access it from your local machine.

Run the following command to open Kibana in your browser:

```bash
minikube service kibana -n monitoring
```

*(Alternatively, you can use `kubectl port-forward svc/kibana 5601:5601` and access it via `http://localhost:5601`)*

## Step 4: Visualize the Logs in Kibana

To visualize the logs collected from your application:

1. Open the Kibana Web UI using the URL provided by the `minikube service` command (or `http://localhost:5601` if using port-forwarding).
2. Navigate to **Stack Management** (in the left menu, usually under the Management section) > **Index Patterns**.
3. Create a **Create Index pattern** matching the one defined in our Logstash configuration: `todo-app-logs-*`.
4. Select `@timestamp` as the primary time field and complete the setup.
5. Navigate to **Discover** in the left menu.
6. Select your newly created `todo-app-logs-*` index pattern.
7. You should now see the logs populating directly from your frontend and backend applications!
8. Perform some operations on the todo app like adding, deleting, updating todos.
9. Search for some keyword like: `DELETE` to find

## Step 5: Clean up

You can keep monitoring resource for demo/reference. If you want to clean up, run the following command:

```bash
kubectl delete -f log-collection.yaml -n monitoring
```
