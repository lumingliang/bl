#### postgres 的各种插件
postgis 空间存储系统
1. ubuntu 安装
```
sudo apt-get install -y postgis postgresql-9.3-postgis-2.1
sudo -u postgres psql -c "CREATE EXTENSION postgis; CREATE EXTENSION postgis_topology;" DATABASE_NAME_HERE
```
入门教程https://live.osgeo.org/zh/quickstart/postgis_quickstart.html
常用函数https://my.oschina.net/weiwubunengxiao/blog/100576

window 安装用postgis bundle 

2. 地理坐标系(GCs)：将地球抽象为椭球，得到经纬度

投影坐标系：将地球投影到平面（地图）上，得到以米、千米为单位的坐标


wgs84 epsg:4326 就是常用的坐标系统，也是下面用的，就是地理坐标系
计算结果以米为单位
```
create extension postgis;
create table test.cities (id int4, name varchar(20));
alter table store add column coordinate geography(POINT, 4326);

create table test.cities (id int4, name varchar(20), geography(POINT, 4326));
select AddGeometryColumn('cities', 'shape', 4326, 'POINT', 2);
INSERT INTO test.cities ( shape, name )
VALUES ( GeomFromText('LINESTRING(0 0,0 0)', 4326), '北京');

INSERT INTO cities (id, the_geom, name) VALUES (1,ST_GeomFromText('POINT(-0.1257 51.508)',4326),'London, England');

创建索引
CREATE INDEX shape_index_cities
ON sde.cities
USING gist
(shape);
shape字段存的是一个16进制格式，返回可阅读
 SELECT id, ST_AsText(the_geom), ST_AsEwkt(the_geom), ST_X(the_geom), ST_Y(the_geom) FROM cities;

距离查询，米为单位
SELECT p1.name,p2.name,ST_Distance_Sphere(p1.the_geom,p2.the_geom) FROM cities AS p1, cities AS p2 WHERE p1.id > p2.id;
 SELECT name,ST_Distance_Sphere(the_geom,ST_GeomFromText('POINT(-0.1257 51.508)',4326)) FROM cities;
```
select AddGeometryColumn('store', 'coordinate', 4326, 'POINT', 2);
CREATE INDEX  ON "public"."store" USING GiST (coordinate);




注意：在数据清理时要保留spatial_ref_sys表
