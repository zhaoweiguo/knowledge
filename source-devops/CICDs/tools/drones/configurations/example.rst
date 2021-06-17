实例
####

实例1:

.. literalinclude:: /files/drones/demo1.yml


实例2::

    kind: pipeline
    name: {your-pipeline-name}

    steps:
    - name: Kubernetes 部署
      image: guoxudongdocker/kubectl
      volumes:
      - name: kube
        path: /root/.kube
      commands:
        - cd deploy/overlays/dev    # 这里使用 kustomize ,详细使用方法请见 https://github.com/kubernetes-sigs/kustomize
        - kustomize edit set image {your-docker-registry}:${DRONE_BUILD_NUMBER}
        - kubectl apply -k . && kubedog rollout track deployment {your-deployment-name} -n {your-namespace} -t {your-tomeout}

    ...

    volumes:
    - name: kube
      host:
        path: /tmp/cache/.kube  # kubeconfig 挂载位置

    trigger:
      branch:
      - master  # 触发 CI 的分支



