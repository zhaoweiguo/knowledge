Agent
=========

::

    docker run -d \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -e DRONE_RPC_PROTO=http \
      -e DRONE_RPC_HOST=drone.zhaoweiguo.com:7080 \
      -e DRONE_RPC_SECRET=bea26a2221fd8090ea3872xxxx45eca6 \
      -e DRONE_RUNNER_CAPACITY=2 \
      -e DRONE_RUNNER_NAME=${HOSTNAME} \
      -p 3333:3000 \
      --restart always \
      --name runner \
      drone/agent:1




