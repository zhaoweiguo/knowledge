原始explain函数 [1]_
####################

.. note:: Although MongoDB provides the explain command, the preferred method for running explain is to use the ``db.collection.explain()`` and ``cursor.explain()`` helpers.





语法::

    {
       explain: <command>,
       verbosity: <string>,
       comment: <any>
    }

verbosity::

    "queryPlanner"
    "executionStats"
    "allPlansExecution" (Default)

comment



实例::

    db.runCommand(
       {
         explain: { count: "products", query: { quantity: { $gt: 50 } } },
         verbosity: "queryPlanner"
       }
    )


实战
====

我想explain带limit的count，但如下命令不可用::

    db.zwg_log.explain("executionStats").count({
      "user_id": "ceafb78f483180b651f76b185ce0e3ab",
      "is_delete": "0"
    }).limit(30)

需要使用::

    db.runCommand({
      explain: {
        count: "zwg_log",
        query: {
          "user_id": "ceafb78f483180b651f76b185ce0e3ab",
          "is_delete": "0"
        },
        limit:30
      },
      verbosity: "executionStats"
    })



.. [1] https://docs.mongodb.com/manual/reference/command/explain/