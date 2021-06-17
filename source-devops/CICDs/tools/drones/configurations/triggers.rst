触发器triggers
=================


branch实例::

    trigger:
      branch:
      - master

    // include syntax:
    trigger:
      branch:
        include:
        - master
        - feature/*

    // exclude syntax:
    trigger:
      branch:
        exclude:
        - master
        - feature/*

事件event::

    trigger:
      event:
      - push
      - pull_request
      - tag
      - promote
      - rollback

    // include syntax:
    trigger:
      event:
        include:
        - push
        - pull_request

    // exclude syntax:
    trigger:
      event:
        exclude:
        - pull_request

Reference::

    trigger:
      ref:
      - refs/heads/master
      - refs/heads/**
      - refs/pull/*/head

    trigger:
      ref:
        include:
        - refs/heads/feature-*
        - refs/pull/**
        - refs/tags/**

    trigger:
      ref:
        exclude:
        - refs/heads/feature-*
        - refs/pull/**
        - refs/tags/**

Repository::

    trigger:
      repo:
      - octocat/hello-world

    trigger:
      repo:
        include:
        - octocat/hello-world
        - spacebhost/hello-world
        - octocat/*

    trigger:
      repo:
        exclude:
        - octocat/hello-world
        - spacebhost/hello-world

Instance::

    trigger:
      instance:
      - drone.instance1.com
      - drone.instance2.com
      - *.company.com

    trigger:
      instance:
        include:
        - drone.instance1.com
        - drone.instance2.com

    trigger:
      instance:
        exclude:
        - drone.instance1.com
        - drone.instance2.com

Status::

    trigger:
      status:
      - failure

    trigger:
      status:
      - success
      - failure

Target::

    // This only applies to promotion and rollback events.
    trigger:
      target:
      - production

    trigger:
      target:
        include:
        - staging
        - production

    trigger:
      target:
        exclude:
        - production


    指定多个triggers::

        // 所有触发器都为true才会触发
        trigger:
          branch:
          - master
          event:
          - push



