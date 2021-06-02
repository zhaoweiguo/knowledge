kubedog
#############

* github [1]_

Installation
============

Install library::

    $ go get github.com/flant/kubedog

Install CLI::

    https://bintray.com/flant/kubedog/kubedog/_latestVersion

MacOS专用::

    $ curl -L https://dl.bintray.com/flant/kubedog/v0.3.2/kubedog-darwin-amd64-v0.3.2 -o /tmp/kubedog
    $ chmod +x /tmp/kubedog
    $ sudo mv /tmp/kubedog /usr/local/bin/kubedog

Linux专用::

    $ curl -L https://dl.bintray.com/flant/kubedog/v0.3.2/kubedog-linux-amd64-v0.3.2 -o /tmp/kubedog
    $ chmod +x /tmp/kubedog
    $ sudo mv /tmp/kubedog /usr/local/bin/kubedog

使用
====

.. note:: Cli utility is intent to be used to observe library abilities and for debug purposes.Multitracker can be used in CI/CD deploy pipeline to make sure that some set of resources is ready or done before proceeding deploy process.

* There are 3 modes of resource tracking: multitrack, follow(DEPRECATION) and rollout(DEPRECATION)

multitrack最简单使用::

    cat << EOF | kubedog multitrack
    {
      "StatefulSets": [
        {
          "ResourceName": "mysts1",
          "Namespace": "myns"
        }
      ],
      "Deployments": [
        {
          "ResourceName": "mydeploy22",
          "Namespace": "myns"
        }
      ]
    }
    EOF

实例1::

    $ echo '{
        "StatefulSets":[{"ResourceName":"mysts1","Namespace":"myns"}],
        "Deployments":[{"ResourceName":"mydeploy22","Namespace":"myns"}]
      }' | kubedog multitrack
    $ kubectl -n myns get po
    $ kubectl -n myns delete po mydeploy22-5bxxxxx-xxx mysts1-0 mysts1-1 --force --grace-period=0
    // 再监测
    $ echo '{
        "StatefulSets":[{"ResourceName":"mysts1","Namespace":"myns"}],
        "Deployments":[{"ResourceName":"mydeploy22","Namespace":"myns"}]
      }' | kubedog multitrack

.. image:: /images/k8s/tools/kubedog-multitrack-cmd.gif


实例2::

    $ echo '{
        "DaemonSets":[{"ResourceName":"mysts1","Namespace":"myns"}], 
        "StatefulSets":[{"ResourceName":"mysts1","Namespace":"myns"}],
        "Deployments":[{"ResourceName":"mydeploy22","Namespace":"myns"}]
      }' | kubedog multitrack --output-prefix="     "
    $ kubectl -n myns get po
    $ kubectl -n myns delete po mydeploy22-5bxxxxx-xxx mysts1-0 mysts1-1 myds1-xxxxx --force --grace-period=0
    // 再监测:
    $ echo '{
        "DaemonSets":[{"ResourceName":"mysts1","Namespace":"myns"}], 
        "StatefulSets":[{"ResourceName":"mysts1","Namespace":"myns"}],
        "Deployments":[{"ResourceName":"mydeploy22","Namespace":"myns"}]
      }' | kubedog multitrack --output-prefix="     "

.. image:: /images/k8s/tools/kubedog-multitrack-with-output-prefix.gif


实例3::

    $ echo '{
            "Deployments":[
              {
                "ResourceName":"mydeploy",
                "Namespace":"myns"
              },
              {
                "ResourceName":"myresource",
                "Namespace":"myns",
                "FailMode":"HopeUntilEndOfDeployProcess",
                "AllowFailuresCount":3,
                "SkipLogsForContainers":["two", "three"]
              }
            ], 
            "StatefulSets":[
              {
                  "ResourceName":"mysts",
                  "Namespace":"myns"
              }
            ]}' | kubedog multitrack








.. [1] https://github.com/flant/kubedog