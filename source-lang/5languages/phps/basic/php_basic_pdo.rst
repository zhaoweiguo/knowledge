.. _simpledb:

简单的数据库实例
===================

from: http://wiki.hashphp.org/PDO_Tutorial_for_MySQL_Developers
* db_test.php(PDO)::

    <?php
    include('db_login.php');

    $db = new PDO('mysql:host=localhost;dbname=testdb;charset=utf8', 'username', 'password');
    
    // 请求得到全部数据
    try {
      $stmt = $db->query("SELECT * FROM table");
      return $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch(PDOException $ex) {
      //handle me.
    }

    // 一条条进行操作
    foreach($db->query('SELECT * FROM table') as $row) {
       echo $row['field1'].' '.$row['field2']; //etc...
    }

    // 得到请求条数
    $stmt = $db->query('SELECT * FROM table');
    $row_count = $stmt->rowCount();

    // Getting the Last Insert Id
    $result = $db->exec("INSERT INTO table(firstname, lastname) VAULES('John', 'Doe')");
    $insertId = $db->lastInsertId();

    // Running Simple INSERT, UPDATE, or DELETE statements
    $affected_rows = $db->exec("UPDATE table SET field='value'");
    echo $affected_rows.' were affected'

    // Running Statements With Parameters
    $stmt = $db->prepare("SELECT * FROM table WHERE id=? AND name=?");
    $stmt->execute(array($id, $name));
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    ... 
