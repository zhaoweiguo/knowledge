kubectl convert
###############

Convert config files between different API versions. Both YAML and JSON formats are accepted.


Usage::

    kubectl convert -f FILENAME [options]

Options::

    --allow-missing-template-keys=true: 
        If true, ignore any errors in templates when a field or map key is missing in the template. 
        Only applies to golang and jsonpath output formats.

    -f, --filename=[]: 
        Filename, directory, or URL to files to need to get converted.

    -k, --kustomize='': 
        Process the kustomization directory. 
        This flag can't be used together with -f or -R.

    --local=true: 
        If true, convert will NOT try to contact api-server but run locally.

    -o, --output='yaml': Output format. One of:
        json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.

    --output-version='': 
        Output the formatted object with the given group version (for ex: 'extensions/v1beta1').

    -R, --recursive=false: 
        Process the directory used in -f, --filename recursively. 
        Useful when you want to manage related manifests organized within the same directory.

    --template='': 
        Template string or path to template file to use when -o=go-template, -o=go-template-file. 
        The template format is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    --validate=true: If true, use a schema to validate the input before sending it

实例::

    # Convert 'pod.yaml' to latest version and print to stdout.
    kubectl convert -f pod.yaml

    # Convert all files under current directory to latest version and create them all.
    kubectl convert -f . | kubectl create -f -

    # Convert the live state of the resource specified by 'pod.yaml' to the latest version
    # and print to stdout in JSON format.
    kubectl convert -f pod.yaml --local -o json

.. warning:: ``kubectl convert`` is deprecated since v1.14 and will be removed in v1.17












