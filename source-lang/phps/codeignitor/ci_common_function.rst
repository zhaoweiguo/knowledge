.. _ci_common_function:

CI常用函数(common function)
=================================

* 全局的，不需要载入任何libraries或helpers
* 是否版本号大于'5.3.0'(是返回TRUE,否则返回FALSE)::

    is_php('5.3.0')

* show_error('message'), show_404('page'), log_message('level', 'message')
* set_status_header(code, 'text')::

    set_status_header(401);
    // Sets the header as: Unauthorized



