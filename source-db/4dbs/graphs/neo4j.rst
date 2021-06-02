neo4j [1]_
##########


Cypher图查询语言
================

* Cypher是Neo4j的图形查询语言，允许用户存储和检索图形数据库中的数据。

查询语句如下::

    MATCH 
      (person:Person)-[:KNOWS]-(friend:Person)-[:KNOWS]-
      (foaf:Person)
    WHERE 
      person.name = "Joe"
      AND NOT (person)-[:KNOWS]-(foaf)
    RETURN
      foaf







.. [1] https://github.com/neo4j/neo4j