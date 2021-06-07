release_handler模块
########################

Unpacking and Installation of Release Packages

简介
'''''''''

状态::

  unpacked, current, permanent, or old
  % 各状态转换:

  Status     Action                NextStatus
  -------------------------------------------
  -          unpack                unpacked
  unpacked   install               current
             remove                -
  current    make_permanent        permanent
             install other         old
             remove                -
  permanent  make other permanent  old
             install               permanent
  old        reboot_old            permanent
             install               current
             remove                -

framework包含::

  Offline support - systools for generating scripts and building release packages
  Online support - release_handler for unpacking and installing release packages


install_release/1/2
'''''''''''''''''''''''''
结构::

  install_release(Vsn) -> {ok, OtherVsn, Descr} | {error, Reason}
  install_release(Vsn, [Opt]) -> {ok, OtherVsn, Descr} | {continue_after_restart, OtherVsn, Descr} | {error, Reason}
  类型:
  Vsn = OtherVsn = string()
  Opt = {error_action, Action} | {code_change_timeout, Timeout}
     | {suspend_timeout, Timeout} | {update_paths, Bool}
   Action = restart | reboot
   Timeout = default | infinity | pos_integer()
   Bool = boolean()
  Descr = term()
  Reason = {illegal_option, Opt} | {already_installed, Vsn} | {change_appl_data, term()} | {missing_base_app, OtherVsn, App} | {could_not_create_hybrid_boot, term()} | term()
  App = atom()

make_permanent/1
''''''''''''''''''''''
结构::

  make_permanent(Vsn) -> ok | {error, Reason}
  类型:
  Vsn = string()
  Reason = {bad_status, Status} | term()
  Makes the specified release version Vsn permanent.

remove_release/1
''''''''''''''''''''
结构::

  remove_release(Vsn) -> ok | {error, Reason}
  Types
  Vsn = string()
  Reason = {permanent, Vsn} | client_node | term()
  Removes a release and its files from the system. The release must not be the permanent release. Removes only the files and directories not in use by another release.






