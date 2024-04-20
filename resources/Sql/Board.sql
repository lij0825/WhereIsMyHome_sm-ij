use ssafyhome;


drop table if exists uattention;
drop table if exists board;
drop table if exists userinfo;

create table if not exists userinfo (
    id  varchar(20) primary key,
    pw  varchar(64) not null,
    name varchar(20) not null,
    address varchar(100) not null
);


create table uattention(
    ano int auto_increment not null primary key,
    id varchar(20) not null,
    aptCode bigint not null,
    foreign key(id) references userinfo(id),
    foreign key(aptCode) references housedeal(aptCode)
);




 CREATE TABLE board(
    board_no int PRIMARY KEY AUTO_INCREMENT,
    id VARCHAR(20) NOT NULL,
    subject VARCHAR(20) NOT NULL,
    content VARCHAR(20) NOT NULL,
    post_date  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id) REFERENCES userinfo(id)
);


-- show tables;
-- desc dongcode;
-- desc housedeal;
-- desc houseinfo;
-- desc uattention;
-- select * from uattention;
-- desc userinfo;
select * from userinfo;

insert into userinfo
 values("admin", "1234", "관리자", "서울특별시 종로구 내수동 71");
 

insert into userinfo
 values("ssafy", "1234", "김싸피", "서울특별시 종로구 내수동 71");
 

insert into board(id, subject, content)
values("ssafy", "안녕하세요 게시판입니다.", "아 물론 별 기능은 없어요");

insert into board(id, subject, content)
values("admin", "안녕하세용 관리자 ", "글 많이 써주세요 ^^^^^^");

 select * from board;

commit;