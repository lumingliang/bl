
# yii wiget html相关
-------

##### Modal, jq
<?= \yii\bootstrap\Modal::widget([
    'id' => 'contact-modal',
    'toggleButton' => [
        'label' => 'Обратная связь',
        'tag' => 'a',
        'data-target' => '#contact-modal',
        'href' => Url::toRoute(['/main/contact']),
    ],
    'clientOptions' => false,
]); ?>
 
$model = new ContactForm();
return $this->renderAjax('contact', [
  'model' => $model,
]);
 
$js = <<<JS
jQuery('#contact-form').on('beforeSubmit', function(){
    var form = jQuery(this);
    jQuery.post(
        form.attr("action"),
        form.serialize()
    )
    .done(function(result) {
        form.parent().replaceWith(result);
    })
    .fail(function() {
        console.log("server error");
    });
    return false;
})
JS;
$this->registerJs($js);

##### 表单异步验证

##### html助手

yii的设计模式是写更少的代码来实现对html基本元素，标签的配置到直接生成
如 Html('tab', ['attr' => 'value']) 
利用数组来实现一切的配置和生成
