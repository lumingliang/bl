SELECT sum(profit_amount+extra_amount), to_char(to_timestamp(o.created_at), 'YYYY-MM') as years, "target_id", "u"."role", "s"."name", "s"."contacts", "s"."mobile_number", "s"."address" FROM "order_profit_allot" "o" LEFT JOIN "user" "u" ON "o"."target_id" = "u"."id" LEFT JOIN "order" ON "o"."order_id" = "order"."id" LEFT JOIN "store" "s" ON "order"."store_id" = "s"."id" WHERE (to_timestamp(o.created_at) between '1997-01-01' and '2018-01-31') AND ((u.role&1)!=0) GROUP BY "years", "target_id", "u"."role", "s"."name", "s"."contacts", "s"."mobile_number", "s"."address" ORDER BY "years" DESC;

select xx into tblName1 from tblName2
insert into tblName1 from tblName2 //tblName1(不存在)
insert into tblName1 select * from tblName2  // tblName1需存在

SELECT sum(profit_amount+extra_amount), to_number(to_char(to_timestamp(o.created_at), 'YYYY-MM'),'9999-99') as years, "target_id", role, "s"."name", "s"."mobile_number", "s"."address" FROM "order_profit_allot" "o" LEFT JOIN "user" "u" ON "o"."target_id" = "u"."id" LEFT JOIN "order" ON "o"."order_id" = "order"."id" LEFT JOIN "store" "s" ON "order"."store_id" = "s"."id" WHERE (to_timestamp(o.created_at) between '1997-01-01' and '2018-01-31') AND ((u.role&1)!=0) GROUP BY "years", "target_id", "u"."role", "s"."name", "s"."contacts", "s"."mobile_number", "s"."address" ORDER BY "years" DESC;

insert into month_settle(amount,years,target_id,role,bank_name,bank_key,account_name,account_number,account_type,name,contacts,moblie_number,address) 

insert into month_settle(amount,years,target_id,role,bank_name,bank_key,account_name,account_number,account_type,name,contacts,mobile_number,address) (SELECT sum(profit_amount+extra_amount), to_number(to_char(to_timestamp(o.created_at), 'YYYY-MM'),'9999-99') as years, "target_id", "u"."role", "b"."bank_name", "b"."bank_key", "b"."account_name", "b"."account_number", "b"."account_type", "s"."name", "s"."contacts", "s"."mobile_number", "s"."address" FROM "order_profit_allot" "o" LEFT JOIN "user" "u" ON "o"."target_id" = "u"."id" LEFT JOIN "user_bind_bank" "b" ON "o"."target_id" = "b"."user_id" LEFT JOIN "order" ON "o"."order_id" = "order"."id" LEFT JOIN "store" "s" ON "order"."store_id" = "s"."id" WHERE (to_timestamp(o.created_at) between '2017-06-01' and '2017-06-30') AND ((u.role&15)!=0) GROUP BY "years", "target_id", "u"."role", "b"."bank_name", "b"."bank_key", "b"."account_name", "b"."account_number", "b"."account_type", "s"."name", "s"."contacts", "s"."mobile_number", "s"."address" ORDER BY "years" DESC);

to_timestamp 转为时间戳，时间戳和unix时间不大一样timestamp 又和普通的字符串不大一样(timestamp可能是用字符串方式存的，和数字类型不一样)

select count(*) from car_brand where has_tire=1 and has_model=1;

update car_config_option_value set tire=true where value ~ '(\d+)\/(\d+)\s*.{1}(\d+)';
update car_model set has_tire=1 where id in (select model_id from car_config_option_value where tire=true);
update car_brand set has_model=0 where id not in (select brand_id from car_model);
update car_brand set has_tire=0 where id not in (select brand_id from car_model where has_tire=1);

select * from car_config_option_value where tire=true and value !~ '(\d+)\/(\d+)\sR{1}(\d+)';
update car_config_option_value set value='215/75 R15' where tire=true and value = '215/75R15';
update car_config_option_value set tire=false where tire=true and value !~ '(\d+)\/(\d+)\sR{1}(\d+)';
update car_model set has_tire=0;

20115 rows in set
cars0912=# update car_model set has_tire=0;
Command OK - 24343 rows affected


select distinct d.id,sum(s) over (partition by d.id) from (select a.id,count(c.value) over (partition by c.value) s from car_brand a left join car_model b on a.id= b.brand_id left join car_config_option_value c on b.id = c.model_id where c.tire=true and a.has_model=1 and b.has_tire=1 order by s desc) d order by sum desc;

window.resolveLocalFileSystemURL(path, function(dir) {
	dir.getFile(filename, {create:false}, function(fileEntry) {
              fileEntry.remove(function(){
                      console.log('yes');
                  // The file has been removed succesfully
              },function(error){
                      console.log('error');
                  // Error deleting the file
              },function(){
                      console.log('not exist');
                 // The file doesn't exist
              });
	});
});

window.resolveLocalFileSystemURL(myPath, function (dirEntry) {
     var directoryReader = dirEntry.createReader();
     directoryReader.readEntries(function (e) {
             console.log(e);

             }, function(ee) {
             console.log(ee);
             });
});
root.getDirectory("storage", {create: true, exclusive: false}, onDirectorySuccess, onDirectoryFail);

select tire_spec, count(tire_spec) from car_model_tire group by tire_spec order by count desc;


###### 正则去掉导入sql尾缀
(?<=.*)(, '\d+')(?=\);$)




###### 随机读取
```
2、稍微快一点的方式，用offset来实现：

SELECT myid FROM mytable ORDER BY RANDOM() LIMIT 1;
SELECT myid FROM mytable OFFSET floor(random()*N) LIMIT 1; ;w

4、借助另一列的索引实现：

create table randtest (id serial primary key, data int not null);
insert into randtest (data) select (random()*1000000)::int from generate_series(1,1000000); 
create index randtest_md5_id_idx on randtest (md5(id::text));
explain analyze
select * from randtest where md5(id::text)>md5(random()::text) order by md5(id::text) limit 1;

9.5版用 TABLESAMPLE:
SELECT * FROM my_table TABLESAMPLE SYSTEM(0.000001) LIMIT 1;

```
