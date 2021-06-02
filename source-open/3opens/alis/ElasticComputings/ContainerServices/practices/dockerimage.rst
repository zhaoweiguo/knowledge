免密拉取镜像 [1]_
#################
实例::

    {
      "Action": [
        "cr:Get*",
        "cr:List*",
        "cr:PullRepository"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }


.. [1] https://help.aliyun.com/document_detail/103178.html