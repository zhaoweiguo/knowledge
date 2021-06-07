变量有效范围
############


if/else
=======

.. note:: if/else-if 条件表达式里的变量声明作用域才会向下到达最后 else 内部, 显而易见的不能向上作用, 作用域范围仅限于本级, 不影响正常的变量作用范围以及屏蔽作用.


实例::

    if result, err := db.Exec(updateSql, ...); err != nil {
      return err
    } else if count, err := result.RowsAffected(); err != nil {
      return err
    } else if count != 1 {
      return ErrNotUpdated
    }

    log.Println(result)   // 🚫注意: 这儿不可用

    // 变量result在整个if/else中都可用










