api
###

gRPC gateway endpoint has changed since etcd v3.3::

    1. etcd v3.2 or before uses only [CLIENT-URL]/v3alpha/*.

    2. etcd v3.3 uses [CLIENT-URL]/v3beta/* while keeping [CLIENT-URL]/v3alpha/*.

    3. etcd v3.4 uses [CLIENT-URL]/v3/* while keeping [CLIENT-URL]/v3beta/*.
       [CLIENT-URL]/v3alpha/* is deprecated.
    
    4. etcd v3.5 or later uses only [CLIENT-URL]/v3/*.
      [CLIENT-URL]/v3beta/* is deprecated.


实例(以v3.4+版本为例)
=====================

Put and get keys
----------------

Use the /v3/kv/range and /v3/kv/put services to read and write keys::

    <<COMMENT
    https://www.base64encode.org/
    foo is 'Zm9v' in Base64
    bar is 'YmFy'
    COMMENT

    curl -L http://localhost:2379/v3/kv/put \
      -X POST -d '{"key": "Zm9v", "value": "YmFy"}'
    # {"header":{"cluster_id":"12585971608760269493","member_id":"13847567121247652255","revision":"2","raft_term":"3"}}

    curl -L http://localhost:2379/v3/kv/range \
      -X POST -d '{"key": "Zm9v"}'
    # {"header":{"cluster_id":"12585971608760269493","member_id":"13847567121247652255","revision":"2","raft_term":"3"},"kvs":[{"key":"Zm9v","create_revision":"2","mod_revision":"2","version":"1","value":"YmFy"}],"count":"1"}

    # get all keys prefixed with "foo"
    curl -L http://localhost:2379/v3/kv/range \
      -X POST -d '{"key": "Zm9v", "range_end": "Zm9w"}'
    # {"header":{"cluster_id":"12585971608760269493","member_id":"13847567121247652255","revision":"2","raft_term":"3"},"kvs":[{"key":"Zm9v","create_revision":"2","mod_revision":"2","version":"1","value":"YmFy"}],"count":"1"}

Watch keys
----------

Use the /v3/watch service to watch keys::

    curl -N http://localhost:2379/v3/watch \
      -X POST -d '{"create_request": {"key":"Zm9v"} }' &
    # {"result":{"header":{"cluster_id":"12585971608760269493","member_id":"13847567121247652255","revision":"1","raft_term":"2"},"created":true}}

    curl -L http://localhost:2379/v3/kv/put \
      -X POST -d '{"key": "Zm9v", "value": "YmFy"}' >/dev/null 2>&1
    # {"result":{"header":{"cluster_id":"12585971608760269493","member_id":"13847567121247652255","revision":"2","raft_term":"2"},"events":[{"kv":{"key":"Zm9v","create_revision":"2","mod_revision":"2","version":"1","value":"YmFy"}}]}}


Transactions
------------

Issue a transaction with /v3/kv/txn::

    # target CREATE
    curl -L http://localhost:2379/v3/kv/txn \
      -X POST \
      -d '{"compare":[{"target":"CREATE","key":"Zm9v","createRevision":"2"}],"success":[{"requestPut":{"key":"Zm9v","value":"YmFy"}}]}'
    # {
        "header":{
            "cluster_id":"12585971608760269493",
            "member_id":"13847567121247652255",
            "revision":"3","raft_term":"2"
        },
        "succeeded":true,
        "responses":[{"response_put":{"header":{"revision":"3"}}}]
      }

    # target VERSION
    curl -L http://localhost:2379/v3/kv/txn \
      -X POST \
      -d '{"compare":[{"version":"4","result":"EQUAL","target":"VERSION","key":"Zm9v"}],"success":[{"requestRange":{"key":"Zm9v"}}]}'
    # {
        "header":{
            "cluster_id":"14841639068965178418",
            "member_id":"10276657743932975437",
            "revision":"6",
            "raft_term":"3"
        },
        "succeeded":true,
        "responses":[{
            "response_range":{
                "header":{"revision":"6"},
                "kvs":[{"key":"Zm9v","create_revision":"2","mod_revision":"6","version":"4","value":"YmF6"}],
                "count":"1"
            }
        }]}

Authentication
--------------

Set up authentication with the /v3/auth service::

    # create root user
    curl -L http://localhost:2379/v3/auth/user/add \
      -X POST -d '{"name": "root", "password": "pass"}'
    # {"header":{"cluster_id":"14841639068965178418","member_id":"10276657743932975437","revision":"1","raft_term":"2"}}

    # create root role
    curl -L http://localhost:2379/v3/auth/role/add \
      -X POST -d '{"name": "root"}'
    # {"header":{"cluster_id":"14841639068965178418","member_id":"10276657743932975437","revision":"1","raft_term":"2"}}

    # grant root role
    curl -L http://localhost:2379/v3/auth/user/grant \
      -X POST -d '{"user": "root", "role": "root"}'
    # {"header":{"cluster_id":"14841639068965178418","member_id":"10276657743932975437","revision":"1","raft_term":"2"}}

    # enable auth
    curl -L http://localhost:2379/v3/auth/enable -X POST -d '{}'
    # {"header":{"cluster_id":"14841639068965178418","member_id":"10276657743932975437","revision":"1","raft_term":"2"}}

Authenticate with etcd for an authentication token using /v3/auth/authenticate::

    # get the auth token for the root user
    curl -L http://localhost:2379/v3/auth/authenticate \
      -X POST -d '{"name": "root", "password": "pass"}'
    # {"header":{"cluster_id":"14841639068965178418","member_id":"10276657743932975437","revision":"1","raft_term":"2"},"token":"sssvIpwfnLAcWAQH.9"}


Set the Authorization header to the authentication token to fetch a key using authentication credentials::

    curl -L http://localhost:2379/v3/kv/put \
      -H 'Authorization : sssvIpwfnLAcWAQH.9' \
      -X POST -d '{"key": "Zm9v", "value": "YmFy"}'
    # {"header":{"cluster_id":"14841639068965178418","member_id":"10276657743932975437","revision":"2","raft_term":"2"}}













