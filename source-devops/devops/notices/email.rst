邮箱
########

go版本::

    import "gopkg.in/gomail.v2"
    func httpEmail(filename string, title string, body string) {
      m := gomail.NewMessage()

      m.SetHeader("From", "from@163.com")
      m.SetHeader("To", "to1@163.com", "to2@163.com")
      //m.SetAddressHeader("Cc", "cc@163.com", "Dan")
      m.SetHeader("Subject", title)
      m.SetBody("text/plain", body)
      //m.Attach("/home/Alex/lolcat.jpg")

      filename = fmt.Sprintf("%s.xlsx", filename)
      m.Attach(fmt.Sprintf("/tmp/%s", filename),
        gomail.SetHeader(map[string][]string{
          "Content-Disposition": []string{
            fmt.Sprintf(`attachment; filename="%s"`, mime.QEncoding.Encode("UTF-8", filename)),
          },
        }))

      d := gomail.NewDialer("smtp.163.com", 80, "from@163.com", "AQSWdefr123456")

      // Send the email to Bob, Cora and Dan.
      if err := d.DialAndSend(m); err != nil {
        panic(err)
      }
      log.Println("ok")
    }






