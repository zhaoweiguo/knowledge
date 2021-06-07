Coap协议Node实例
######################



Simple Demo
---------------
package.json

.. code-block:: json

  {
      "dependencies":{
          "coap": "0.7.2"
      }
  }

server.js

.. code-block:: javascript

  const coap    = require('coap')
  , server  = coap.createServer()

  server.on('request', function(req, res) {
      res.end('Hello ' + req.url.split('/')[1] + '\n')
  })

  server.listen(function() {
      console.log('server started')
  })

client.js

.. code-block:: javascript

  const coap  = require('coap')
  , req   = coap.request('coap://localhost/xukai871105')

  req.on('response', function(res) {
      res.pipe(process.stdout)
  })

  req.end()

使用::

  > node server.js &
  > node client.js
  Hello xukai871105

实例2
---------
server.js

.. code-block:: javascript

  var coap = require('coap');
  var server = coap.createServer();
   
  server.on('request',
  function(req, res) {
      console.log(req.headers);
   
      // 请求头中必须包括application/json
      if (req.headers['Accept'] != 'application/json') {
          res.code = '4.06';
          return res.end();
      }
   
      res.setOption('Content-Format', 'application/json');
      res.end(JSON.stringify({
          hello: "world"
      }));
  });
   
  server.listen(function() {
      console.log('server started');
  });

client.js

.. code-block:: javascript

  var coap = require('coap');
  var bl = require('bl');
  var req = coap.request({
      pathname: '/',
      options: {
          'Accept': 'application/json'
      }
  });
   
  req.on('response',
  function(res) {
      console.log('response code', res.code);
   
      if (res.code !== '2.05') return process.exit(1);
   
      res.pipe(bl(function(err, data) {
          var json = JSON.parse(data);
          console.log(json);
          process.exit(0);
      }))
  });
   
  req.end();












