文档相关
########

exported type xxx should have comment or be unexported::

    // Bird ...this is a nice type.
    type Bird struct {
      Name           string
      LifeExpectance int
    }

    注意: comment on exported type Bird should be of the form "Bird ..." (with optional leading article)

exported method xxx should have comment or be unexportedgo-lint::

    // Fly is fly.
    func (b *Bird) Fly() {
      fmt.Println("I am flying...")
    }

    注意: comment on exported method Bird.Fly should be of the form "Fly ..."






