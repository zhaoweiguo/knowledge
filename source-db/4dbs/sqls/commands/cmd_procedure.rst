procedure存储过程相关
#####################

一.创建存储过程::
  
    create procedure sp_name()
    begin
    .........
    end

二.调用存储过程::
  
    call sp_name()
    注意：存储过程名称后面必须加括号，哪怕该存储过程没有参数传递

三.删除存储过程::
  
    drop procedure sp_name//

    不能在一个存储过程中删除另一个存储过程，只能调用另一个存储过程

四.其他常用命令::
  
    1.show procedure status
    2.show create procedure sp_name

常见问题::

    存储过程有;号,在sql执行时遇到;号就会执行
    解决办法:
    DELIMITER //   #设定出现//才执行
    然后再在命令行时写入procedure代码
    最后输入“//”后procedure就生成了
    DELIMITER ;   #还原设定
    call proc(xxx)

实例
-----
创建带参数的存储过程::

    CREATE PROCUDURE productpricing(  
      OUT p1 DECIMAL(8,2),  
      OUT ph DECIMAL(8,2),  
      OUT pa DECIMAL(8,2)  
    )
    BEGIN  
      SELECT Min(prod_price) INTO pl FROM products;  
      SELECT Max(prod_price) INTO ph FROM products;   
      SELECT Avg(prod_price) INTO pa FROM products;  
    END; 
    //DECIMAL用于指定参数的数据类型
    //OUT用于表明此值是用于从存储过程里输出的
    //MySQL支持 OUT, IN, INOUT

调用带参数的存储过程::

    CALL　productpricing(@pricelow, @pricehigh, @priceaverage);  
    //所有的参数必须以@开头
    //想获取@priceaverage等的值
    SELECT @priceaverage, @pricelow, @priceaverage;

    // 另一个带IN和OUT参数的存储过程
    CREATE PROCEDURE ordertotal(  
      IN onumber INT,  
      OUT ototal DECIMAL(8,2)  
    )  
    BEGIN  
      SELECT Sum(item_price*quantity)  
      FROM orderitems  
      WHERE order_num = onumber 
      INTO ototal;  
    END;  
    // 调用方法
    CALL ordertotal(20005, @total);  
    SELECT @total;  

