指针
####

When to Use Pointers [1]_
=========================

the two biggest hazards of working with pointers are::

    hazards /'hæzɚd/
    n. 危险；危害；障碍（hazard的复数）
    v. 使冒危险；赌（hazard的三单形式）

    Accidental nil pointer dereferences
    (意外的 nil 指针取消引用)
    Accidental mutation of something you didn’t want mutated
    (意外突变了您不想突变的事物)

Accidental nil
==============

实例::

    func main() {
      // ...
      s := storage.GetS("foobar")
      fmt.Println(s.Name)
    }

    GetS(string id) *S {
      return nil
    }

Accidental mutation
===================

实例::

    type S struct {
      Name string
    }

    func printUpper(s *S) {
      s.Name = strings.ToUpper(s.Name)
      fmt.Println(s.Name)
    }

    func main() {
      s := &S{
        Name: "foo",
      }
      printUpper(s)
      fmt.Println(s.Name)
    }

说明::

    printUpper函数改变了 s 的内容，这可能不是你期望的











.. [1] https://medium.com/@kent.rancourt/go-pointers-when-to-use-pointers-4f29256ddff3