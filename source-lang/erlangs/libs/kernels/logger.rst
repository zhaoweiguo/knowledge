logger模块
################
API module for Logger, the standard logging facility in Erlang/OTP.


实例::

  ?LOG_ERROR("error happened because: ~p", [Reason]).   % With macro
  logger:error("error happened because: ~p", [Reason]). % Without macro


sys.config::

  [{kernel,
    [{logger,
      [{
        handler, default, logger_std_h,
        #{config => #{type => {file, "path/to/file.log"}}}
      }]
    }]
  }].

  [{kernel,
      [{
        logger,
        %% Disable the default Kernel handler
        [{handler, default, undefined}]
      }]
    },
    {my_app,
      [{logger,
        %% Enable this handler as the default
        [{handler, default, my_handler, #{}}]
      }]
    }
  ].







