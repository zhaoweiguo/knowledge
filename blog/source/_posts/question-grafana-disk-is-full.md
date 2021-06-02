---
title: 【常见问题】Grafana一个bug导致磁盘占用近500G
date: 2020-02-11 13:22:09
categories:
- question
tags:
- grafana
- question
---


# 简介
前段时间grafana监控出问题，定位发现磁盘满了。今天grafana监控又出问题了，是去一看磁盘又满了。肯定是某一个服务在不停的吃磁盘，才7天时间，就吃掉了近200G。

# 问题定位
### 定位到哪个文件在吃磁盘
通过df和du命令一点点定位找到真凶:/var/lib/grafana.db。此文件已经占用486G了。

### 定位是哪个表数据量大

我们grafana用的是sqlite存储配置相关信息，grafana.db文件就是sqlite的数据文件，登录sqlite:
```
$> sqlite3 /var/lib/grafana.db
sqlite> .table
alert                   dashboard_version       quota
alert_notification      data_source             session
annotation              login_attempt           star
annotation_tag          migration_log           tag
api_key                 org                     team
dashboard               org_user                team_member
dashboard_acl           playlist                temp_user
dashboard_provisioning  playlist_item           test_data
dashboard_snapshot      plugin_setting          user
dashboard_tag           preferences             user_auth
$> select count(*) from dashboard_version;
4462809
```

### 为啥这个表这么多数据

Google、百度各种关键词都查不到相关问题，没办法，只好去github上看Issues了。搜索grafana.db和dashboard_version找到原因。这是grafana的一个bug，5.2.2、5.3.0都有这个问题，我们的版本是5.1.4也有这个问题。这个问题在今年1月份由bergquist提供了解决方案。

##### 原因:
dashboards的来源中2个不同的文件夹下有一个相同的json文件

##### 原文:[from](https://github.com/grafana/grafana/issues/12864)
By mistake, I put twice the same JSON file in two different folders, which are used as a source of provisioned dashboards. And after some time I noticed, that MySQL databases were growing infinitely. After some quick check, I found, that the table "dashboard_version" was the biggest (with millions of "revisions" for "duplicated" dashboard).


##### bergquist提供的解决方案

在文件devenv/dashboards.yaml中增加一句:
```
// https://github.com/bergquist/grafana/commit/2ea46fa925013abbf92871c3aec17250250a9250
解决说明:
avoid infinite loop in the dashboard provisioner:
if one dashboard with an uid is refered to by two
provsioners each provsioner overwrite each other.
filling up dashboard_versions quite fast if using
default settings.
```

这个问题在新版本已经解决了，原因是dashboard的json配置文件中的uid有相同的，导致相互间覆盖。但我验证时，导出所有的dashboard的配置文件，没有发现有相同uid的配置，这个难道是我之前对各配置文件分组引起的？我删除了几个不常用的dashboard，把所有配置都合并到一个文件夹中，没办法证实了。

##### 本问题解决方案

但现在的问题是，已经有400多G数据，需要先解决这个问题再使用新版本。首先想到的是迁移到一个新的服务器上，但有个问题，配置文件的导出只能一个个导出dashboard，而且还不能导出类似数据源这类数据。本来这种配置数据迁移可以通过直接迁移数据库解决，但现在本来就是解决数据库太大的问题。


