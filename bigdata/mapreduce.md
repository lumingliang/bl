1. mapreduce 的思想就是把一个任务分成一个个小块，然后再统计、再分、分而治之的思想。k;w
2. 过程:map sort suffile reduce，map后得到一些列的key value形式，对其排序后，进行洗牌、统计，将其组装成key [value, value]形式，然后送到reducer之前，再对所有的洗牌后的map进行统计，得到了最终的key [value]形式，也就是reduce的输入值是一个数组
3. 先map sort suffile combine reduce 每一个节点输出都是一个key value[] 然后汇总节点对各个key继续进行combine，输出到各个节点继续reduce 

