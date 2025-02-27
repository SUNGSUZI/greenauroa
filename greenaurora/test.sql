CREATE TABLE `member` (
	`member_id`	varchar(100)	NOT NULL,
	`member_pass`	int	NOT NULL,
	`member_name`	varchar(30)	NOT NULL,
	`member_phone`	int	NOT NULL,
	`member_number`	int	NOT NULL,
	`member_email`	varchar(100)	NOT NULL,
	`member_address`	varchar(100)	NULL,
	`member_create_date`	date	NULL,
	`member_wirhdraw_date`	date	NULL,
	`role`	varchar(30)	NULL	COMMENT '사용자 :ROLE_USER
관리자:ROLE_ADMIN',
	`member_state`	char(5)	NULL	COMMENT '정상 : A
탈퇴: D
휴먼:B'
);

CREATE TABLE `reservation` (
	`rev_key`	varchar(100)	NOT NULL,
	`member_id`	varchar(30)	NOT NULL,
	`station_number`	varchar(30)	NOT NULL,
	`op_type`	varchar(30)	NULL	COMMENT 'LCD:LCD
QR:QR',
	`rev_station`	char(3)	NOT NULL	DEFAULT 예약중	COMMENT '예약중:R
예약취소:D',
	`rev_start_time`	datetime	NOT NULL,
	`rev_end_time`	datetime	NOT NULL,
	`bicycle_number`	varchar(30)	NULL	COMMENT '에약자전거번호'
);

CREATE TABLE `station_info` (
	`station_number`	varchar(100)	NOT NULL,
	`station_name`	varchar(255)	NOT NULL,
	`station_lat`	DOUBLE REAL	NOT NULL,
	`station_log`	DOUBLE REAL	NOT NULL,
	`station_create_date`	date	NULL,
	`state`	char(3)	NULL	COMMENT '활성:A
비활성:D'
);

CREATE TABLE `board_group` (
    `board_group_key` varchar(100) NOT NULL,
    `type` varchar(30) NOT NULL COMMENT '공지사항:N,
문의하기:I,',
    `create_dt` datetime NOT NULL,
    `state` char(3) NOT NULL DEFAULT 'A' COMMENT  '활성:A
비활성:D'
);

CREATE TABLE `board` (
	`board_key`	varchar(100)	NOT NULL,
	`member_id`	varchar(100)	NOT NULL	COMMENT '작성자',
	`board_group_key`	varchar(100)	NOT NULL,
	`attach_group_key`	varchar(100)	NULL,
	`title`	text	NOT NULL,
	`sub`	varchar(100)	NULL,
	`contents`	text	NULL,
	`create_dt`	datetime	NOT NULL,
	`delete_dt`	datetime	NOT NULL
);

CREATE TABLE `station_group_bicycle` (
	`bicycle_number`	varchar(30)	NOT NULL,
	`station_number`	varchar(100)	NOT NULL,
	`bicycle_type`	varchar(100)	NULL	COMMENT '일반따릉이:G
새싹따릉이:S',
	`op_type`	char(5)	NULL	COMMENT 'LCD:LCD
QR:QR',
	`create_dt`	date	NOT NULL,
	`delete_dt`	date	NOT NULL,
	`state`	char(3)	NULL	COMMENT '예약 :R
대여:L
사용가능:A'
);

CREATE TABLE `rental` (
	`rental_key`	varchar(100)	NOT NULL,
	`member_id`	varchar(100)	NOT NULL,
	`bicycle_number`	varchar(30)	NOT NULL,
	`station_number`	varchar(100)	NOT NULL	COMMENT '대여한 대여소 정보',
	`rental_date`	datetime	NOT NULL,
	`return_date`	datetime	NULL,
	`return_state`	char(3)	NOT NULL	DEFAULT NR	COMMENT '미반납:NR
반납:R',
	`return_station_number`	varchar(30)	NULL	COMMENT '대여소정보 table의 대여소 번호 저장',
	`create_dt`	date	NOT NULL
);

CREATE TABLE `purchase` (
	`purchase_key`	varchar(100)	NOT NULL,
	`member_id`	varchar(100)	NOT NULL,
	`rental_key`	varchar(100)	NULL,
	`point_key`	varchar(100)	NULL,
	`purchase_division`	char(5)	NOT NULL	COMMENT '과금: B
일일1시간권 사용: 1H
일일 2시간권사용: 2H
일일1시간권구매: 1HP
일일2시간권구매:2HP',
	`amount`	int	NULL	COMMENT '과금발생시
이용권구매시',
	`pay_type`	char(5)	NULL	COMMENT '신용카드:C
휴대전화:P
페이코:PAY
카카오페이:K
제로페이:Z',
	`pay_date`	datetime	NOT NULL
);

CREATE TABLE `notification` (
	`member_id`	varchar(100)	NOT NULL	COMMENT '받는사람',
	`content`	text	NULL,
	`state`	char(3)	NOT NULL	DEFAULT NR	COMMENT '읽음:R
안읽음:NR',
	`title`	varchar(50)	NULL,
	`sender`	varchar(50)	NULL,
	`create_dt`	datetime	NULL
);

CREATE TABLE `point` (
	`point_key`	varchar(100)	NOT NULL,
	`rental_key`	varchar(100)	NOT NULL,
	`member_id`	varchar(100)	NOT NULL,
	`plus_point`	int	NULL,
	`create_dt`	datetime	NULL
);

CREATE TABLE `coupon` (
	`coupon_key`	varchar(100)	NOT NULL,
	`title`	varchar(100)	NOT NULL	COMMENT '1hour 
2hour',
	`amount`	int	NOT NULL,
	`create_dt`	date	NOT NULL,
	`state`	char(3)	NOT NULL	DEFAULT A	COMMENT '활성:A
비활성:D',
	`type`	char(5)	NOT NULL	COMMENT '일일 1hour :1HP
일일 2hour : 2HP'
);

CREATE TABLE `used_point` (
	`useed_point_key`	varchar(100)	NOT NULL,
	`member_id`	varchar(100)	NOT NULL,
	`point_use_date`	datetime	NOT NULL,
	`point_decrease`	int	NOT NULL
);

CREATE TABLE `reservation_cancel` (
	`rev_cancel_key`	varchar(100)	NOT NULL,
	`rev_key`	varchar(100)	NOT NULL,
	`reason_type`	varchar(100)	NOT NULL,
	`cancel_state`	char(3)	NULL	DEFAULT W	COMMENT '승인:A
대기:W',
	`reason_content`	text	NULL,
	`approval_dt`	datetime	NULL,
	`create_dt`	datetime	NOT NULL
);

CREATE TABLE `bookmark` (
	`member_id`	varchar(100)	NOT NULL,
	`station_number`	varchar(100)	NOT NULL
);

CREATE TABLE `attach_group` (
	`attach_group_key`	varchar(100)	NOT NULL
);

CREATE TABLE `attach_file` (
	`attach_file_id`	varchar(100)	NOT NULL,
	`attach_group_key`	varchar(100)	NOT NULL,
	`delete_dt`	date	NULL,
	`create_dt`	date	NOT NULL
);

CREATE TABLE `event` (
	`event_key`	varchar(100)	NOT NULL,
	`station_number`	varchar(100)	NOT NULL,
	`attach_group_key`	varchar(100)	NULL,
	`plus_point`	int	NULL,
	`event_name`	text	NOT NULL,
	`event_content`	text	NOT NULL,
	`start_dt`	datetime	NULL,
	`end_dt`	datetime	NULL,
	`create_dt`	datetime	NOT NULL,
	`state`	char(2)	NOT NULL	DEFAULT A	COMMENT '활성:A
비활성:D'
);

ALTER TABLE `member` ADD CONSTRAINT `PK_MEMBER` PRIMARY KEY (
	`member_id`
);

ALTER TABLE `reservation` ADD CONSTRAINT `PK_RESERVATION` PRIMARY KEY (
	`rev_key`
);

ALTER TABLE `station_info` ADD CONSTRAINT `PK_STATION_INFO` PRIMARY KEY (
	`station_number`
);

ALTER TABLE `board_group` ADD CONSTRAINT `PK_BOARD_GROUP` PRIMARY KEY (
	`board_group_key`
);

ALTER TABLE `board` ADD CONSTRAINT `PK_BOARD` PRIMARY KEY (
	`board_key`
);

ALTER TABLE `station_group_bicycle` ADD CONSTRAINT `PK_STATION_GROUP_BICYCLE` PRIMARY KEY (
	`bicycle_number`,
	`station_number`
);

ALTER TABLE `rental` ADD CONSTRAINT `PK_RENTAL` PRIMARY KEY (
	`rental_key`
);

ALTER TABLE `purchase` ADD CONSTRAINT `PK_PURCHASE` PRIMARY KEY (
	`purchase_key`
);

ALTER TABLE `notification` ADD CONSTRAINT `PK_NOTIFICATION` PRIMARY KEY (
	`member_id`
);

ALTER TABLE `point` ADD CONSTRAINT `PK_POINT` PRIMARY KEY (
	`point_key`,
	`rental_key`
);

ALTER TABLE `coupon` ADD CONSTRAINT `PK_COUPON` PRIMARY KEY (
	`coupon_key`
);

ALTER TABLE `used_point` ADD CONSTRAINT `PK_USED_POINT` PRIMARY KEY (
	`useed_point_key`
);

ALTER TABLE `reservation_cancel` ADD CONSTRAINT `PK_RESERVATION_CANCEL` PRIMARY KEY (
	`rev_cancel_key`
);

ALTER TABLE `bookmark` ADD CONSTRAINT `PK_BOOKMARK` PRIMARY KEY (
	`member_id`,
	`station_number`
);

ALTER TABLE `attach_group` ADD CONSTRAINT `PK_ATTACH_GROUP` PRIMARY KEY (
	`attach_group_key`
);

ALTER TABLE `attach_file` ADD CONSTRAINT `PK_ATTACH_FILE` PRIMARY KEY (
	`attach_file_id`
);

ALTER TABLE `event` ADD CONSTRAINT `PK_EVENT` PRIMARY KEY (
	`event_key`
);

ALTER TABLE `station_group_bicycle` ADD CONSTRAINT `FK_station_info_TO_station_group_bicycle_1` FOREIGN KEY (
	`station_number`
)
REFERENCES `station_info` (
	`station_number`
);

ALTER TABLE `notification` ADD CONSTRAINT `FK_member_TO_notification_1` FOREIGN KEY (
	`member_id`
)
REFERENCES `member` (
	`member_id`
);

ALTER TABLE `point` ADD CONSTRAINT `FK_rental_TO_point_1` FOREIGN KEY (
	`rental_key`
)
REFERENCES `rental` (
	`rental_key`
);

ALTER TABLE `bookmark` ADD CONSTRAINT `FK_member_TO_bookmark_1` FOREIGN KEY (
	`member_id`
)
REFERENCES `member` (
	`member_id`
);

ALTER TABLE `bookmark` ADD CONSTRAINT `FK_station_info_TO_bookmark_1` FOREIGN KEY (
	`station_number`
)
REFERENCES `station_info` (
	`station_number`
);

ALTER TABLE bookmark DROP FOREIGN KEY FK_member_TO_bookmark_1;
DROP TABLE IF EXISTS member;
CREATE TABLE `member` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `member_id` varchar(100) NOT NULL UNIQUE,
    `member_pass` int NOT NULL,
    `member_name` varchar(30) NOT NULL,
    `member_phone` int NOT NULL,
    `member_number` int NOT NULL,
    `member_email` varchar(100) NOT NULL,
    `member_address` varchar(100) NULL,
    `member_create_date` date NULL,
    `member_withdraw_date` date NULL,
    `member_state` char(5) NULL COMMENT '정상 : A 탈퇴: D 휴먼:B',
    `role` varchar(30) NULL COMMENT '사용자 :ROLE_USER 관리자:ROLE_ADMIN',
    PRIMARY KEY (`id`)
);
ALTER TABLE bookmark 
ADD CONSTRAINT FK_member_TO_bookmark_1 
FOREIGN KEY (member_id) 
REFERENCES member(member_id);


CREATE SEQUENCE my_table_seq START WITH 1 INCREMENT BY 1;

DROP TABLE IF EXISTS `station_info`;

CREATE TABLE `station_info` (
   `station_number`   varchar(100)   NOT NULL,
   `station_name`   varchar(255)   NOT NULL,
   `station_lat`   DOUBLE   NOT NULL,
   `station_log`   DOUBLE   NOT NULL,
   `station_create_date`   date,
   `state`   char(3)   ,
   `address`   varchar(255)   NULL
);




DROP TABLE IF EXISTS `rental`;

CREATE TABLE `rental` (
   `rental_key`   varchar(100)   NOT NULL,
   `member_id`   varchar(100)   NOT NULL,
   `bicycle_number`   varchar(30)   NOT NULL,
   `station_number`   varchar(100)   NOT NULL   ,
   `rental_date`   datetime   NOT NULL,
   `return_date`   datetime   NULL,
   `return_state`   char(3)   NOT NULL   DEFAULT 'NR',
   `return_station_number`   varchar(30)   NULL   ,
   `create_dt`   date   NOT NULL
);



DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
   `member_id`   varchar(100)   NOT NULL,
   `content`   text   NULL,
   `state`   char(3)   NOT NULL   DEFAULT 'NR',
   `title`   varchar(50)   NULL,
   `sender`   varchar(50)   NULL,
   `create_dt`   datetime   NULL
);



DROP TABLE IF EXISTS `reservation_cancel`;

CREATE TABLE `reservation_cancel` (
   `rev_cancel_key`   varchar(100)   NOT NULL,
   `rev_key`   varchar(100)   NOT NULL,
   `reason_type`   varchar(100)   NOT NULL,
   `cancel_state`   char(3)   NULL   DEFAULT 'W'   ,
   `reason_content`   text   NULL,
   `approval_dt`   datetime   NULL,
   `create_dt`   datetime   NOT NULL
);





DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
   `event_key`   varchar(100)   NOT NULL,
   `station_number`   varchar(100)   NOT NULL,
   `attach_group_key`   varchar(100)   NULL,
   `plus_point`   int   NULL,
   `event_name`   text   NOT NULL,
   `event_content`   text   NOT NULL,
   `start_dt`   datetime   NULL,
   `end_dt`   datetime   NULL,
   `create_dt`   datetime   NOT NULL,
   `state`   char(2)   NOT NULL   DEFAULT 'A'
);

CREATE TABLE `coupon` (
   `coupon_key`   varchar(100)   NOT NULL,
   `title`   varchar(100)   NOT NULL,
   `amount`   int   NOT NULL,
   `create_dt`   date   NOT NULL,
   `state`   char(3)   NOT NULL   DEFAULT 'A'   COMMENT '활성:A
비활성:D',
   `type`   char(5)   NOT NULL   COMMENT '일일 1hour :1HP
일일 2hour : 2HP'
);




SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'greenaoura';
CREATE TABLE `board_group` (
   `board_group_key`   varchar(100)   NOT NULL,
   `type`   varchar(30)   NOT NULL ,
   `create_dt`   varchar(100)   NOT NULL,
   `state`   char(3)   NOT NULL   DEFAULT 'A'   
)






CREATE TABLE `reservation` (
   `rev_key`   varchar(100)   NOT NULL,
   `member_id`   varchar(30)   NOT NULL,
   `station_number`   varchar(30)   NOT NULL,
   `op_type`   varchar(30),
   `rev_station`   char(3)   NOT NULL   DEFAULT '예약중',
   `rev_start_time`   datetime   NOT NULL,
   `rev_end_time`   datetime   NOT NULL,
   `bicycle_number`   varchar(30)
)


ALTER TABLE `station_info` ADD CONSTRAINT `PK_STATION_INFO` PRIMARY KEY (
   `station_number`
);





ALTER TABLE `rental` ADD CONSTRAINT `PK_RENTAL` PRIMARY KEY (
   `rental_key`
);


ALTER TABLE `notification` ADD CONSTRAINT `PK_NOTIFICATION` PRIMARY KEY (
   `member_id`
);



ALTER TABLE `coupon` ADD CONSTRAINT `PK_COUPON` PRIMARY KEY (
   `coupon_key`
);





ALTER TABLE `event` ADD CONSTRAINT `PK_EVENT` PRIMARY KEY (
   `event_key`
);



ALTER TABLE `notification` ADD CONSTRAINT `FK_member_TO_notification_1` FOREIGN KEY (
   `member_id`
)
REFERENCES `member` (
   `member_id`
);

ALTER TABLE `point` ADD CONSTRAINT `FK_rental_TO_point_1` FOREIGN KEY (
   `rental_key`
)
REFERENCES `rental` (
   `rental_key`
);



ALTER TABLE `bookmark` ADD CONSTRAINT `FK_station_info_TO_bookmark_1` FOREIGN KEY (
   `station_number`
)
REFERENCES `station_info` (
   `station_number`
);


SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'greenaurora';


SELECT * from member;

ALTER TABLE bookmark DROP FOREIGN KEY FK_member_TO_bookmark_1;
ALTER TABLE notification DROP FOREIGN KEY FK_member_TO_notification_1;
DROP TABLE IF EXISTS member;
CREATE TABLE `member` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `member_id` varchar(100) NOT NULL UNIQUE,
    `member_pass` int NOT NULL,
    `member_name` varchar(30) NOT NULL,
    `member_phone` int NOT NULL,
    `member_number` BIGINT NOT NULL,
    `member_email` varchar(100) NOT NULL,
    `member_address` varchar(100) NULL,
    `member_create_date` date NULL,
    `member_withdraw_date` date NULL,
    `member_state` char(5) NULL COMMENT '정상 : A 탈퇴: D 휴먼:B',
    `role` varchar(30) NULL COMMENT '사용자 :ROLE_USER 관리자:ROLE_ADMIN',
    PRIMARY KEY (`id`)
);
ALTER TABLE bookmark 
ADD CONSTRAINT FK_member_TO_bookmark_1 
FOREIGN KEY (member_id) 
REFERENCES member(member_id);

ALTER TABLE `notification` ADD CONSTRAINT `FK_member_TO_notification_1` FOREIGN KEY (
   `member_id`
)
REFERENCES `member` (
   `member_id`
);


ALTER TABLE board ADD INDEX idx_board_group_key (board_group_key);
ALTER TABLE board ADD CONSTRAINT FKds4hemjpcmcns5s6w88t5jp2f 
FOREIGN KEY (board_group_key) REFERENCES board (board_group_key);
ALTER TABLE board ADD PRIMARY KEY (board_group_key);

ALTER TABLE member MODIFY COLUMN member_pass VARCHAR(255);

select * from member;

ALTER TABLE member MODIFY member_phone VARCHAR(15) NULL;


-- 제약조건 조회
SELECT 
    CONSTRAINT_NAME, 
    CONSTRAINT_TYPE, 
    TABLE_NAME 
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE 
    TABLE_NAME = 'station_info';
    
DROP INDEX CONSTRAINT_NAME ON station_info;

SHOW INDEX FROM station_info;

UPDATE member 
SET role = 'ROLE_ADMIN' 
WHERE member_id = 'admin';

SELECT member_id, role 
FROM member 
WHERE member_id = 'admin';

select * from member;

delete from reservation;
delete from rental;
delete from point;







