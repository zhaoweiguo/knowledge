----
title: Mongo优化——explain函数的基本使用
date: 2020-10-16 11:46:32
categories:
- db
tags:
- db
- mongodb
----

### 简介

当数据量不大时，查询语句随便写，只要实现逻辑功能即可；但当数据量大到一定程度时，可能以前的方法就不可行了，因为一是查询数度变慢，更有甚者可能因数据量大而导致查询失败。解决这种问题最简单的方法是添加索引并利用好这些索引。可以通过explain函数来分析：1、在建索引前数据请求情况2、创建索引后数据请求是否有变好。现在就来看看explain相关知识。

<!--more-->

### explain请求格式

#### 请求格式

格式:
```
> db.collection.find().explain(verbose)
```
参数verbose有以下3种值:
```
1. queryPlanner(默认)
    MongoDB运行查询优化器对当前的查询进行评估并选择一个最佳的查询计划
2. executionStats
    mongoDB运行查询优化器对当前的查询进行评估并选择一个最佳的查询计划进行执行
    在执行完毕后返回这个最佳执行计划执行完成时的相关统计信息
3. allPlansExecution
    即按照最佳的执行计划执行以及列出统计信息
    如果有多个查询计划，还会列出这些非最佳执行计划部分的统计信息
```


#### verbose==queryPlanner(默认)

> 说明: MongoDB运行查询优化器对当前的查询进行评估并选择一个最佳的查询计划

```
> db.my_collection.explain().find({"_id":"zhaoweiguo"})
[
    {
        queryPlanner: {
            winningPlan: {
                stage: "SINGLE_SHARD",
                shards: [
                    {
                        ...
                        winningPlan: {      // 这儿是选择的最佳查询计划
                            ...
                        },
                        rejectedPlans: [    // 这是其他的查询计划
                            {
                                ...
                            },
                            {
                                ...
                            }
                        ]
                    }
                ]
            }
        }
        ...
    }
]
```

#### verbose==executionStats

> mongoDB运行查询优化器对当前的查询进行评估并选择一个最佳的查询计划进行执行
在执行完毕后返回这个最佳执行计划执行完成时的相关统计信息

```
> db.my_collection.explain("executionStats").find({"_id":"zhaoweiguo"})
[
    {
        queryPlanner: {         // 同queryPlanner查询一样
            ...
        },
        executionStats: {         // 同queryPlanner查询不同之处: 具体执行并统计信息
            nReturned: 3,
            executionTimeMillis: 2,
            totalKeysExamined: 3,
            totalDocsExamined: 3,
            executionStages: {      // 返回最佳执行计划执行完成时的相关统计信息(与queryPlanner的不同点)
                ...
            },
        }
        ...
    }
]
```

#### verbose==allPlansExecution

> 即按照最佳的执行计划执行以及列出统计信息
如果有多个查询计划，还会列出这些非最佳执行计划部分的统计信息

```
> db.my_collection.explain("allPlansExecution").find({"_id":"zhaoweiguo"})
> 
[
    {
        queryPlanner: {         // 同queryPlanner查询一样
            ...
        },
        executionStats: {
            nReturned: 3,
            executionTimeMillis: 2,
            totalKeysExamined: 3,
            totalDocsExamined: 3,
            executionStages: {    // 同executionStats查询一样
                ...
            },
            allPlansExecution: [    // 同executionStats查询不同之处: rejectedPlans中的也统计信息
                {
                  ...     // rejectedPlans中第1条的统计信息
                },
                {
                  ...     // rejectedPlans中第2条的统计信息
                }
                ...
            ]
        }
        ...
    }
]
```

### 常见的stage说明

常见的执行步骤stage:
```
COLLSCAN 文档扫描(Collection Scan)即:未命中索引,全表扫描
IXSCAN 索引扫描
FETCH 根据索引去检索指定 document
SORT 内存排序(表明在内存中进行了排序)

COUNT 进行了 count 运算
COUNT_SCAN: count 使用了 Index 进行 count 时的 stage 返回
COUNTSCAN: count 不使用 Index 进行 count 时的 stage 返回

PROJECTION: 字段映射(限定返回字段时候 stage 的返回)

OR $or 查询子句全部命中索引时出现
LIMIT 结果集条数限制(使用 limit 限制返回数)
SKIP 从结果集中跳过部分条目(使用 skip 进行跳过)

IDHACK: 针对_id 进行查询

SINGLE_SHARD:   数据在一个shard中
SHARD_MERGE:    数据分布在多个shard中，合并各分片结果
SHARDING_FILTER: 通过 mongos 对分片数据进行查询

TEXT: 使用全文索引进行查询时候的 stage 返回

SUBPLA: 未使用到索引的 $or 查询的 stage 返回
```


### 其他executionStats说明

字段说明:
```
nReturned：执行返回的文档数
executionTimeMillis： 执行时间（ms）
totalKeysExamined：索引扫描条数
totalDocsExamined：文档扫描条数
executionStages：执行步骤
```


### 更多帮助

获取 explain 的支持的运算方法:
```
> db.my_collection.explain().help()
[
    [
        Explainable operations,
        .aggregate(...) - explain an aggregation operation,
        .count(...) - explain a count operation,
        .distinct(...) - explain a distinct operation,
        .find(...) - get an explainable query,
        .findAndModify(...) - explain a findAndModify operation,
        .remove(...) - explain a remove operation,
        .update(...) - explain an update operation,
        Explainable collection methods,
        .getCollection(),
        .getVerbosity(),
        .setVerbosity(verbosity)
    ]
]
```
获取 explain().find() 支持的运算方法:
```
> db.collection.explain().find().help()
[
    [
        Explain query modifiers,
        .addOption(n),
        .batchSize(n),
        .comment(comment),
        .collation(collationSpec),
        .count(),
        .hint(hintSpec),
        .limit(n),
        .maxTimeMS(n),
        .max(idxDoc),
        .min(idxDoc),
        .readPref(mode, tagSet),
        .showDiskLoc(),
        .skip(n),
        .sort(sortSpec)
    ]
]
```


### 完整实例说明

```
[
    {
        queryPlanner: {
            mongosPlannerVersion: 1,
            winningPlan: {
                stage: "SINGLE_SHARD",
                shards: [
                    {   // 如果是分片表，这儿会展示多个shard
                        shardName: "d-2ze07ec75d921fa4",
                        namespace: "mydb.my_collection",
                        parsedQuery: {    
                            $and: [
                                {
                                    is_delete: {
                                        $eq: "0"
                                    }
                                },
                                {
                                    is_read: {
                                        $eq: "0"
                                    }
                                },
                                {
                                    source_id: {
                                        $eq: "xxxxxxxx91138f6c5138e52fd749xxxxxxx"
                                    }
                                },
                                {
                                    user_id: {
                                        $eq: "xxxxxxx874aa1a0343448xxxxxx"
                                    }
                                }
                            ]
                        },
                        winningPlan: {      // 对查询评估并选择一个最佳的查询计划
                            stage: "LIMIT",
                            limitAmount: 3,
                            inputStage: {
                                stage: "FETCH",
                                inputStage: {
                                    stage: "IXSCAN",
                                    indexName: "is_delete_1_user_id_1_time_created_-1",
                                    ...
                                }
                            }
                        },
                        rejectedPlans: [    // 其他非最佳的查询计划
                            {
                                stage: "SORT",
                                sortPattern: {
                                    time_created: -1
                                },
                                limitAmount: 3,
                                inputStage: {
                                    stage: "SORT_KEY_GENERATOR",
                                    inputStage: {
                                        stage: "FETCH",
                                        inputStage: {
                                            stage: "IXSCAN",
                                            indexName: "source_id_1_user_id_1_is_read_1_is_delete_1",
                                            ...
                                        }
                                    }
                                }
                            },
                            {
                                stage: "SORT",
                                sortPattern: {
                                    time_created: -1
                                },
                                limitAmount: 3,
                                inputStage: {
                                    stage: "SORT_KEY_GENERATOR",
                                    inputStage: {
                                        stage: "FETCH",
                                        inputStage: {
                                            stage: "IXSCAN",
                                            indexName: "source_id_1",
                                        }
                                    }
                                }
                            }
                        ]
                    }
                ]
            }
        },
        executionStats: {           // 运行相关统计信息
            nReturned: 3,               // 返回数据条数: 3条
            executionTimeMillis: 2,     // 执行时间: 3ms
            totalKeysExamined: 3,       // 索引扫描条数: 3条
            totalDocsExamined: 3,       // 文档扫描条数: 3条
            executionStages: {      // 最佳执行计划执行完成时的相关统计信息(即上一级最终的数据)
                stage: "SINGLE_SHARD",
                nReturned: 3,
                executionTimeMillis: 2,
                totalKeysExamined: 3,
                totalDocsExamined: 3,
                totalChildMillis: NumberLong(1),
                shards: [
                    {   // 如果是分片表，这儿会展示多个shard
                        shardName: "d-2ze07ec75d921fa4",    // 使用了哪个shard
                        executionSuccess: true,
                        executionStages: {
                            stage: "LIMIT",
                            nReturned: 3,
                            executionTimeMillisEstimate: 0,
                            limitAmount: 3,
                            inputStage: {
                                stage: "FETCH",
                                nReturned: 3,
                                executionTimeMillisEstimate: 0,
                                inputStage: {
                                    stage: "IXSCAN",
                                    nReturned: 3,
                                    executionTimeMillisEstimate: 0,
                                    indexName: "is_delete_1_user_id_1_time_created_-1",
                                    ...
                                }
                            }
                        }
                    }
                ]
            },
            allPlansExecution: [      // 非最佳执行计划执行的相关统计信息
                {
                    shardName: "d-2ze07ec75d921fa4",
                    allPlans: [
                        {             // 执行计划1
                            nReturned: 3,
                            executionTimeMillisEstimate: 0,
                            totalKeysExamined: 3,
                            totalDocsExamined: 3,
                            executionStages: {
                                stage: "LIMIT",
                                nReturned: 3,
                                executionTimeMillisEstimate: 0,
                                limitAmount: 3,
                                inputStage: {
                                    stage: "FETCH",
                                    nReturned: 3,
                                    executionTimeMillisEstimate: 0,
                                    inputStage: {
                                        stage: "IXSCAN",
                                        nReturned: 3,
                                        executionTimeMillisEstimate: 0,
                                        indexName: "is_delete_1_user_id_1_time_created_-1",
                                        ...
                                    }
                                }
                            }
                        },
                        {             // 执行计划2
                            nReturned: 0,
                            executionTimeMillisEstimate: 0,
                            totalKeysExamined: 2,
                            totalDocsExamined: 2,
                            executionStages: {
                                stage: "SORT",
                                nReturned: 0,
                                executionTimeMillisEstimate: 0,
                                sortPattern: {
                                    time_created: -1
                                },
                                memUsage: 985,
                                memLimit: 33554432,
                                limitAmount: 3,
                                inputStage: {
                                    stage: "SORT_KEY_GENERATOR",
                                    nReturned: 2,
                                    executionTimeMillisEstimate: 0,
                                    inputStage: {
                                        stage: "FETCH",
                                        nReturned: 2,
                                        executionTimeMillisEstimate: 0,
                                        inputStage: {
                                            stage: "IXSCAN",
                                            nReturned: 2,
                                            executionTimeMillisEstimate: 0,
                                            indexName: "source_id_1_user_id_1_is_read_1_is_delete_1",
                                        }
                                    }
                                }
                            }
                        },
                        {             // 执行计划3
                            nReturned: 0,
                            executionTimeMillisEstimate: 0,
                            totalKeysExamined: 2,
                            totalDocsExamined: 2,
                            executionStages: {
                                stage: "SORT",
                                nReturned: 0,
                                executionTimeMillisEstimate: 0,
                                sortPattern: {
                                    time_created: -1
                                },
                                memUsage: 985,
                                memLimit: 33554432,
                                limitAmount: 3,
                                inputStage: {
                                    stage: "SORT_KEY_GENERATOR",
                                    nReturned: 2,
                                    executionTimeMillisEstimate: 0,
                                    inputStage: {
                                        stage: "FETCH",
                                        nReturned: 2,
                                        executionTimeMillisEstimate: 0,
                                        inputStage: {
                                            stage: "IXSCAN",
                                            nReturned: 2,
                                            executionTimeMillisEstimate: 0,
                                            indexName: "source_id_1",
                                        }
                                    }
                                }
                            }
                        }
                    ]
                }
            ]
        },
        ok: 1.0,
        operationTime: Timestamp(1603252218,345),
        $clusterTime: {
            clusterTime: Timestamp(1603252218,365),
            signature: {
                hash: BinData(0,"My+HyRMvT0NEYLU+VLaYeGVu7eQ="),
                keyId: NumberLong(6836642960822501517)
            }
        }
    }
]
```



### 参考

* 官网介绍executionstats: https://docs.mongodb.com/manual/reference/explain-results/#executionstats
* MongoDB 执行计划获取: https://blog.csdn.net/leshami/article/details/53521990

