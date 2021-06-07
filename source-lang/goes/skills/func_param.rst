函数作为参数的使用技巧
######################

在client-go中有这么一段代码，有人提 `issue <https://github.com/cloudnativeto/sig-k8s-source-code/issues/17>`_ 问出这个疑问::

    func (r *Request) Do(ctx context.Context) Result {
      var result Result
      err := r.request(ctx, func(req *http.Request, resp *http.Response) {
        result = r.transformResponse(resp, req)
      })
      if err != nil {
        return Result{err: err}
      }
      return result
    }


    func (r *Request) request(ctx context.Context, fn func(*http.Request, *http.Response)) error {
    ...
        resp, err := client.Do(req)
    ...
        fn(req, resp)
        return true
    }


问题: 为什么Do要用传入 fn 的形式 去转换 Response, 直接按照下面的写不行么, 例如::

    func (r *Request) Do(ctx context.Context) Result {
      result, err := r.request(ctx)
            if err != nil {
        return Result{err: err}
      }
      return result
    }

    func (r *Request) request(ctx context.Context, fn func(*http.Request, *http.Response)) (Result, error) {
    ...
        resp, err := client.Do(req)
    ...
       result = r.transformResponse(resp, req)
       return result, nil
    }

里面lianghao208的回答特别好::

    我个人认为这样写可以将request方法和fn解耦
    比如这里的Do方法中的fn为transformResponse，
      是clientSet将apiserver返回的资源对象反序列化成kubernetes的资源对象数据结构的方法实现，
    而下面的DoRaw方法的transformUnstructuredResponseError又是另一种fn的实现，
      我们可以还可以自己实现fn对clientSet进行封装，这样可重用性会更好。

DoRaw函数::

    func (r *Request) DoRaw() ([]byte, error) {
      err := r.request(func(req *http.Request, resp *http.Response) {
        ...
        result.body, result.err = ioutil.ReadAll(resp.Body)
        glogBody("Response Body", result.body)
        if resp.StatusCode < http.StatusOK || resp.StatusCode > http.StatusPartialContent {
          result.err = r.transformUnstructuredResponseError(resp, req, result.body)
        }
      })
      ...
      return result.body, result.err
    }






