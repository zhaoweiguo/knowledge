.. _php_basic_exception:

php预定义异常
==================

* Exception::

    Exception {
       /* 属性 */
       protected string $message ;
       protected int $code ;
       protected string $file ;
       protected int $line ;

       /* 方法 */
       public __construct ([ string $message = "" [, int $code = 0 [, Exception $previous = NULL ]]] )
       final public string getMessage ( void )
       final public Exception getPrevious ( void )
       final public int getCode ( void )
       final public string getFile ( void )
       final public int getLine ( void )
       final public array getTrace ( void )
       final public string getTraceAsString ( void )
       public string __toString ( void )
       final private void __clone ( void )
   }



* ErrorException::

    ErrorException extends Exception {
        /* 属性 */
        protected int $severity ;
        /* 方法 */
        public __construct ([ string $message = "" [, int $code = 0 [, int $severity = 1 [, string $filename = __FILE__ [, int $lineno = __LINE__ [, Exception $previous = NULL ]]]]]] )
        final public int getSeverity ( void )
        /* 继承的方法 */
        final public string Exception::getMessage ( void )
        final public Exception Exception::getPrevious ( void )
        final public int Exception::getCode ( void )
        final public string Exception::getFile ( void )
        final public int Exception::getLine ( void )
        final public array Exception::getTrace ( void )
        final public string Exception::getTraceAsString ( void )
        public string Exception::__toString ( void )
        final private void Exception::__clone ( void )
    }



