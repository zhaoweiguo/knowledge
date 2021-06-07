kubectl expose
#####################

Usage::

    kubectl expose (-f FILENAME | TYPE NAME) [--port=port] 
      [--protocol=TCP|UDP] [--target-port=number-or-name]
      [--name=name] [--external-ip=external-ip-of-service] [--type=type] [options]


实例::

    // 
    $ kubectl expose rc kubia --type=LoadBalancer --name kubia-http

    // minikube 项目介绍中实例
    $ kubectl expose deployment first-deployment --port=80 --type=NodePort

Examples::

      # Create a service for a replicated nginx, which serves on port 80 and connects to the containers on port 8000.
      kubectl expose rc nginx --port=80 --target-port=8000

      # Create a service for a replication controller identified by type and name specified in "nginx-controller.yaml",
    which serves on port 80 and connects to the containers on port 8000.
      kubectl expose -f nginx-controller.yaml --port=80 --target-port=8000

      # Create a service for a pod valid-pod, which serves on port 444 with the name "frontend"
      kubectl expose pod valid-pod --port=444 --name=frontend

      # Create a second service based on the above service, exposing the container port 8443 as port 443 with the name
    "nginx-https"
      kubectl expose service nginx --port=443 --target-port=8443 --name=nginx-https

      # Create a service for a replicated streaming application on port 4100 balancing UDP traffic and named 'video-stream'.
      kubectl expose rc streamer --port=4100 --protocol=udp --name=video-stream

      # Create a service for a replicated nginx using replica set, which serves on port 80 and connects to the containers on
    port 8000.
      kubectl expose rs nginx --port=80 --target-port=8000

      # Create a service for an nginx deployment, which serves on port 80 and connects to the containers on port 8000.
      kubectl expose deployment nginx --port=80 --target-port=8000








