{application,testwm,
             [{description,"testwm"},
              {vsn,"1"},
              {modules,[testwm,testwm_app,testwm_resource,testwm_sup]},
              {registered,[]},
              {applications,[kernel,stdlib,inets,crypto,mochiweb,webmachine]},
              {mod,{testwm_app,[]}},
              {env,[]}]}.
