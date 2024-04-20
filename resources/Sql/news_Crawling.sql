use ssafyhome;

CREATE TABLE `news` (
	`news_no`	INT	auto_increment Primary Key,
	`subject`	TEXT	NULL,
	`url`	TEXT NULL,
	`upload_date`	TimeStamp,
	`content`	VARCHAR(255)	NULL
);


select * from news;

