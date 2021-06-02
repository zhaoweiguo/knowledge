uglifyjs
----------------
JavaScript parser / mangler / compressor / beautifier library for NodeJS

基本命令::

  uglifyjs inet.js -o inet-min.js
  // -m参数所以就是把变量名变成a, b, c, d
  uglifyjs inet.js -m -o inet.min.js
  
常见参数::

  -m, --mangle                  Mangle names/pass mangler options.
  -c, --compress                Enable compressor/pass compressor options
  -p, --prefix                  Skip prefix for original filenames that appear
    
    




