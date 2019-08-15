###### 电子货币交易
安全，电子钱包内的余额关系到用户的财产，想方设法保证其不被修改，或保证其金额来源有依据。
交易流水，交易流水具有历史性，连续性，不能删除和修改或添加不然这笔交易就会出问题，也影响到以后对账等。
对账，保证交易是否完成或金额正确性。

```
CREATE TABLE IF NOT EXISTS `yii2_bonus` (
  `bonus_id` int(8) NOT NULL COMMENT '自增ID',
  `record_sn` char(20) NOT NULL COMMENT '交易流水sn，关联wallet_record表',
  `from_uid` int(8) NOT NULL COMMENT '红包发起者',
  `from_display` tinyint(2) NOT NULL DEFAULT '1' COMMENT '红包发起者是否显示红包 0不显示 1显示',
  `from_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '红包支付状态 0待支付 1已支付',
  `to_uid` int(8) NOT NULL COMMENT '红包拆开者',
  `to_display` tinyint(2) NOT NULL DEFAULT '1' COMMENT '红包拆开者是否显示红包 0不显示 1显示',
  `to_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '红包收取状态 0待收款 1成功',
  `money` decimal(8,2) NOT NULL COMMENT '红包金额',
  `aid` int(8) NOT NULL COMMENT '应用ID，见配置文件',
  `oid` int(8) NOT NULL COMMENT '应用主键',
  `create_time` int(10) NOT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='红包订单表';

CREATE TABLE IF NOT EXISTS `yii2_wallet` (
  `uid` int(10) NOT NULL COMMENT '用户UID',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `salt` char(32) NOT NULL COMMENT '32位密码随机干扰字符串',
  `pay_password` char(32) DEFAULT NULL COMMENT '支付密码',
  `name` varchar(60) DEFAULT NULL COMMENT '提现姓名，不可更改',
  `idcard` char(20) DEFAULT NULL COMMENT '身份证号',
  `tx_alipay` varchar(60) DEFAULT NULL COMMENT '提现支付宝账号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户钱包';

CREATE TABLE IF NOT EXISTS `yii2_wallet_log` (
  `log_id` int(10) unsigned NOT NULL COMMENT '自增ID',
  `record_sn` char(20) NOT NULL COMMENT '交易流水sn，关联wallet_record表',
  `uid` int(10) unsigned NOT NULL COMMENT '用户UID',
  `change_money` decimal(10,2) NOT NULL COMMENT '变动金额 增+ 减-',
  `money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '变动后的金额',
  `remark` char(100) DEFAULT NULL COMMENT '备注',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `display` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否显示 0不显示 1显示'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='钱包变动日志';

CREATE TABLE IF NOT EXISTS `yii2_wallet_record` (
  `record_id` int(10) unsigned NOT NULL COMMENT '自增ID',
  `record_sn` char(20) NOT NULL COMMENT '交易流水sn，ymdHis+2位随机数',
  `from_uid` int(10) unsigned NOT NULL COMMENT '支付方UID，0系统充值',
  `to_uid` int(10) unsigned NOT NULL COMMENT '接收方UID，0系统提现',
  `type` tinyint(2) NOT NULL DEFAULT '3' COMMENT '交易类型 1充值 2提现 3交易 ',
  `money` decimal(10,2) NOT NULL COMMENT '交易金额',
  `pay_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '支付方式 0待定 1支付宝 2微信 3银行卡 4余额',
  `remark` char(100) NOT NULL COMMENT '备注信息',
  `pay_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '支付状态 0待支付 -1失败 1成功',
  `pay_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '交易时间',
  `fetch_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '收款状态 0待收款 -1失败 1成功',
  `fetch_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收款时间',
  `check_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '对账状态 0未对账 1已对账',
  `check_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '对账时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='钱包交易记录表';

ALTER TABLE `imhg_bonus`
  ADD UNIQUE KEY `record_sn` (`record_sn`);

ALTER TABLE `imhg_wallet`
  ADD UNIQUE KEY `uid` (`uid`);

ALTER TABLE `imhg_wallet_log`
  ADD PRIMARY KEY (`log_id`),
  ADD UNIQUE KEY `record_sn` (`record_sn`);

ALTER TABLE `imhg_wallet_record`
  ADD PRIMARY KEY (`record_id`),
  ADD UNIQUE KEY `record_sn` (`record_sn`) USING HASH;

ALTER TABLE `imhg_wallet_log`
  MODIFY `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID';

ALTER TABLE `imhg_wallet_record`
  MODIFY `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID';
```

要点说明
当用户发起一个红包时，生成一个交易记录，存储在交易记录表`yii2_wallet_record`表中，其支付方式为0待定，生成`record_sn`交易流水号。
将交易流水号`record_sn`和红包信息保存在红包表`yii2_bonus`中，红包为未支付状态，弹出选择支付方式。这里aid和oid不用管，主要是定位用户在哪个应用发起的红包。
支付失败或放弃支付时钱包交易记录表不变，也没有后续操作，说明红包没发送成功。
选择第三方支付且成功支付时，回调时，用事务修改钱包交易记录表`yii2_wallet_record`的`pay_type`和`pay_status`、`pay_time`修改成对应的值,同时将红包表`yii2_bonus`的红包支付状态`from_status`改为已支付。同时红包接受者客户端弹出收到红包的提示。
红包接收者点击拆红包后，使用事务修改`yii2_wallet_record`表的`fetch_status`、`fetch_time`字段为已收款状态，同时将红包接收者资金增加情况记录到`yii2_wallet_log`表，`yii2_wallet`表增加对应的金额，并且将红包表`yii2_bonus`的`to_status`改为已收取状态。
选择使用余额支付时，支付成功后要将红包发起者的资金变动情况和最终金额记录到对应的表中。当然支付前要检查余额是否充足。
做定时程序，每天晚上将`yii2_wallet_record`表中成功交易的记录对账，成功后将其`check_status`、`check_time`改为对应值。第三方支付使用第三方的对账api对账，余额支付检查其是否在`yii2_wallet_log`表中。
做定时程序，每天晚上检查余额不为0或者有交易记录的uid，的`yii2_wallet_log`资金变动情况是否有异常，主要是加起来是否等于余额，资金变化的`record_sn`是否与`yii2_wallet_record`中的对应。
操作过程中的日子最好保存到另一台服务器上，以文本或者mongodb存储，方便查询。当然这个日志也可以做一套查询功能，为上一点提供核对功能。
探讨话题
还是安全性问题，如何有效保证交易记录和资金安全。服务器方面加强安全、https、资金/日志/程序各单独一台服务器、每条交易记录钱包变动记录加一个签名字段、钱包的金额加密。。。都探讨一下。
当交易量很大时，对账就会花很多时间，这些交易记录都不能删，怎么办。
特别是余额被修改，然后提现。。。
