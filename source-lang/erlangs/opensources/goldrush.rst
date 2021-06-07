goldrush [1]_
#################################
简介::

  OTP的事件处理与监控
  Small, Fast event processing and monitoring for Erlang/OTP applications.
  Goldrush is a small Erlang app that provides fast event stream processing

基本语法::

  glc:gt(a, 0).   => {Key, '>', Term}
  glc:gte(a, 0).  => {Key, '>=', Term}
  glc:eq(a, 0).   => {Key, '=', Term}
  glc:neq(a, 0).  => {Key, '!=', Term}
  glc:lt(a, 0).   => {Key, '<', Term}
  glc:lte(a, 0).  => {Key, '=<', Term}
  glc:wc(a).      => {Key, '*'}       % all events where ‘a’ exists
  glc:nf(a).      => {Key, '!'}       % all events where ‘a’ does not exist.
  glc:null(false).=> {null, false}    % no input events. User as a black hole query.
  glc:null(true). => {null, true}     % all input events. Used as a passthrough query.

高级语法::

  glc:all([_|_]=Conds) => {all, Conds}
  glc:any([_|_]=Conds) => {any, Conds};

  % Select all events where both ‘a’ AND ‘b’ exists and are greater than 0.
  glc:all([glc:gt(a, 0), glc:gt(b, 0)]).
  % Select all events where ‘a’ OR ‘b’ exists and are greater than 0.
  glc:any([glc:gt(a, 0), glc:gt(b, 0)]).
  % Select all events where ‘a’ AND ‘b’ exists where ‘a’ is greater than 1 and ‘b’ is less than 2.
  glc:all([glc:gt(a, 1), glc:lt(b, 2)]).
  % Select all events where ‘a’ OR ‘b’ exists where ‘a’ is greater than 1 and ‘b’ is less than 2.
  glc:any([glc:gt(a, 1), glc:lt(b, 2)]).

Reduced语法::

  % Select all events where 
  %   ‘a’ is equal to 1, ‘b’ is equal to 2 and ‘c’ is equal to 3 
  %   and collapse any duplicate logic.
  glc_lib:reduce(
    glc:all([
        glc:any([glc:eq(a, 1), glc:eq(b, 2)]),
        glc:any([glc:eq(a, 1), glc:eq(c, 3)])])).

  %等同于
  glc:all([glc:eq(a, 1), glc:eq(b, 2), glc:eq(c, 3)]).










.. [1] https://github.com/DeadZen/goldrush



