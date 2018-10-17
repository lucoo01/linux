## 文档查询数据格式文档


### 一、类目type
| key | 说明 | define |
| --- | --- | --- |
| type | 类型编号 | 11099 |


### 搜索模式：文档查询 - 关键词 或 关键词 + 教程/学习/文档/手册/指南
| key | 类型 | 示例 |
| --- | --- | --- |
|name|string|html|


### 文档查询 - 关键词 或 关键词 + 教程/学习/文档/手册/指南 返回数据字段定义
小程序后台需要根据自己的服务场景，data里面的数据按照以下定义的数据字段进行返回：
| key | 类型 | 含义 | 说明 |
| --- | --- | --- | --- |
|err_code|integer|返回值|0代表正确，非0代表错误<br> 请按如下规范返回错误码并且前端显示提示语：<br> -1: 无结果 -2: 参数不对 -3: 系统错误|
|err_msg|string|提示信息|针对于返回码的描述信息|
|list|array|列表|结果列表，最多显示两条|
|list.jump_url|string|点击该结果的跳转路径|undefined|
|list.image|string|图片路径|图片路径|
|list.image@width|number|图片宽度|图片默认宽高比为64:64，若实际图片宽高比与默认宽高比相差较大，需传入此参数|
|list.image@height|number|图片高度|图片默认宽高比为64:64，若实际图片宽高比与默认宽高比相差较大，需传入此参数|
|list.name|string|名称|名称，如 CSS教程|
|list.description|string|描述|描述，如 CSS3是最新的CSS标准，我们的CSS3教程...|
|more_description|string|底部更多描述|底部更多描述，如 查看更多结果|
