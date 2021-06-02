git mv命令
####################
说明::

  Move or rename a file, a directory, or a symlink
  The index is updated after successful completion, but the change must still be committed
  git mv [-v] [-f] [-n] [-k] <source> <destination>
  git mv [-v] [-f] [-n] [-k] <source> ... <destination directory>

选项::

  -n, --dry-run: 
    Do nothing; only show what would happen
  -v, --verbose
  -f, --force
    Force renaming or moving of a file even if the target exists
  -k:
    Skip move or rename actions which would lead to an error condition. An error happens when a source is
    neither existing nor controlled by Git, or when it would overwrite an existing file unless -f is given




