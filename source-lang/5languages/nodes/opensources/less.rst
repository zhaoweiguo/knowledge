less
##########
less is more than css

* http://lesscss.org    //english
* http://lesscss.net   //chinese

::

    npm install -g less

    lessc <file>.less <file>.css
    lessc -x <file>.less   // output the compiled CSS




用法::

    // Variables
    @color: #4D926F;
    @height: `document.body.clientHeight`;

    @color: color(`window.colors.baseColor`);
    @darkcolor: darken(@color, 10%);

    // Mixins
    .rounded-corners (@radius: 5px) {
       ...
    }

    // Nested Rules
    #header {
      p { font-size: 12px;
        a { text-decoration: none;
          &:hover { border-width: 1px }   // #header p a:hover
        }
      }
    }

    // Functions & Operations
    (@base-color * 3)
    desaturate(@red, 10%)

    //其他
    ~"<string>"   // Escaping






