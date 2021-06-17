api
####

hook
====

基本::

    post  http://<host>:<port>/hook

Request headers::

    Content-Type: application/json
    X-Gitlab-Event: Push Hook
    X-Gitlab-Token: DvNWngbe7SBujanLqd2KtTs3d6hYDOBu


Request body:

.. literalinclude:: ./hook.json


Response headers::

    Date: Tue, 26 Nov 2019 08:05:12 GMT
    Content-Type: application/json
    Content-Length: 657
    Connection: close
    Cache-Control: no-cache, no-store, must-revalidate, private, max-age=0
    Expires: Thu, 01 Jan 1970 00:00:00 UTC
    Pragma: no-cache
    X-Frame-Options: DENY
    X-Xss-Protection: 1; mode=block

Response body::

    {
      "id": 67,
      "repo_id": 117,
      "trigger": "@hook",
      "number": 5,
      "status": "pending",
      "event": "push",
      "action": "",
      "link": "http://gitlab.com/zhaoweiguo/test-drone2/commit/b64c5011760f62e7b0f91ac3c3b6601ba71855ff",
      "timestamp": 0,
      "message": "update\n",
      "before": "",
      "after": "426463f21a30e9c5cb2da2aff0987a13213e090c",
      "ref": "refs/heads/master",
      "source_repo": "",
      "source": "master",
      "target": "master",
      "author_login": "zhaoweiguo",
      "author_name": "zhaoweiguo",
      "author_email": "",
      "author_avatar": "https://www.gravatar.com/avatar/a11d9508187d0744109511002c5dfd26?s=80\u0026d=identicon",
      "sender": "zhaoweiguo",
      "started": 0,
      "finished": 0,
      "created": 1574755512,
      "updated": 1574755512,
      "version": 1
    }








