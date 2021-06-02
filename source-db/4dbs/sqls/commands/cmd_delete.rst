delete命令
---------------
::

    DELETE FROM <tbl_name> [WHERE where_definition]

    -- delete join语法
    DELETE customers
    FROM customers
    LEFT JOIN orders ON customers.customerNumber = orders.customerNumber
    WHERE orderNumber IS NULL;

    DELETE offices, employees
    FROM offices
    INNER JOIN employees
          ON employees.officeCode = employees.officeCode
          WHERE offices.officeCode = 5
