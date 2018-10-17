# 文档查询导入数据格式文档

### 一、api传输格式
直达服务也要求第三方向微信后台写入数据，开发者可以通过[开放的api](https://mp.weixin.qq.com/wiki?action=doc&id=mp1421140183&t=0.2761844075184767)提前将第三方数据写入，微信会通过该数据提前知道第三方服务对数据的服务能力，微信会判断用户输入的query与第三方数据的匹配程度进行流量分配，单次api导入数据大小不超过5K。

> http请求方式：POST

> http(s)://api.weixin.qq.com/wxa/setdynamicdata?access_token=ACCESS_TOKEN

POST数据示例如下：


```json
{
    "lifespan": 86400,
    "query": "{\"type\":1011099}",
    "scene": 1,
    "data": "{\"items\": [{XXX},{XXX},{XXX}], \"attribute\": {\"count\": M, \"totalcount\": N, \"id\": \"XXX\", \"seq\": i}}"
}
```

### 二、数据格式

query字段中type定义为：

key|说明|定义
----|----|----
type|类型编号|1011099


data字段的定义：
字段名称    |字段类型   |说明
------------|-----------|---------------------
items  |array    |数据内容见items数组数据定义
attribute|object |{"id":"XXX", "seq": i, "count": M, "totalcount": N}. id为此批数据的唯一id，注意同一批数据可能分多次api推送，这多次推送的id必须是一致的；seq为多次推送的递增序列，为0到n-1，第一次推送seq为0，第二次推送seq为1，以此类推；count为此次api推送的数据条数；totalcount为此批数据的总条数，sum(count(0).size() + ... +count(n-1).size())，即所有api推送数据条数总和。

items数组中数据定义为：
key|说明|示例
----|---|----
name|关键词名称|例如：html

最终POST的数据内容为：
```json
{
    "data": "{\"items\": [{\"name\":\"html\"}], \"attribute\": {\"count\": 2, \"totalcount\": 100, \"id\": \"XXX\", \"seq\": 0}}",
    "lifespan": 86400,
    "query": "{\"type\":1011099}",
    "scene": 1
}
```
