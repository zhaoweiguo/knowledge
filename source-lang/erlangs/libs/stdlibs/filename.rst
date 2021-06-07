filename模块
###################

join/1/2::

  17> filename:join(["/usr", "local", "bin"]).
  "/usr/local/bin"
  18> filename:join(["a/b///c/"]).
  "a/b/c"
  6> filename:join(["B:a\\b///c/"]). % Windows
  "b:a/b/c"

split/1::

  24> filename:split("/usr/local/bin").
  ["/","usr","local","bin"]
  25> filename:split("foo/bar").
  ["foo","bar"]
  26> filename:split("a:\\msdev\\include").
  ["a:/","msdev","include"]

basename/1/2::

  5> filename:basename("foo").
  "foo"
  6> filename:basename("/usr/foo").
  "foo"
  7> filename:basename("/").
  []
  8> filename:basename("/tmp/abc.txt", ".txt").
  "abc"

