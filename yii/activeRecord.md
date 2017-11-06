##### yii2 activeRecord

-------
// 为整个表的一个列的数都减一
RobAdPacketRecord::updateAllCounters(['surplus_share_count' => -1], ['id' => 5]);
// 按条件更新整个表
ActiveRecord::updateAll()
