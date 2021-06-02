---
title: mnesia:delect_object只删除索引问题
date: 2019-02-20 11:46:03
tags:
- erlang
- mnesia
- collect
categories:
- erlang
---

### 前言

最近遇到一个奇怪的问题，mnesia数据有时能查出来有时查不出来，细查发现是mnesia:delect_object删除时，只删除了索引，没有删除具体的数据

### 问题重现

1. 表结构:

```
    -record(gordon_test, {
        idr,    % {id, pid}
        id,
        pid,
        locale,
        time = os:timestamp()
    }).
```

1. 初使化代码:

```
    mnesia:create_table(gordon_test, [
        {ram_copies, [node() | nodes()]},
        {attributes, record_info(fields, gordon_test)}
    ]),
    mnesia:add_table_index(gordon_test, id),
    mnesia:add_table_index(gordon_test, pid).
```

2. 插入数据:

```
    mnesia:dirty_write(gordon_test, {gordon_test, {1, 1}, 1, 1, "", "", os:timestamp()}).
    mnesia:dirty_write(gordon_test, {gordon_test, {2, 2}, 2, 2, "", "", os:timestamp()}).
    mnesia:dirty_write(gordon_test, {gordon_test, {3, 3}, 3, 3, "", "", os:timestamp()}).
```

3.查询:

```
    Id = 3,
    Pid = 3,
    % 查出id=3的所有记录，都能查出一条记录
    mnesia:dirty_index_read(gordon_test, Id, #gordon_test.id),
    mnesia:dirty_index_match_object(#gordon_test{idr = '$1',id=Id, _='_'}, #gordon_test.id),
```

4. 执行删除:

```
    mnesia:dirty_delete_object(X#gordon_test{locale = aaaa}).
    or
    Trans = fun() ->
        mnesia:delete_object(X#gordon_test{locale = aaaa})
            end,
    mnesia:transaction(Trans)
```

5. 两次查询，dirty_index_read查不到数据:

```
    % 数据查询为空
    mnesia:dirty_index_read(gordon_test, Id, #gordon_test.id),
    % 数据不变
    mnesia:dirty_index_match_object(#gordon_test{idr = '$1',id=Id, _='_'}, #gordon_test.id),
```

### 问题定位

查文档:

```
    If a table is of type bag, it can sometimes be needed to delete only some of the records with a certain key. 
    This can be done with the function delete_object/3. A complete record must be supplied to this function.

    The semantics of this function is context-sensitive. For details, see mnesia:activity/4. 
    In transaction-context, it acquires a lock of type LockKind on the record. 
    Currently, the lock types write and sticky_write are supported.
```

### 深层研究

待继续 @todo




