***********
Parallelism
***********

实例::

    kind: pipeline
    type: docker
    name: default

    steps:
    - name: backend
      image: golang
      commands:
      - go build
      - go test

    - name: frontend
      image: node
      commands:
      - npm install
      - npm test

    - name: notify
      image: plugins/slack
      settings:
        webhook:
          from_secret: webhook
      depends_on:
      - frontend
      - backend




