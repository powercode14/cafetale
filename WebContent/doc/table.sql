drop table cafe;

create table cafe(
	cafe_id number(10),
	cafe_location varchar2(200),
	cafe_name varchar2(200),
	cafe_address varchar2(50),
	cafe_tel varchar2(30),
	cafe_time date default sysdate,
	region_id number(10),
	constraint cafe_cafe_id_pk primary key (cafe_id)
);
