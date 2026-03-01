# Grafana Dashboard Setup Guide

This guide will walk you through setting up Grafana dashboards to visualize metrics from your todo-app deployment using Prometheus as a data source.

## Prerequisites

Before starting, ensure:
- ✅ Monitoring stack is deployed (`kubectl apply -f todo-app-monitoring-stack.yaml`)
- ✅ Prometheus is running (`kubectl get pods -n monitoring`)
- ✅ Grafana is running (`kubectl get pods -n monitoring`)
- ✅ Todo-app is deployed and running

---

## Access Grafana

Use the default credentials:
- **Username:** `admin`
- **Password:** `admin`

> **Note:** Grafana may prompt you to change the password on first login. You can skip this for development purposes.

---

## Verify Prometheus Data Source

The Prometheus data source should already be configured automatically. Let's verify it:

### Step 1: Navigate to Data Sources

1. Click on the **☰ menu** (hamburger icon) in the top-left corner
2. Go to **Connections** → **Data sources**
3. You should see **Prometheus** listed

### Step 2: Test the Data Source

1. Click on **Prometheus**
2. Scroll down to the bottom
3. Click **Save & test** button
4. You should see a green message: ✅ **"Data source is working"**

### Step 3: Manual Configuration (if needed)

If Prometheus is not configured, add it manually:

1. Click **Add data source**
2. Select **Prometheus**
3. Configure the following:
   - **Name:** `Prometheus`
   - **URL:** `http://prometheus:9090`
   - **Access:** `Server (default)`
4. Click **Save & test**

---

## Create Your First Dashboard

### Step 1: Create a New Dashboard

1. Click on the **☰ menu** → **Dashboards**
2. Click **New** → **New Dashboard**
3. Click **Add visualization**
4. Select **Prometheus** as the data source

### Step 2: Configure Your First Panel

You're now in the panel editor. Let's create a panel showing pod status.

---

## Add Dashboard Panels

### Panel 1: Pod Status Overview

**Purpose:** Show which pods are up or down

1. **Panel Title:** "Pod Status - Default Namespace"
2. **Query:**
   ```promql
   up{kubernetes_namespace="default"}
   ```
3. **Visualization:** 
   - Click on the visualization type dropdown (top-right)
   - Select **Stat** or **Table**
4. **Panel Options:**
   - In the right sidebar, find "Panel options"
   - Set **Title:** `Pod Status - Default Namespace`
5. **Value Mappings** (Optional):
   - Scroll to "Value mappings" in the right sidebar
   - Add mapping: `1` → `UP` (green)
   - Add mapping: `0` → `DOWN` (red)
6. Click **Apply** (top-right corner)

---

### Panel 2: Backend Pod Count

**Purpose:** Monitor the number of running backend pods

1. Click **Add** → **Visualization**
2. **Query:**
   ```promql
   count(up{kubernetes_pod_name=~"backend-deployment.*"} == 1)
   ```
3. **Visualization:** Select **Stat**
4. **Panel Options:**
   - **Title:** `Backend Pods Running`
   - **Description:** `Number of healthy backend pods`
5. **Standard Options:**
   - **Unit:** Select `short` (for whole numbers)
   - **Color scheme:** Choose a color (e.g., green for healthy)
6. **Thresholds:**
   - Base: 0 (red)
   - Add threshold: 1 (yellow)
   - Add threshold: 2 (green)
7. Click **Apply**

---

### Panel 3: Frontend Pod Count

**Purpose:** Monitor the number of running frontend pods

1. Click **Add** → **Visualization**
2. **Query:**
   ```promql
   count(up{kubernetes_pod_name=~"frontend-deployment.*"} == 1)
   ```
3. **Visualization:** Select **Stat**
4. **Panel Options:**
   - **Title:** `Frontend Pods Running`
5. **Thresholds:**
   - Base: 0 (red)
   - Add threshold: 1 (yellow)
   - Add threshold: 2 (green)
6. Click **Apply**

---

### Panel 4: Memory Usage Graph

**Purpose:** Visualize memory usage over time

1. Click **Add** → **Visualization**
2. **Query A (Backend):**
   ```promql
   container_memory_usage_bytes{pod=~"backend-deployment.*", container="backend"}
   ```
3. **Query B (Frontend):**
   - Click **+ Query** to add another query
   ```promql
   container_memory_usage_bytes{pod=~"frontend-deployment.*", container="frontend"}
   ```
4. **Visualization:** Select **Time series** (graph)
5. **Panel Options:**
   - **Title:** `Memory Usage Over Time`
6. **Legend:**
   - In the right sidebar, find "Legend"
   - Set **Legend mode:** `Table`
   - Enable **Values:** `Last`, `Max`, `Mean`
7. **Standard Options:**
   - **Unit:** `bytes(IEC)` (will show as MB, GB, etc.)
8. **Graph Styles:**
   - **Line width:** 2
   - **Fill opacity:** 10
9. Click **Apply**

---

### Panel 5: CPU Usage Graph

**Purpose:** Monitor CPU usage over time

1. Click **Add** → **Visualization**
2. **Query A (Backend):**
   ```promql
   rate(container_cpu_usage_seconds_total{pod=~"backend-deployment.*", container="backend"}[5m])
   ```
3. **Query B (Frontend):**
   ```promql
   rate(container_cpu_usage_seconds_total{pod=~"frontend-deployment.*", container="frontend"}[5m])
   ```
4. **Visualization:** Select **Time series**
5. **Panel Options:**
   - **Title:** `CPU Usage (5m rate)`
6. **Standard Options:**
   - **Unit:** `percent (0.0-1.0)`
7. Click **Apply**

---

### Panel 6: Pod Restart Count

**Purpose:** Track pod restarts to identify stability issues

1. Click **Add** → **Visualization**
2. **Query:**
   ```promql
   kube_pod_container_status_restarts_total{namespace="default"}
   ```
3. **Visualization:** Select **Table**
4. **Panel Options:**
   - **Title:** `Pod Restart Count`
5. **Transform Data** (optional):
   - Click on **Transform** tab
   - Add transformation: **Organize fields**
   - Hide unnecessary columns
6. Click **Apply**

---

### Panel 7: Network Traffic

**Purpose:** Monitor network I/O

1. Click **Add** → **Visualization**
2. **Query A (Received):**
   ```promql
   rate(container_network_receive_bytes_total{pod=~"backend-deployment.*"}[5m])
   ```
3. **Query B (Transmitted):**
   ```promql
   rate(container_network_transmit_bytes_total{pod=~"backend-deployment.*"}[5m])
   ```
4. **Visualization:** Select **Time series**
5. **Panel Options:**
   - **Title:** `Backend Network Traffic`
6. **Standard Options:**
   - **Unit:** `bytes/sec(IEC)`
7. Click **Apply**

---

## Import Pre-built Dashboards

Grafana has thousands of community-built dashboards you can import.

### Step 1: Browse Dashboards

Visit [Grafana Dashboards](https://grafana.com/grafana/dashboards/) and search for:
- "Kubernetes"
- "Prometheus"
- "Node Exporter"
- "Container Monitoring"

### Step 2: Import a Dashboard

Popular dashboard for Kubernetes monitoring:
- **Kubernetes Cluster Monitoring:** Dashboard ID `7249`
- **Kubernetes Pod Monitoring:** Dashboard ID `6417`

To import:

1. Click **☰ menu** → **Dashboards**
2. Click **New** → **Import**
3. Enter dashboard ID (e.g., `7249`)
4. Click **Load**
5. Select **Prometheus** as the data source
6. Click **Import**

### Step 3: Customize Imported Dashboard

1. Click **⚙️ Dashboard settings** (gear icon)
2. Modify panels as needed
3. Save as a new dashboard to preserve the original


