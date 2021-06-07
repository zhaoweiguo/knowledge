goconvey
########

* github: https://github.com/smartystreets/goconvey

安装::

    $ go install github.com/smartystreets/goconvey

使用::

    $ cd /path/
    $ goconvey

    $GOPATH/bin/goconvey -help

    Usage of goconvey:
      -cover=true: Enable package-level coverage statistics. Warning: this will obfuscate line number reporting on panics and build failures! Requires Go 1.2+ and the go cover tool. (default: true)
      -gobin="go": The path to the 'go' binary (default: search on the PATH).
      -host="127.0.0.1": The host at which to serve http.
      -packages=10: The number of packages to test in parallel. Higher == faster but more costly in terms of computing. (default: 10)
      -poll=250ms: The interval to wait between polling the file system for changes (default: 250ms).
      -port=8080: The port at which to serve http.



Features::

    Customize the watched directory
    Automatically updates when .go files are changed
    Test code generator
    Browser notifications (with enable/disable and the option to notify on any status, only success, or only panic/failure)
    Colored diff on most failing tests' outputs
    Nested display of GoConvey tests for easy reading
    Supports traditional Go tests
    Responsive layout so you can squish the browser next to the code if you have to
    Panics, failed builds, and failed tests are highlighted
    Silky-smooth appearance and transitions
    Direct link to the problem lines (opens your favorite editor--some assembly required)


Code generator::

    注: 这个功能可以通过打开web页面中有个功能进行转换

    Test Integer Stuff
      Subject: Integer incrementation and decrementation
        Given a starting integer value
          When incremented
            The value should be greater by one
            The value should NOT be what it used to be
          When decremented
            The value should be lesser by one
            The value should NOT be what it used to be

    转化为==> 

    import (
      "testing"
      . "github.com/smartystreets/goconvey/convey"
    )

    func TestIntegerStuff(t *testing.T) {

      Convey("Subject: Integer incrementation and decrementation", t, func() {

        Convey("Given a starting integer value", func() {

          Convey("When incremented", func() {

            Convey("The value should be greater by one", nil)

            Convey("The value should NOT be what it used to be", nil)

          })

          Convey("When decremented", func() {

            Convey("The value should be lesser by one", nil)

            Convey("The value should NOT be what it used to be", nil)

          })

        })

      })

    }









