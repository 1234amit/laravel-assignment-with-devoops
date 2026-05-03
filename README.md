<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Laravel Kubernetes Deployment</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      margin: 40px;
      color: #222;
    }
    h1, h2, h3 {
      color: #1a73e8;
    }
    code {
      background: #f4f4f4;
      padding: 2px 6px;
      border-radius: 4px;
    }
    pre {
      background: #f4f4f4;
      padding: 10px;
      border-radius: 6px;
      overflow-x: auto;
    }
    ul {
      margin-left: 20px;
    }
    .section {
      margin-bottom: 30px;
    }
  </style>
</head>

<body>

<h1>🚀 Laravel Kubernetes Deployment (Docker + kubeadm + Helm)</h1>

<p>A production-ready deployment of a Laravel application on a Kubernetes cluster using Docker, kubeadm, and Helm.</p>

<hr>

<div class="section">
  <h2>📌 Project Overview</h2>
  <p>This project demonstrates deploying a Laravel application into a Kubernetes cluster with full DevOps workflow:</p>
  <ul>
    <li>Dockerized Laravel application</li>
    <li>Kubernetes cluster (kubeadm)</li>
    <li>Helm-based deployment</li>
    <li>Ingress routing</li>
    <li>ConfigMap & Secret management</li>
    <li>Persistent storage (PVC)</li>
  </ul>
</div>

<div class="section">
  <h2>🌐 Application Endpoints</h2>
  <table border="1" cellpadding="8">
    <tr>
      <th>Route</th>
      <th>Description</th>
      <th>Response</th>
    </tr>
    <tr>
      <td>/</td>
      <td>Home route</td>
      <td>Laravel Kubernetes Deployment Test</td>
    </tr>
    <tr>
      <td>/health</td>
      <td>Health check</td>
      <td>200 OK</td>
    </tr>
  </table>
</div>

<div class="section">
  <h2>🏷️ Ingress Configuration</h2>
  <ul>
    <li><b>Host:</b> laravel-test.local</li>
    <li><b>Controller:</b> ingress-nginx</li>
  </ul>
</div>

<div class="section">
  <h2>⚙️ Prerequisites</h2>
  <ul>
    <li>Ubuntu Linux</li>
    <li>Docker</li>
    <li>Kubernetes (kubeadm cluster)</li>
    <li>kubectl</li>
    <li>Helm</li>
    <li>Ingress NGINX Controller</li>
    <li>DockerHub account</li>
  </ul>
</div>

<div class="section">
  <h2>🧩 Laravel Routes</h2>

  <h3>📍 Home Route</h3>
  <pre>
Route::get('/', function () {
    return "Laravel Kubernetes Deployment Test";
});
  </pre>

  <h3>❤️ Health Check Route</h3>
  <pre>
Route::get('/health', function () {
    return response()->json(['status' => 'ok'], 200);
});
  </pre>
</div>

<div class="section">
  <h2>🐳 Docker Setup</h2>

  <h3>📦 Stack Includes</h3>
  <ul>
    <li>PHP 8.2 FPM</li>
    <li>Nginx</li>
    <li>Supervisor</li>
  </ul>

  <h3>🔨 Build Image</h3>
  <pre>docker build -t 12amit1234/laravel-k8s-app:1.1 .</pre>

  <h3>📤 Push Image</h3>
  <pre>docker push 12amit1234/laravel-k8s-app:1.1</pre>

  <p><b>🐋 DockerHub:</b> https://hub.docker.com/r/12amit1234/laravel-k8s-app</p>
</div>

<div class="section">
  <h2>☸️ Kubernetes Cluster Setup (kubeadm)</h2>

  <h3>🔍 Verify Cluster</h3>
  <pre>
kubectl get nodes -o wide
kubectl cluster-info
kubectl get pods -A
kubectl get ingress -A
  </pre>

  <h3>🌐 Networking</h3>
  <ul>
    <li><b>CNI:</b> Calico</li>
    <li><b>Ingress:</b> ingress-nginx</li>
  </ul>
</div>

<div class="section">
  <h2>⚓ Helm Deployment</h2>

  <h3>📦 Chart Includes</h3>
  <ul>
    <li>Deployment</li>
    <li>Service</li>
    <li>Ingress</li>
    <li>ConfigMap</li>
    <li>Secret</li>
    <li>PVC</li>
    <li>Resource limits</li>
    <li>Liveness & Readiness probes</li>
  </ul>

  <h3>🚀 Install</h3>
  <pre>
kubectl create namespace laravel
helm install laravel-app ./laravel-chart -n laravel
  </pre>

  <h3>🔄 Upgrade</h3>
  <pre>helm upgrade laravel-app ./laravel-chart -n laravel</pre>

  <h3>🗑️ Uninstall</h3>
  <pre>helm uninstall laravel-app -n laravel</pre>
</div>

<div class="section">
  <h2>⚙️ ConfigMap & Secrets</h2>
  <ul>
    <li>APP_ENV managed via ConfigMap</li>
    <li>APP_KEY stored in Secret</li>
  </ul>
  <pre>
kubectl get configmap -n laravel
kubectl get secret -n laravel
  </pre>
</div>

<div class="section">
  <h2>💾 Persistent Storage (PVC)</h2>
  <pre>kubectl get pvc -n laravel</pre>
</div>

<div class="section">
  <h2>🌍 Ingress Testing</h2>

  <h3>Add Host Entry</h3>
  <pre>192.168.28.131 laravel-test.local</pre>

  <h3>Test</h3>
  <pre>
curl -I http://laravel-test.local/
curl -I http://laravel-test.local/health
  </pre>
</div>

<div class="section">
  <h2>📊 Verify Deployment</h2>
  <pre>
kubectl get all -n laravel
kubectl get pods -n laravel -o wide
kubectl get ingress -n laravel
  </pre>
</div>

<div class="section">
  <h2>🛠️ Troubleshooting</h2>

  <ul>
    <li><b>Helm failure:</b> recreate namespace</li>
    <li><b>Ingress 404:</b> add ingressClassName</li>
    <li><b>DNS issue:</b> update /etc/hosts</li>
    <li><b>PVC pending:</b> install storage class</li>
  </ul>
</div>

<div class="section">
  <h2>🧠 Assumptions</h2>
  <ul>
    <li>kubeadm cluster initialized</li>
    <li>Internet access available</li>
    <li>ingress-nginx installed</li>
  </ul>
</div>

<div class="section">
  <h2>🚀 Production Improvements</h2>
  <ul>
    <li>MySQL/PostgreSQL StatefulSet</li>
    <li>Redis caching</li>
    <li>TLS (Let’s Encrypt)</li>
    <li>HPA autoscaling</li>
    <li>NetworkPolicy</li>
    <li>CI/CD pipeline</li>
    <li>Queue workers</li>
    <li>Private registry</li>
  </ul>
</div>

<div class="section">
  <h2>📂 Repository</h2>
  <p>👉 https://github.com/1234amit/laravel-assignment-with-devoops</p>
</div>

<div class="section">
  <h2>🎯 Done</h2>
  <pre>
git add README.md
git commit -m "Improve README documentation"
git push origin main
  </pre>
</div>

</body>
</html>
