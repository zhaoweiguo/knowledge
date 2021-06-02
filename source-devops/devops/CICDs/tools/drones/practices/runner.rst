Runner
=========

::

    $ docker run -d \
      -e DRONE_RPC_PROTO=https \
      -e DRONE_RPC_HOST=drone.company.com \
      -e DRONE_RPC_SECRET=super-duper-secret \
      -p 3000:3000 \
      --restart always \
      --name runner \
      drone/drone-runner-ssh









