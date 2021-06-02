.. _erlydtl_command:

命令
===========

* 首先编译erlydtl::

    make

模板编译
--------------

* 四种使用方式::


    erlydtl:compile("/path/to/template.dtl", my_module_name)
    erlydtl:compile("/path/to/template.dtl", my_module_name, Options)
    erlydtl:compile(<<"<html>{{ foo }}</html>">>, my_module_name)
    erlydtl:compile(<<"<html>{{ foo }}</html>">>, my_module_name, Options)


* 编译模板命令中Options是proplist类型可以包含如下选项:

        * `out_dir` - Directory to store generated .beam files. If not specified, no .beam files will be created.

        * `doc_root` - Included template paths will be relative to this directory; defaults to the compiled template's directory.

        * `custom_tags_dir` - Directory of DTL files (no extension) includable as tags. E.g. if $custom_tags_dir/foo contains `<b>{{ bar }}</b>`, then `{% foo bar=100 %}`  will evaluate to `<b>100</b>`. Get it?

        * `custom_tags_modules` - A list of modules to be used for handling custom tags. The modules will be searched in order and take precedence over `custom_tags_dir`. Each custom tag should correspond to an exported function,        e.g.::

            some_tag(Variables, Context) -> iolist()

The `Context` is specified at render-time with the `custom_tags_context` option.

    * `custom_filters_modules` - A list of modules to be used for handling custom filters. The modules will be searched in order and take precedence over the    built-in filters. Each custom filter should correspond to an exported filter,    e.g::

        some_filter(Value) -> iolist()

    * If the filter takes an argument (e.g. "foo:2"), the argument will be also be passed in::

        some_filter(Value, Arg) -> iolist()

    * `vars` - Variables (and their values) to evaluate at compile-time rather than render-time. 

    * `reader` - {module, function} tuple that takes a path to a template and returns    a binary with the file contents. Defaults to `{file, read_file}`. Useful    for reading templates from a network resource.

    * `compiler_options` - Proplist passed directly to `compiler:forms/2`

    * `force_recompile` - Recompile the module even if the source's checksum has not    changed. Useful for debugging.

    * `locale` - The locale used for template compile. Requires erlang_gettext. It    will ask gettext_server for the string value on the provided locale.    For example, adding {locale, "en_US"} will call {key2str, Key, "en_US"}    for all string marked as trans (`{% trans "StringValue" %}` on templates).    See README_I18N.

    * `blocktrans_fun` - A two-argument fun to use for translating `blocktrans`    blocks. This will be called once for each pair of `blocktrans` block and locale    specified in `blocktrans_locales`. The fun should take the form::

        Fun(Block::string(), Locale::string()) -> <<"ErlyDTL code">> | default

    * `blocktrans_locales` - A list of locales to be passed to `blocktrans_fun`.Defaults to [].

    * `binary_strings` - Whether to compile strings as binary terms (rather than lists). Defaults to `true`.



Helper编译
------------------

Helpers provide additional templating functionality and can be used in conjunction with the `custom_tags_module` option above. They can be created
from a directory of templates thusly::

    erlydtl:compile_dir("/path/to/dir", my_helper_module_name)
    
    erlydtl:compile_dir("/path/to/dir", my_helper_module_name, Options)

The resulting module will export a function for each template appearing in the specified directory. Options is the same as for compile/3.

Compiling a helper module can be more efficient than using `custom_tags_dir` because the helper functions will be compiled only once (rather than once
per template).


(编译后模板的)用法
----------------------------------

* 使用编译后的模板:


* 方法一:

    * 命令::

        my_compiled_template:render(Variables) -> {ok, IOList} | {error, Err}

    * Variables is a proplist, dict, gb_tree, or a parameterized module (whose method names correspond to variable names). The variable values can be atoms, strings, binaries, or (nested) variables.
    * IOList is the rendered template.

* 和上面一样，增加Option参数:

    * 命令::

        my_compiled_template:render(Variables, Options) ->  {ok, IOList} | {error, Err}

    * `translation_fun` - A fun/1 that will be used to translate strings appearing inside `{% trans %}` tags. The simplest TranslationFun would be `fun(Val) -> Val end`
    * `locale` - A string specifying the current locale, for use with the `blocktrans_fun` compile-time option.
    * `custom_tags_context` - A value that will be passed to custom tags.

* 其他命令::

    my_compiled_template:translatable_strings() -> [String]
    my_compiled_template:translated_blocks() -> [String]
    my_compiled_template:source() -> {FileName, CheckSum}
    my_compiled_template:dependencies() -> [{FileName, CheckSum}]



