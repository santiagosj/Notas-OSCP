# 🧠 Kubernetes / DevSecOps Cheatsheet
⚡ kubectl + kind + docker (Express Edition)

### 🐳 DOCKER Cheatsheet
🔹 Imágenes
```bash
docker images
docker pull nginx
docker build -t myapp:latest .
```
🔹 Contenedores
```bash
docker ps
docker ps -a
docker run -it ubuntu bash
docker run -d -p 8080:80 nginx
docker stop <id>
docker rm <id>
```
🔹 Logs y debugging
```bash
docker logs <container>
docker exec -it <container> bash
```
🔹 Limpieza
```bash
docker system prune -a
docker rm -f $(docker ps -aq)
docker rmi -f $(docker images -q)
```

### ☸️ KIND Cheatsheet (Kubernetes local rápido)
🔥 Crear cluster local
```bash
kind create cluster
kind create cluster --name dev
```
📋 Listar clusters
```bash
kind get clusters
```
❌ Borrar cluster
```bash
kind delete cluster
kind delete cluster --name dev
```

### 🧩 Cluster con config (multi-node)

kind-config.yaml
```bash
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
```
```bash
kind create cluster --config kind-config.yaml
```
📦 Cargar imágenes Docker dentro del cluster
```bash
docker build -t myapp:latest .
kind load docker-image myapp:latest
```

🔍 Exportar kubeconfig
```bash
kubectl cluster-info --context kind-dev
```

### ☸️ KUBECTL Cheatsheet (el arma principal)
✅ Estado general
```bash
kubectl version --client
kubectl cluster-info
kubectl get nodes
kubectl get namespaces
```
📦 Pods
Listar pods
```bash
kubectl get pods
kubectl get pods -A
kubectl get pods -n default
```
Ver detalles
```bash
kubectl describe pod <pod>
```
Logs
```bash
kubectl logs <pod>
kubectl logs -f <pod>
kubectl logs <pod> -c <container>
```

Entrar a un pod

```bash
kubectl exec -it <pod> -- bash
kubectl exec -it <pod> -- sh
```

### 🚀 Deployments
Listar
```bash
kubectl get deployments
kubectl get deploy -A
```
Crear rápido (imperativo)
```bash
kubectl create deployment nginx --image=nginx
```
Escalar
```bash
kubectl scale deployment nginx --replicas=5
```
Rolling restart
```bash
kubectl rollout restart deployment nginx
```
Ver rollout status
```bash
kubectl rollout status deployment nginx
```

🌐 Services

Listar servicios
```bash
kubectl get svc
```

Exponer deployment
```bash
kubectl expose deployment nginx --port=80 --type=ClusterIP
kubectl expose deployment nginx --port=80 --type=NodePort
```

Port forwarding
```bash
kubectl port-forward pod/<pod> 8080:80
kubectl port-forward svc/nginx 8080:80
```

### 📁 Namespaces
Crear

```bash
kubectl create ns dev
```
Usar namespace

```bash
kubectl get pods -n dev
```

Set default namespace

```bash
kubectl config set-context --current --namespace=dev
```

### 📜 YAML Workflows
Aplicar manifests
```bash
kubectl apply -f deployment.yaml
kubectl apply -f .
```
Borrar manifests
```bash
kubectl delete -f deployment.yaml
```
Ver manifest live
```bash
kubectl get pod <pod> -o yaml
```

### 🔍 Debugging rápido
Ver eventos del cluster
```bash
kubectl get events -A
```
Pod no levanta?
```bash
kubectl describe pod <pod>
kubectl logs <pod>
```
Ver recursos consumidos
```bash
kubectl top pods
kubectl top nodes
```

(requiere metrics-server)

### 🧨 Borrar cosas rápido

Pod
```bash
kubectl delete pod <pod>
```
Deployment
```bash
kubectl delete deploy nginx
```
Namespace completo (nuke)
```bash
kubectl delete ns dev
```
### 🔐 Secrets & ConfigMaps

ConfigMap
```bash
kubectl create configmap app-config --from-literal=ENV=prod
kubectl get configmap
```
Secret
```bash
kubectl create secret generic db-secret \
  --from-literal=password=1234
```

### 🧠 Contextos (multi clusters)
```bash
kubectl config get-contexts
kubectl config use-context kind-dev
```