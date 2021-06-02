erlang spec类型
###################

::

  %% Atom indicating the data type that an argument can be converted to.
  -type arg_type()  :: 'atom' | 'binary' | 'boolean'.

  %% Command line option specification.
  -type option_spec() :: {
     Name                         :: atom(),
     Short                        :: char() | undefined,
     Long                         :: string() | undefined,
     ArgSpec                      :: arg_spec(),
     Help                         :: string() | undefined
    }.

  -spec parse_and_check([option_spec()], string() | [string()]) ->
                  {ok, {[option()], [string()]}} | {error, {Reason :: atom(), Data :: term()}}.
  parse_and_check(OptSpecList, CmdLine) ->
      case parse(OptSpecList, CmdLine) of
          {ok, {Opts, _}} = Result ->
              case check(OptSpecList, Opts) of
                  ok    -> Result;
                  Error -> Error
              end;
          Error ->
              Error
      end.












