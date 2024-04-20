CREATE TABLE `station` (
	`station_code`	INT	NOT NULL,
	`station_name`	VARCHAR(45)	NULL,
	`station_name_en`	VARCHAR(45)	NULL,
	`station_name_ja`	VARCHAR(45)	NULL,
	`station_name_ch`	VARCHAR(45)	NULL,
	`line`	VARCHAR(45)	NULL,
	`lng`	VARCHAR(45)	NULL,
	`lat`	VARCHAR(45)	NULL
);

CREATE TABLE `userinfo` (
	`id`	VARCHAR(20)	NOT NULL,
	`pw`	VARCHAR(64)	NOT NULL,
	`name`	VARCHAR(20)	NOT NULL,
	`address`	VARCHAR(100)	NOT NULL
);

CREATE TABLE `board` (
	`board_no`	INT	NOT NULL,
	`id`	VARCHAR(20)	NOT NULL,
	`aptCode`	BIGINT	NOT NULL,
	`subject`	VARCHAR(60)	NOT NULL,
	`content`	Text	NOT NULL,
	`post_date`	TIMESTAMP	NOT NULL,
	`INDEX`	`id`	NULL
);

CREATE TABLE `dongcode` (
	`dongCode`	VARCHAR(10)	NOT NULL,
	`sidoName`	VARCHAR(30)	NULL,
	`gugunName`	VARCHAR(30)	NULL,
	`dongName`	VARCHAR(30)	NULL
);

CREATE TABLE `houseinfo` (
	`aptCode`	BIGINT	NOT NULL,
	`buildYear`	INT	NULL,
	`roadName`	VARCHAR(40)	NULL,
	`roadNameBonbun`	VARCHAR(5)	NULL,
	`roadNameBubun`	VARCHAR(5)	NULL,
	`roadNameSeq`	VARCHAR(2)	NULL,
	`roadNameBasementCode`	VARCHAR(1)	NULL,
	`roadNameCode`	VARCHAR(7)	NULL,
	`dong`	VARCHAR(40)	NULL,
	`bonbun`	VARCHAR(4)	NULL,
	`bubun`	VARCHAR(4)	NULL,
	`sigunguCode`	VARCHAR(5)	NULL,
	`eubmyundongCode`	VARCHAR(5)	NULL,
	`dongCode`	VARCHAR(10)	NULL,
	`landCode`	VARCHAR(1)	NULL,
	`apartmentName`	VARCHAR(40)	NULL,
	`jibun`	VARCHAR(10)	NULL,
	`lng`	VARCHAR(30)	NULL,
	`lat`	VARCHAR(30)	NULL,
	`nearest_station`	INT	NULL,
	`INDEX`	`station_info_idx`	NULL
);

CREATE TABLE `housedeal` (
	`no`	BIGINT	NOT NULL,
	`dealAmount`	VARCHAR(20)	NULL,
	`dealYear`	INT	NULL,
	`dealMonth`	INT	NULL,
	`dealDay`	INT	NULL,
	`area`	VARCHAR(20)	NULL,
	`floor`	VARCHAR(4)	NULL,
	`cancelDealType`	VARCHAR(1)	NULL,
	`aptCode`	BIGINT	NULL,
	`INDEX`	`housedeal_aptCode_houseinfo_aptCode_fk_idx`	NULL
);

CREATE TABLE `uattention` (
	`ano`	INT	NOT NULL,
	`id`	VARCHAR(20)	NOT NULL,
	`aptCode`	BIGINT	NOT NULL,
	`INDEX`	`aptCode`	NULL
);

CREATE TABLE `attentionstation` (
	`id`	VARCHAR(20)	NOT NULL,
	`station_code`	INT	NOT NULL
);

CREATE TABLE `comments` (
	`comment_no`	INT	NOT NULL,
	`board_no`	INT	NOT NULL,
	`id2`	VARCHAR(20)	NOT NULL,
	`comment`	Text	NULL,
	`date`	TIMESTAMP	NULL
);

CREATE TABLE `news` (
	`news_no`	INT	NOT NULL,
	`subject`	TEXT	NULL,
	`url`	TEXT	NULL,
	`upload_date`	TimeStamp	NULL,
	`content`	VARCHAR(255)	NULL
);

ALTER TABLE `station` ADD CONSTRAINT `PK_STATION` PRIMARY KEY (
	`station_code`
);

ALTER TABLE `userinfo` ADD CONSTRAINT `PK_USERINFO` PRIMARY KEY (
	`id`
);

ALTER TABLE `board` ADD CONSTRAINT `PK_BOARD` PRIMARY KEY (
	`board_no`
);

ALTER TABLE `dongcode` ADD CONSTRAINT `PK_DONGCODE` PRIMARY KEY (
	`dongCode`
);

ALTER TABLE `houseinfo` ADD CONSTRAINT `PK_HOUSEINFO` PRIMARY KEY (
	`aptCode`
);

ALTER TABLE `housedeal` ADD CONSTRAINT `PK_HOUSEDEAL` PRIMARY KEY (
	`no`
);

ALTER TABLE `uattention` ADD CONSTRAINT `PK_UATTENTION` PRIMARY KEY (
	`ano`
);

ALTER TABLE `comments` ADD CONSTRAINT `PK_COMMENTS` PRIMARY KEY (
	`comment_no`
);

ALTER TABLE `news` ADD CONSTRAINT `PK_NEWS` PRIMARY KEY (
	`news_no`
);

