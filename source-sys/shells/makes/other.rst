其他
#########

::

    :: is just a Naming Convention for function names. 
      It is a coding-style such as snake_case or CamelCase
    如:
    kube::golang::build_binaries
    // 在别的地方定义了这个函数,如:
    function kube::util::sourced_variable {
      # Call this function to tell shellcheck that a variable is supposed to
      # be used from other calling context. This helps quiet an "unused
      # variable" warning from shellcheck and also document your code.
      true
    }


    local code="${1:-1}"



