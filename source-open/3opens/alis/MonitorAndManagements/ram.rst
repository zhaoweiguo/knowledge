访问控制(RAM)服务 [1]_
######################

授权策略管理
================

管理日志服务(Log)的快速查询权限::

    {
      "Version": "1",
      "Statement": [
        {
          "Action": [
            "log:CreateSavedSearch",
            "log:UpdateSavedSearch",
            "log:GetSavedSearch",
            "log:DeleteSavedSearch",
            "log:ListSavedSearch",
            "log:CreateIndex",
            "log:GetIndex",
            "log:UpdateIndex"
          ],
          "Resource": [
            "acs:log:*:*:project/iot-ol-slb-access-log/*",
            "acs:log:*:*:project/iot-ol-engine-log/*",
            "acs:log:*:*:project/iot-ol-device/*"
          ],
          "Effect": "Allow"
        }
      ]
    }


管理对象存储服务(OSS)权限::

    {
      "Version": "1",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "oss:ListBuckets"
          ],
          "Resource": "acs:oss:*:*:*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "oss:ListObjects",
            "oss:GetBucketAcl"
          ],
          "Resource": [
            "acs:oss:*:*:cn-rd-file",
            "acs:oss:*:*:cn-pvt-file"
          ]
        },
        {
          "Effect": "Allow",
          "Action": [
            "oss:ListBuckets",
            "oss:PutBucket",
            "oss:ListObjects",
            "oss:GetObject",
            "oss:PutObject"
          ],
          "Resource": [
            "acs:oss:*:*:cn-rd-file/*",
            "acs:oss:*:*:cn-pvt-file/*"
          ]
        }
      ]
    }


k8s::

    {
      "Version": "1",
      "Statement": [
        {
          "Action": [
            "ecs:Describe*",
            "ecs:AttachDisk",
            "ecs:CreateDisk",
            "ecs:CreateSnapshot",
            "ecs:CreateRouteEntry",
            "ecs:DeleteDisk",
            "ecs:DeleteSnapshot",
            "ecs:DeleteRouteEntry",
            "ecs:DetachDisk",
            "ecs:ModifyAutoSnapshotPolicyEx",
            "ecs:ModifyDiskAttribute",
            "ecs:CreateNetworkInterface",
            "ecs:DescribeNetworkInterfaces",
            "ecs:AttachNetworkInterface",
            "ecs:DetachNetworkInterface",
            "ecs:DeleteNetworkInterface",
            "ecs:DescribeInstanceAttribute"
          ],
          "Resource": [
            "*"
          ],
          "Effect": "Allow"
        },
        {
          "Action": [
            "slb:*"
          ],
          "Resource": [
            "*"
          ],
          "Effect": "Allow"
        },
        {
          "Action": [
            "cms:*"
          ],
          "Resource": [
            "*"
          ],
          "Effect": "Allow"
        },
        {
          "Action": [
            "vpc:*"
          ],
          "Resource": [
            "*"
          ],
          "Effect": "Allow"
        },
        {
          "Action": [
            "log:*"
          ],
          "Resource": [
            "*"
          ],
          "Effect": "Allow"
        },
        {
          "Action": [
            "nas:*"
          ],
          "Resource": [
            "*"
          ],
          "Effect": "Allow"
        }
      ]
    }


rds::

    {
      "Statement": [
        {
          "Action": "rds:Describe*",
          "Effect": "Allow",
          "Resource": [
            "acs:rds:*:*:dbinstance/rm-2ze032adcw1085ovb",
            "acs:rds:*:*:dbinstance/rm-2ze1894iu95x80035"
          ]
        }
      ],
      "Version": "1"
    }

k8s-docker-registry-accessfull-rules::

    {
      "Statement": [
        {
          "Action": [
            "cr:*"
          ],
          "Effect": "Allow",
          "Resource": [
            "acs:cr:*:*:repository/octopus-test/*"
          ]
        }
      ],
      "Version": "1"
    }

redis::

    {
      "Statement": [
        {
          "Action": "kvstore:Describe*",
          "Effect": "Allow",
          "Resource": "acs:kvstore:*:*:dbinstance/r-2ze8e76a84dd9754"
        }
      ],
      "Version": "1"
    }

















.. [1] https://ram.console.aliyun.com/