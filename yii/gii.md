##### gii 生成器原理
1. 利用模板来生成代码
2. 内部重新定义了一下路由
3. 集成了typeahead，重写了一个actviefield，用在表单中，在af内部决定css、js的生成。
4. 采用yii.gii=function(){
    return {};
}
形式来扩展jq对象
