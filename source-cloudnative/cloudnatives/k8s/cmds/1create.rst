kubectl create
####################


Usage::

    // Create a resource from a file or from stdin.
    // JSON and YAML formats are accepted.
    kubectl create -f FILENAME [options]

    kubectl create secret generic NAME [--type=string] [--from-file=[key=]source] [--from-literal=key1=value1] [--dry-run] [options]

实例::

    // 创建
    // -f, --filename=[]
    kubectl create -f ./pod.json
    kubectl create -f ./pod.yaml
    cat pod.json | kubectl create -f -
    kubectl create -f docker-registry.yaml --edit -o json

    // 创建ns
    $ kubectl create namespace <nsName>
    // 创建资源时指定ns
    $ kubectl create -f xxx.yaml -n <nsName>

    // 创建Secret
    $> ssh-keyscan $YOUR_GIT_HOST > /tmp/known_hosts
    $> kubectl create secret generic git-creds \
        --from-file=ssh=$HOME/.ssh/id_rsa \
        --from-file=known_hosts=/tmp/known_hosts

    // 创建clusterrolebinding绑定clusterrole与sa(foo:default)
    $ kubectl create clusterrolebinding pv-test --clusterrole=pv-reader --serviceaccount=foo:default

Available Commands::

    clusterrole         Create a ClusterRole.
    clusterrolebinding  Create a ClusterRoleBinding for a particular ClusterRole
    configmap           Create a configmap from a local file, directory or literal value
    deployment          Create a deployment with the specified name.
    job                 Create a job with the specified name.
    namespace           Create a namespace with the specified name
    poddisruptionbudget Create a pod disruption budget with the specified name.
    priorityclass       Create a priorityclass with the specified name.
    quota               Create a quota with the specified name.
    role                Create a role with single rule.
    rolebinding         Create a RoleBinding for a particular Role or ClusterRole
    secret              Create a secret using specified subcommand
    service             Create a service using specified subcommand.
    serviceaccount      Create a service account with the specified name

Options::

        --allow-missing-template-keys=true: If true, ignore any errors in templates when a field or map key is missing in
  the template. Only applies to golang and jsonpath output formats.
        --dry-run=false: If true, only print the object that would be sent, without sending it.
        --edit=false: Edit the API resource before creating
    -f, --filename=[]: Filename, directory, or URL to files to use to create the resource
    -o, --output='': Output format. One of:
  json|yaml|name|go-template|go-template-file|templatefile|template|jsonpath|jsonpath-file.
        --raw='': Raw URI to POST to the server.  Uses the transport specified by the kubeconfig file.
        --record=false: Record current kubectl command in the resource annotation. If set to false, do not record the
  command. If set to true, record the command. If not set, default to updating the existing annotation value only if one
  already exists.
    -R, --recursive=false: Process the directory used in -f, --filename recursively. Useful when you want to manage
  related manifests organized within the same directory.
        --save-config=false: If true, the configuration of current object will be saved in its annotation. Otherwise, the
  annotation will be unchanged. This flag is useful when you want to perform kubectl apply on this object in the future.
    -l, --selector='': Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2)
        --template='': Template string or path to template file to use when -o=go-template, -o=go-template-file. The
  template format is golang templates [http://golang.org/pkg/text/template/#pkg-overview].
        --validate=true: If true, use a schema to validate the input before sending it
        --windows-line-endings=false: Only relevant if --edit=true. Defaults to the line ending native to your platform.





