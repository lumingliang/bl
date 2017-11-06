#### 代码总结
##### jl模块
将原来一个用户一份简历改为对多份
1. 利用hasMany() 对应多个，在resume model 的fields中加入关联hasMany(getSomeField)field，$models = findAll后，当调用yii的Json::encode($models)时会自动调用toArray方法，从而自动得到了和它关联的多个item，查询后findAll()取出
2. 对某个item编辑时，只需要传递id，简历id，根据action参数来觉得是修改还是删除，如果是新增，那就还需要在插入时加入简历id
3. 注意的在每次进行item编辑时，都要检查权限，如是否是用户本人操作
##### wxx
加入了hr审核和修改官方公司模块
1. 利用gii生成最原始的model，searchForm，controller
2. 对1中的进行修改，dataProvider和gridView的使用
3. 注意在yii中的model，定义好scenario，以及rules，才能利用load方法向model中导入get，post数据，如果发现某个数据导入失败，应检查这两者，严格定义好合适的规则
4. yii save失败原因是validat没有通过
##### company
用户的注册登录、发布简章、简历模块、群管理模块
1. 企业注册登陆逻辑的调整，逻辑关键地方可以看代码注释
2. 发布简章、刷新简章逻辑的调整
3. 简历搜索加入了对userinfo的搜索，当搜索条件小于等于2时，用resume表搜索，否则用userinfo搜索，主要是Query中，alias,like,joinWith,(alias.collum)的使用
4. 简历导出加入了导出pdf，获取前台的搜索条件，得到resume ids后，利用yii render取得html，并用\mPDF转为pdf，php \zipArchive的使用，以及异步执行exec，用户无需等待即可返回，等完成后，系统发送通知
5. 群管理模块主要是gii+gridView，其中导入excel邀请用户注册，是对\phpExcel使用，首先获取用户信息数组，随后进行一系列逻辑判断知道发送email、短信邀请用户注册
##### 图片处理类
1. imagine类，利用php imagine图片处理类库，从上往下扫描，以5px为步长根据设定容差判断图片像素是否是白点，遇到第一个不是白点后坐标缩小一个步长，步长变为1，继续寻找第一个不是白点，这个坐标即上边界
2. 以此类推，将图片顺时针旋转90，180,270度后，得到右，下，左边界坐标
3. 图片放入椭圆中，利用图片原来宽高比和焦半径公式算出缩放后的宽高
4. paste, resize, getColorAt等方法使用
##### 几个简单的helper类
1. Emailhelper 用于发送邮件，注册邮件发送、注册码验证
2. MessageHelper 用于发送消息，拉人入群等
3. FileUploadHelper 文件上传放入以年月日为级别的目录下，并返回下载链接
4. 可以看下代码注释
##### 其他
1. 批量拉人入群，批量制作群图标，发送公告等console操作。
