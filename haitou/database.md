title: 海投数据库结构
-----

##### haitou7数据表
common_user_info 记录普通用户(学生)的信息
common_user_login 学生注册好的登陆信息
common_email_validation 注册和密码找回的邮箱验证
common_phone_validation 注册和密码找回的电话验证
common_user_point 里面有个resume_post_quota 简历投递配额，记录着学生投递简历剩余次数

common_company_tag 企业类型的一级分类
common_company_tag_sub_type 企业类型二级分类

company_ad 企业广告的图片、位置、展示情况、订单时间等, 与企业id : company_id 关联

company_ad_click 某个用户对某个企业广告id的点击数, ip 等

company_bill 企业id的订单信息，下单时间、金额、是否已经支付成功、是否已经支付成功等

company_company_user 企业注册时的账户信息，账号密码、等，与company_id关联

*gs_company_info* 企业的详细信息，公司名字、企业营业执照等，*company_id*都是关联这个id

gs_company_info_duplicate 对外开放接口的企业信息
gs_album 公司相册
company_invoice  企业开发票的信息、也是与company_id关联

company_posted 简历投递记录，哪个学生用户user_id 投到哪个企业id(position_id)
xz_resume_submit 新的简历投递

company_resume_submit 也是简历投递记录，投递的企业位置(id)、被查看时间、简历的状态(是否已经被录取，发送面试通知)等, 废弃

company_service 为企业提供一些服务类型、和招聘简章发表、下订单等挂钩
company_service_use 各个企业对服务使用/购买情况

company_venue_college 
company_venue_venue 宣讲会场馆场地信息，大学名字、位置
company_venue_view 某个企业对这些场地的查看情况

xjh_info 记录着某个企业发布自己要在哪举办宣讲会的信息


####### xz 校园招聘

company_posted 公司简历邀请，记录了邀请user_id , position_id time等信息
xz_resume_submit 简历投递动作时，此表记录了简历的投递信息、投递职位、投递状态、是否录用, 每次投递简历用它检查是否已经投递等, 供学生用户界面查询
company_reusme_sumit 与上表差不多，多了被企业查看的时间( 被废弃 )

*zw 职位信息*

zw_position 记录了一个职位发布的信息，与company_id 挂钩 (company_info.id)
common_work_category 工作类型表

三表联合
SELECT * FROM `company_xz` as a left join gs_company_info as b on a.company_id = b.id right join xz_company as c on c.id = a.xz_id

company_xz 是xz_company 与 gs_company_info 的中间表，但是这两个表并不是一一对应关系

####### zph 招聘会信息 

校园招聘xz 主要记录了所有爬虫和企业后台发布了的职位信息

###### zw_position  各个职位相关表

zw_position 所有职位
zw_position_from 职位来源，有position_id
zw_info_processed 应该是由运营处理的职位相关信息
zw_info_position_link 
zw_info_eamil_blacklist 

