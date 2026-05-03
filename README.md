# Laravel Kubernetes Deployment (Docker + kubeadm + Helm)## Project OverviewThis project deploys a Laravel application into a Kubernetes cluster using **Docker**, **kubeadm**, and **Helm**.The application includes:- `/` route returns: **Laravel Kubernetes Deployment Test**- `/health` endpoint returns HTTP **200 OK**Ingress is configured with hostname:- `laravel-test.local`---## Prerequisites- Ubuntu Linux- Docker installed- Kubernetes cluster created using kubeadm- kubectl installed and configured- Helm installed- Ingress NGINX controller installed- DockerHub account---## Laravel Application Routes### Home Route
GET /
Laravel Kubernetes Deployment Test
### Health Check Route
GET /health
Returns HTTP 200 OK
Example implementation in `routes/web.php`:```phpuse Illuminate\Support\Facades\Route;Route::get('/', function () {    return "Laravel Kubernetes Deployment Test";});Route::get('/health', function () {    return response()->json(['status' => 'ok'], 200);});

Docker Setup
Dockerfile
A production-ready multi-service container was created using:


PHP 8.2 FPM


Nginx


Supervisor


Build Docker Image
docker build -t 12amit1234/laravel-k8s-app:1.1 .
Push Docker Image
docker push 12amit1234/laravel-k8s-app:1.1
DockerHub Image URL
https://hub.docker.com/r/12amit1234/laravel-k8s-app

Kubernetes Cluster Setup (kubeadm)
This cluster was created using kubeadm.
Verify Nodes
kubectl get nodes -o wide
Verify Cluster Info
kubectl cluster-info
Verify All Pods
kubectl get pods -A
Verify Ingress Resources
kubectl get ingress -A

CNI Plugin
CNI plugin installed: Calico
Verification:
kubectl get pods -n kube-system

Ingress Controller Setup
Ingress controller used: ingress-nginx
Verify ingress-nginx:
kubectl get pods -n ingress-nginxkubectl get svc -n ingress-nginx

Helm Chart Deployment
Helm Chart Includes:


Deployment


Service


Ingress


ConfigMap


Secret


PVC


Resource requests/limits


Liveness probe


Readiness probe


SecurityContext



Helm Commands
Install Application
kubectl create namespace laravelhelm install laravel-app ./laravel-chart -n laravel
Upgrade Application
helm upgrade laravel-app ./laravel-chart -n laravel
Uninstall Application
helm uninstall laravel-app -n laravel

Configuration (ConfigMap + Secret)
ConfigMap
APP_ENV is loaded from ConfigMap.
Secret
APP_KEY is loaded from Secret.
Verify:
kubectl get configmap -n laravelkubectl get secret -n laravel

Persistent Volume Claim (PVC)
Storage is mounted using PVC.
Check PVC status:
kubectl get pvc -n laravel

Laravel Runtime Commands
These commands are required for Laravel production runtime:
php artisan config:cachephp artisan route:cachephp artisan migratephp artisan storage:link
In this assignment, these are not automatically executed inside the container because:


Migration depends on database availability


Production caching should be controlled manually or by CI/CD pipeline



Ingress Testing
Ingress host configured:
laravel-test.local
Add Host Entry
Edit /etc/hosts:
sudo nano /etc/hosts
Add:
192.168.28.131 laravel-test.local
Test Using Curl
curl -I http://laravel-test.local/curl -I http://laravel-test.local/health
Expected:


/ returns 200


/health returns 200



Verify Deployment Status
kubectl get all -n laravelkubectl get pods -n laravel -o widekubectl get ingress -n laravel

Troubleshooting
1. Helm install fails due to namespace issues
Fix:
kubectl delete namespace laravel --grace-period=0 --forcekubectl create namespace laravel
2. Ingress returning nginx 404
Cause: ingressClassName missing
Fix: Add this to ingress.yaml:
spec:  ingressClassName: nginx
3. DNS error: Could not resolve host
Fix /etc/hosts entry:
192.168.28.131 laravel-test.local
4. PVC stuck in Pending
Cause: No default StorageClass
Fix: install local-path provisioner:
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yamlkubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

Assumptions


Kubernetes cluster created using kubeadm


Node has internet access to pull Docker image


ingress-nginx is installed and working



Production Improvement Suggestions


Use separate MySQL/PostgreSQL database (StatefulSet)


Use Redis for cache/session


Enable TLS using cert-manager + Let’s Encrypt


Add HPA for autoscaling


Add PodDisruptionBudget


Add NetworkPolicy


Add separate queue worker deployment


Add scheduler CronJob


Add CI/CD pipeline with GitHub Actions


Use private registry secrets if required


Run container as non-root



Submission
GitHub Repository:
https://github.com/1234amit/laravel-assignment-with-devoops
---# ✅ Next StepNow do:```bashnano README.md
Paste this full content → Save.
Then push:
git add README.mdgit commit -m "add full README documentation"git push origin main

If you want, I can also generate Bonus YAMLs (HPA + PDB + NetworkPolicy) to increase your score.
