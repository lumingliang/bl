


SELECT *,count(*) FROM `xz_resume_submit` group by status having status in (3,4) ORDER BY `status` ASC

select *,sum(p) from (SELECT status, count(status) as p FROM `xz_resume_invite` group by status) as a group by status


SELECT *,DATE_FORMAT(time,  "%Y-%m-%d %H") FROM `company_service` GROUP by DATE_FORMAT(time,  "%Y-%m-%d %H")

SELECT *,DATE_FORMAT(time,  "%u") as week FROM `company_service` WHERE date_format(time, '%Y')=2016 GROUP by DATE_FORMAT(time,  '%u')  ORDER by DATE_FORMAT(time,  '%u') DESC
