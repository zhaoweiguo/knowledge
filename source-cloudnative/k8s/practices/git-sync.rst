git-sync
##################

Using SSH with git-sync [1]_
===============================

Step 1: Create Secret
--------------------------

前提::

    // Obtain the host keys for your git server:
    $ ssh-keyscan $YOUR_GIT_HOST > /tmp/known_hosts
    // 实例:
    $ ssh-keyscan git.zhaoweiguo.com > /tmp/known_hosts

Method 1::

    // 指定git的密钥和known_hosts(指定secret名: git-creds)
    $> kubectl create secret generic git-creds \
          --from-file=ssh=/Users/zhaoweiguo/.ssh/gordon.git \
          --from-file=known_hosts=/tmp/known_hosts

Method 2::

    {
      "kind": "Secret",
      "apiVersion": "v1",
      "metadata": {
        "name": "git-creds"
      },
      "data": {
        "ssh": <base64 encoded private-key>           # 这儿是密钥的base64
        "known_hosts": <base64 encoded known_hosts>   # 这儿是known_hosts的base64
      }
    }

    // 执行
    $> kubectl create -f /path/to/secret-config.json


Step 2: Configure Pod/Deployment volume
----------------------------------------------

::

    # ...
    volumes:
    - name: git-secret
      secret:
        secretName: git-creds
        defaultMode: 288 # 0440
    # ...

Step 3: Configure git-sync container
------------------------------------------

::

    # ...
    containers:
    - name: git-sync
      image: k8s.gcr.io/git-sync:v9.3.76
      args:
       - "-ssh"
       - "-repo=git@github.com:foo/bar"
       - "-dest=bar"
       - "-branch=master"
      volumeMounts:
      - name: git-secret
        mountPath: /etc/git-secret
      securityContext:
        runAsUser: 65533 # git-sync user
    # ...

最后:完整实例
--------------------

.. literalinclude:: /files/k8s/practices/git-sync.yaml
   :language: yaml


说明::

    1. git免登录所需密钥和known_hosts所需目录: /etc/git-secret
    2. clone下来项目目录: $HOME,这儿是/tmp目录
    3. 使用用户65533和组65533clone项目
    4. 使用defaultMode288指定ssh文件的mode440:
      $> ls -alh /etc/git-secret/..data/
      -r--r----- 1 root nogroup  653 Jul 20 10:57 known_hosts
      -r--r----- 1 root nogroup 1.7K Jul 20 10:57 ssh



git-sync可用命令
---------------------

Usage of ./bin/darwin_amd64/git-sync::

    -alsologtostderr
        log to standard error as well as files
    -branch string
        the git branch to check out (default "master")
    -change-permissions int
        the file permissions to apply to the checked-out files
    -cookie-file
        use git cookiefile
    -depth int
        use a shallow clone with a history truncated to the specified number of commits
    -dest string
        the name at which to publish the checked-out files under --root (defaults to leaf dir of --repo)
    -git string
        the git command to run (subject to PATH search) (default "git")
    -http-bind string
        the bind address (including port) for git-sync's HTTP endpoint
    -http-metrics
        enable metrics on git-sync's HTTP endpoint (default true)
    -http-pprof
        enable the pprof debug endpoints on git-sync's HTTP endpoint
    -log_backtrace_at value
        when logging hits line file:N, emit a stack trace
    -log_dir string
        If non-empty, write log files in this directory
    -logtostderr
        log to standard error instead of files
    -max-sync-failures int
        the number of consecutive failures allowed before aborting (the first pull must succeed, -1 disables aborting for any number of failures after the initial sync)
    -one-time
        exit after the initial checkout
    -password string
        the password to use
    -repo string
        the git repository to clone
    -rev string
        the git revision (tag or hash) to check out (default "HEAD")
    -root string
        the root directory for git operations (default "/Users/zhaoweiguo/git")
    -ssh
        use SSH for git operations
    -ssh-key-file string
        the ssh key to use (default "/etc/git-secret/ssh")
    -ssh-known-hosts
        enable SSH known_hosts verification (default true)
    -ssh-known-hosts-file string
        the known hosts file to use (default "/etc/git-secret/known_hosts")
    -stderrthreshold value
        logs at or above this threshold go to stderr
    -timeout int
        the max number of seconds for a complete sync (default 120)
    -username string
        the username to use
    -v value
        log level for V logs
    -version
        print the version and exit
    -vmodule value
        comma-separated list of pattern=N settings for file-filtered logging
    -wait float
        the number of seconds between syncs
    -webhook-backoff duration
        if a webhook call fails (dependant on webhook-success-status) this defines how much time to wait before retrying the call (default 3s)
    -webhook-method string
        the method for the webook to send with (default "POST")
    -webhook-success-status int
        the status code which indicates a successful webhook call. A value of -1 disables success checks to make webhooks fire-and-forget (default 200)
    -webhook-timeout duration
        the timeout used when communicating with the webhook target (default 1s)
    -webhook-url string
        the URL for the webook to send to. Default is "" which disables the webook.















.. [1] https://github.com/kubernetes/git-sync





