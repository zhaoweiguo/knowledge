代码相关
''''''''''
.. function:: check_process_code/3

::

    check_process_code(Pid, Module, OptionList) -> CheckResult | async
    类型:
    Module = module()
    RequestId = term()
    Option = {async, RequestId} | {allow_gc, boolean()}
    OptionList = [Option]
    CheckResult = boolean() | aborted

Options::

    {allow_gc, boolean()}
    Determines if garbage collection is allowed when performing the operation. If {allow_gc, false} is passed, and a garbage collection is needed to determine the result of the operation, the operation is aborted (see information on CheckResult below). The default is to allow garbage collection, that is, {allow_gc, true}.

    {async, RequestId}
    The function check_process_code/3 returns the value async immediately after the request has been sent. When the request has been processed, the process that called this function is passed a message on the form {check_process_code, RequestId, CheckResult}.


返回值CheckResult::

    true
    The process identified by Pid executes old code for Module. That is, the current call of the process executes old code for this module, or the process has references to old code for this module, or the process contains funs that references old code for this module.

    false
    The process identified by Pid does not execute old code for Module.

    aborted
    The operation was aborted, as the process needed to be garbage collected to determine the operation result, and the operation was requested by passing option {allow_gc, false}.