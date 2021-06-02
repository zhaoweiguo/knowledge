kubectl patch
##################

SYNOPSIS::

    // 以打包的形式更新补丁
    kubectl patch [OPTIONS]

常用选项::

    // todo

实例::

    // 给sa增加imagePullSecrets
    kubectl patch serviceaccount <saName> -p '{"imagePullSecrets": [{"name": "regcred"}]}'

    // 为此container增加一个环境变量
    // 注: 如增加一个无用的环境变量, 可用于重启Pod
    $ kubectl patch deployment <deployment-name> \
      -p '{"spec":{"template":{"spec":{"containers":[{"name":"<container-name>","env":[{"name":"RESTART_","value":"'$(date +%s)'"}]}]}}}}'





OPTIONS::

    --allow-missing-template-keys=true
       If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and json-
    path output formats.

    --dry-run=false
       If true, only print the object that would be sent, without sending it.

    -f, --filename=[]
       Filename, directory, or URL to files identifying the resource to update

    -k, --kustomize=""
       Process the kustomization directory. This flag can't be used together with -f or -R.

    --local=false
       If true, patch will operate on the content of the file, not the server-side resource.

    -o, --output=""
       Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.

    -p, --patch=""
       The patch to be applied to the resource JSON file.

    --record=false
       Record current kubectl command in the resource annotation. If set to false, do not record  the  command.  If  set  to  true,
    record the command. If not set, default to updating the existing annotation value only if one already exists.

    -R, --recursive=false
       Process  the directory used in -f, --filename recursively. Useful when you want to manage related manifests organized within
    the same directory.

    --template=""
       Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang tem-
    plates [ <http://golang.org/pkg/text/template/#pkg-overview>].

    --type="strategic"
       The type of patch being provided; one of [json merge strategic]




