Mongo
############

前提
----------

安装Maven包::

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-mongodb</artifactId>
    </dependency>

配置::

    spring:
       data:
          mongodb:
             uri: mongodb://10.140.2.19:27017/octopus
             or
             uri: mongodb://user:pwd@ip1:port1,ip2:port2/database
             or
             #address: 10.140.2.19:27017
             #database: octopus
             #username:
             #password:

注解::

    @Autowired
    private MongoTemplate mongoTemplate;



基本查询方式
------------------

单条件查询::

    DBObject obj = new BasicDBObject();
    obj.put("userId", new BasicDBObject("$gte", 2)); // userId>=2的条件
    //obj.put("userId", 2); userId=2 的条件
    Query query = new BasicQuery(obj.toString()); 
    List<MongoDBTestVo> result = mongoTemplate.find(query, MongoDBTestVo.class, "mongodbtest");

多条件查询::

    BasicDBList basicDBList = new BasicDBList();
    basicDBList.add(new BasicDBObject("userId", 2L));
    basicDBList.add(new BasicDBObject("name","test2"));

    DBObject obj = new BasicDBObject();
    obj.put("$and", basicDBList);

    Query query = new BasicQuery(obj.toString());

    List<MongoDBTestVo> result = mongoTemplate.find(query, MongoDBTestVo.class, "mongodbtest");

查看指定列的数据::

    DBObject obj = new BasicDBObject();
    obj.put("userId", new BasicDBObject("$gte", 2));

    BasicDBObject fieldsObject = new BasicDBObject();
    fieldsObject.put("userId", 1);  //    1或者true表示返回字段
    fieldsObject.put("name", 1);    //    0或者false表示不返回该字段
    Query query = new BasicQuery(obj.toString(), fieldsObject.toString());

    List<Map> result = mongoTemplate.find(query, Map.class, "mongodbtest");


Bson查询方式
-----------------

Bson查询方式::

    Bson bson = Filters.and(Arrays.asList(
                    Filters.gte("createdTime", Calendar.getInstance().getTime()),
                    Filters.gte("apis.count", 1)));
    MongoCursor<Document> cursor = null;
    try {
        FindIterable<Document> findIterable = mongoTemplate.getCollection("mongodbtest").find(bson);
        cursor = findIterable.iterator();
        List<MongoDBTestVo> list = new ArrayList<>();
        while (cursor.hasNext()) {
              Document object = cursor.next();
              MongoDBTestVo entity = JSON.parseObject(object.toJson(), MongoDBTestVo.class);
              list.add(entity);
         }
         return list;
    } finally {
       if (cursor != null) {
           cursor.close();
       }
    }

 Bson返回指定列::

    Bson bson = Filters.and(Arrays.asList(
                    Filters.gte("createdTime", Calendar.getInstance().getTime()),
                    Filters.gte("apis.count", 1)));
    BasicDBObject fieldsObject = new BasicDBObject();
    fieldsObject.put("apis.count", 1);
    fieldsObject.put("_id", 0);
    MongoCursor<Document> cursor = null;
    try {
        FindIterable<Document> findIterable = mongoTemplate.getCollection("mongodbtest").find(bson).projection(Document.parse(fieldsObject.toString()));
        cursor = findIterable.iterator();
        List<MongoDBTestVo> list = new ArrayList<>();
        while (cursor.hasNext()) {
              Document object = cursor.next();
              MongoDBTestVo entity = JSON.parseObject(object.toJson(), MongoDBTestVo.class);
              list.add(entity);
         }
         return list;
    } finally {
       if (cursor != null) {
           cursor.close();
       }
    }

Bson 排序::

    Bson bson = Filters.and(Arrays.asList(
        Filters.gte("createdTime", Calendar.getInstance().getTime()),
        Filters.gte("apis.count", 1)));
    BasicDBObject fieldsObject = new BasicDBObject();
    fieldsObject.put("apis.count", 1);
    fieldsObject.put("_id", 0);

    BasicDBObject sort = new BasicDBObject();
    sort.put("createdTime", 1);
    MongoCursor<Document> cursor = null;
    try {
        FindIterable<Document> findIterable = mongoTemplate.getCollection("mongodbtest").find(bson).projection(Document.parse(fieldsObject.toString())).sort(sort);
        cursor = findIterable.iterator();
        List<MongoDBTestVo> list = new ArrayList<>();
        while (cursor.hasNext()) {
              Document object = cursor.next();
              MongoDBTestVo entity = JSON.parseObject(object.toJson(), MongoDBTestVo.class);
              list.add(entity);
         }
         return list;
    } finally {
       if (cursor != null) {
           cursor.close();
       }
    }


1.x版本的的::

    
    DBObject query = new BasicDBObject(); //setup the query criteria 设置查询条件
    query.put("method", method);
    query.put("ctime", (new BasicDBObject("$gte", bTime)).append("$lt", eTime));
 
    logger.debug("query: {}", query);
 
    DBObject fields = new BasicDBObject(); //only get the needed fields. 设置需要获取哪些域
    fields.put("_id", 0);
    fields.put("uId", 1);
    fields.put("ctime", 1);
 
    DBCursor dbCursor = mongoTemplate.getCollection("collectionName").find(query, fields);
 
    while (dbCursor.hasNext()){
      DBObject object = dbCursor.next();
      logger.debug("object: {}", object);
      //do something.
    }



