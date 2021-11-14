--======================================
--회원 테이블 생성
--======================================

create table member(
    member_id varchar2(15),
    password varchar2(300) not null, -- 암호화
    member_name varchar2(100) not null,
    member_role char(1) default 'U' not null, -- 회원권한 : 일반사용자(U), 관리자(A)
    gender char(1),
    birthday date,
    email varchar2(100),
    phone char(11) not null,
    address varchar2(300),
    hobby varchar2(300), -- 운동, 등산, 독서, 게임, 여행 -> check box랑 연동
    enroll_date date default sysdate,
    constraint pk_member_id primary key(member_id),
    constraint ck_member_gender check(gender in ('M','F')),
    constraint ck_member_role check(member_role in ('U','A'))
);

insert into
    member
values(
    'honggd','1234','홍길동','U','M',to_date('19900909','yyyymmdd'),
    'honggd@naver.com','01012341234','서울시 강남구 테헤란로',
    '운동,등산,독서',default
);
commit;
	insert into member
	values (
		'qwerty', '1234', '쿠어티', 'U', 'F', to_date('19900215','yyyymmdd'),
		'qwerty@naver.com', '01012341234', '서울시 송파구', '운동,등산', default
	);

	insert into member
	values (
		'admin', '1234', '관리자', 'A', 'M', to_date('19801010','yyyymmdd'),
		'admin@naver.com', '01056785678', '서울시 관악구', '게임,독서', default
	);

select * from member;

commit;

	insert into member
	values (
		'admin1', '1234', '김형진',default, 'M',null,
		null, '01056785678', null, null, default
	);
    
rollback;
--회원추가

Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('hihiroo','NieQminDE4Ggcewn98nKl3Jhgq7Smn3dLlQ1MyLPswq7njpt8qwsIP4jQ2MR1nhWTQyNMFkwV19g4tPQSBhNeQ==','김안녕','U','F',to_date('01/10/18','RR/MM/DD'),'hihiroo@naver.com','01023454635','경기도 시흥시','운동,여행',to_date('18/02/05','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('encrypten_man','mZNR9KFjogJnD9J0+gGMKxAAstZidIXEKPLv+Ns42TvZY/o9QcBbDR0s1Vjm4a5HqKZDVPH+sAuM1BD/YwKyVw==','암호화','U','M',to_date('91/02/03','RR/MM/DD'),null,'01012341243',null,null,to_date('18/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('abcd','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김준호','U','M',to_date('92/02/02','RR/MM/DD'),'abcd@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('18/02/01','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('bcde','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서지와','U','F',to_date('93/01/20','RR/MM/DD'),'bcde@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/03/02','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('cdef','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김윤정','U','M',to_date('94/04/20','RR/MM/DD'),'cdef@naver.com','01056745678','서울시 강북구','운동,독서',to_date('18/11/03','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('defg','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박봉철','U','F',to_date('95/01/20','RR/MM/DD'),'defg@naver.com','01012345678','서울시 중구','운동,등산,독서',to_date('18/04/04','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('efgh','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','하정운','U','M',to_date('96/06/03','RR/MM/DD'),'efgh@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/11/05','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('fghi','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','유병송','U','F',to_date('97/01/01','RR/MM/DD'),'fghi@naver.com','01056745678','서울시 중구','운동,등산,독서',to_date('18/03/06','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ghij','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','노민우','U','M',to_date('98/07/02','RR/MM/DD'),'ghij@naver.com','01056745678','서울시 관악구','운동,등산,독서',to_date('18/11/07','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('hijk','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김지호','U','M',to_date('99/04/18','RR/MM/DD'),'hijk@naver.com','01012345678','서울시 관악구','등산,독서',to_date('18/06/08','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ijkl','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','장동준','U','M',to_date('00/04/01','RR/MM/DD'),'ijkl@naver.com','01012345678','서울시 중랑구','운동,등산,독서',to_date('18/06/09','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('jklm','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서연','U','M',to_date('89/07/20','RR/MM/DD'),'jklm@naver.com','01012345678','서울시 강남구','운동,등산,독서',to_date('18/06/10','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('klmn','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서연호','U','M',to_date('88/04/15','RR/MM/DD'),'klmn@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/01/11','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('lmno','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김연우','U','M',to_date('87/03/01','RR/MM/DD'),'lmno@naver.com','01056745678','서울시 중랑구','운동,등산,독서',to_date('18/04/12','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mnop','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정지운','U','M',to_date('86/06/03','RR/MM/DD'),'mnop@naver.com','01056745678','서울시 관악구','운동,등산,독서',to_date('18/06/13','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('nopq','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정구운','U','M',to_date('85/03/20','RR/MM/DD'),'nopq@naver.com','01012345678','서울시 관악구','운동,독서',to_date('18/04/14','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('opqr','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','안성우','U','M',to_date('84/07/01','RR/MM/DD'),'opqr@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/01/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('pqrs','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','이주은','U','M',to_date('83/01/18','RR/MM/DD'),'pqrs@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/01/16','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('qrst','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김보리','U','M',to_date('82/03/02','RR/MM/DD'),'qrst@naver.com','01056745678','서울시 중구','운동,등산,독서',to_date('18/11/17','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('rstu','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','차보라','U','M',to_date('81/06/01','RR/MM/DD'),'rstu@naver.com','01056745678','서울시 서초구','운동,등산,독서',to_date('18/06/18','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('stuv','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','장경자','U','M',to_date('80/07/15','RR/MM/DD'),'stuv@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('18/01/19','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('tuvw','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정성택','U','M',to_date('83/06/20','RR/MM/DD'),'tuvw@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('18/03/01','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('uvwx','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김정은','U','M',to_date('02/07/18','RR/MM/DD'),'uvwx@naver.com','01012345678','서울시 서초구','운동,등산,독서',to_date('18/11/21','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('wxyz','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박보람','U','M',to_date('75/01/01','RR/MM/DD'),'wxyz@naver.com','01098765678','서울시 중구','운동,등산,독서',to_date('18/07/22','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('catmom','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','구본우','U','M',to_date('79/06/15','RR/MM/DD'),'catmom@naver.com','01098765678','서울시 관악구','운동,등산,독서',to_date('18/04/23','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('bear','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','가제트','U','M',to_date('79/11/01','RR/MM/DD'),'bear@naver.com','01012345678','서울시 관악구','운동,독서',to_date('18/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('dogpapa','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','한석규','U','M',to_date('75/07/03','RR/MM/DD'),'dogpapa@naver.com','01012345678','서울시 강남구','운동,등산,독서',to_date('18/06/25','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('fishman','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','두석규','U','M',to_date('83/01/02','RR/MM/DD'),'fishman@naver.com','01012345678','서울시 강남구','등산,독서',to_date('18/07/26','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('buckey','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','세석규','U','M',to_date('75/01/01','RR/MM/DD'),'buckey@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/11/27','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mmary','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','네석규','U','M',to_date('01/03/20','RR/MM/DD'),'mmary@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('18/07/28','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('usbteacher','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','마동석','U','M',to_date('79/06/01','RR/MM/DD'),'usbteacher@naver.com','01012345678','서울시 중구','운동,등산,독서',to_date('18/01/29','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mslove','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','아무개','U','M',to_date('75/11/03','RR/MM/DD'),'mslove@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('18/07/30','RR/MM/DD'));


Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('spongebob','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김밥','U','F',to_date('75/04/20','RR/MM/DD'),'spongebob@naver.com','01023454635','경기도 시흥시','운동,여행',to_date('16/02/05','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ordovician','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','암호화','U','M',to_date('01/01/01','RR/MM/DD'),null,'01012341243',null,null,to_date('16/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('patli','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김준호','U','M',to_date('75/07/18','RR/MM/DD'),'patli@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('16/04/01','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('skitz','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서지와','U','F',to_date('79/07/02','RR/MM/DD'),'skitz@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/11/02','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('hlal','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정윤정','U','M',to_date('75/06/03','RR/MM/DD'),'hlal@naver.com','01056745678','서울시 강북구','운동,독서',to_date('16/02/03','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('skytear','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박봉철','U','F',to_date('83/11/15','RR/MM/DD'),'skyTear@naver.com','01012345678','서울시 중구','운동,등산,독서',to_date('16/07/04','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('leander','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','하정운','U','M',to_date('75/01/01','RR/MM/DD'),'leander@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/04/05','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ripsnarl','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','유병송','U','F',to_date('90/07/03','RR/MM/DD'),'ripSnarl@naver.com','01056745678','서울시 중구','운동,등산,독서',to_date('16/06/06','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('eleuia','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','노민우','U','M',to_date('75/07/20','RR/MM/DD'),'eleuia@naver.com','01056745678','서울시 관악구','운동,등산,독서',to_date('16/01/07','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mrcuddles','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김지호','U','M',to_date('79/06/01','RR/MM/DD'),'mrCuddles@naver.com','01012345678','서울시 관악구','등산,독서',to_date('16/02/08','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('lior','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','장동준','U','M',to_date('79/11/02','RR/MM/DD'),'lior@naver.com','01012345678','서울시 중랑구','운동,등산,독서',to_date('16/01/09','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('eseit','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서연','U','M',to_date('75/01/18','RR/MM/DD'),'eseit@naver.com','01012345678','서울시 강남구','운동,등산,독서',to_date('16/07/10','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('shimmer','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서연호','U','M',to_date('83/06/01','RR/MM/DD'),'shimmer@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/04/11','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('nibbles','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김연우','U','M',to_date('75/11/03','RR/MM/DD'),'nibbles@naver.com','01056745678','서울시 중랑구','운동,등산,독서',to_date('16/01/12','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('pastel','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정지운','U','F',to_date('79/11/15','RR/MM/DD'),'pastel@naver.com','01056745678','서울시 관악구','운동,등산,독서',to_date('16/04/13','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('pewner','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정구운','U','M',to_date('75/07/20','RR/MM/DD'),'pewner@naver.com','01012345678','서울시 관악구','운동,독서',to_date('16/06/14','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mrglows','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','안성우','U','M',to_date('83/02/01','RR/MM/DD'),'mrGlows@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/04/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('raich','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','이주은','U','M',to_date('01/01/02','RR/MM/DD'),'raich@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/11/16','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('jasmine','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김보리','U','M',to_date('75/07/03','RR/MM/DD'),'jasmine@naver.com','01056745678','서울시 중구','운동,등산,독서',to_date('16/01/17','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('zothath','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','차보라','U','M',to_date('75/02/20','RR/MM/DD'),'zothath@naver.com','01056745678','서울시 서초구','운동,등산,독서',to_date('16/07/18','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('imamu','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','장경자','U','M',to_date('79/06/01','RR/MM/DD'),'imamu@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('16/01/19','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('floater','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정성택','U','M',to_date('75/02/03','RR/MM/DD'),'floater@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('16/01/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('nana','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김정은','U','M',to_date('79/09/20','RR/MM/DD'),'nana@naver.com','01012345678','서울시 서초구','운동,등산,독서',to_date('16/02/21','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('shotsathothu','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박보람','U','M',to_date('75/07/02','RR/MM/DD'),'shotSathothu@naver.com','01098765678','서울시 중구','운동,등산,독서',to_date('16/01/22','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('kisaki','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','구본우','U','M',to_date('83/06/01','RR/MM/DD'),'kisaki@naver.com','01098765678','서울시 관악구','운동,등산,독서',to_date('16/07/23','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('notyours','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','가제트','U','M',to_date('79/07/03','RR/MM/DD'),'notYours@naver.com','01012345678','서울시 관악구','운동,독서',to_date('16/09/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('cipanr','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','한석규','U','M',to_date('75/02/01','RR/MM/DD'),'cipanr@naver.com','01012345678','서울시 강남구','운동,등산,독서',to_date('16/01/30','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('iarsere','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','두석규','U','M',to_date('90/02/18','RR/MM/DD'),'iarsere@naver.com','01012345678','서울시 강남구','등산,독서',to_date('16/04/26','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('kubcthothoth','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','세석규','U','M',to_date('75/02/03','RR/MM/DD'),'kubCthothoth@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/01/27','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('claw','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','네석규','U','M',to_date('79/02/01','RR/MM/DD'),'claw@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('16/09/28','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('hibiscus','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','마동석','U','M',to_date('75/10/18','RR/MM/DD'),'hibiscus@naver.com','01012345678','서울시 중구','운동,등산,독서',to_date('16/04/29','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('elania','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','아무개','U','M',to_date('83/10/03','RR/MM/DD'),'elania@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('16/06/30','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mothball','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','노바디','U','M',to_date('75/10/01','RR/MM/DD'),'mothball@naver.com','01012341234','서울시 중구','등산',to_date('16/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ssynec','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','네오','U','M',to_date('79/02/02','RR/MM/DD'),'ssynec@naver.com','01040021863','서울시 강남구',null,to_date('16/04/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('amethyst','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','감사용','U','M',to_date('90/04/01','RR/MM/DD'),'amethyst@naver.com','01012341234','부산시 동래구','운동,등산',to_date('16/04/19','RR/MM/DD'));


Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('xapreiye','NieQminDE4Ggcewn98nKl3Jhgq7Smn3dLlQ1MyLPswq7njpt8qwsIP4jQ2MR1nhWTQyNMFkwV19g4tPQSBhNeQ==','허안녕','U','F',to_date('75/10/03','RR/MM/DD'),'xapreiye@naver.com','01023454635','경기도 시흥시','운동,여행',to_date('17/02/05','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('fliostium','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','부호화','U','M',to_date('83/10/02','RR/MM/DD'),null,'01012341243',null,null,to_date('17/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ocrait','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박준호','U','M',to_date('75/01/01','RR/MM/DD'),'ocrait@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('17/09/01','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('oshary','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','치와와','U','F',to_date('79/04/20','RR/MM/DD'),'oshary@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('17/10/02','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('bleze','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박윤정','U','M',to_date('75/06/03','RR/MM/DD'),'bleze@naver.com','01056745678','서울시 강북구','운동,독서',to_date('17/10/03','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('megriuvania','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','박성철','U','M',to_date('90/09/02','RR/MM/DD'),'megriuvania@naver.com','01012345678','전라도 여수시','운동,등산,독서',to_date('17/01/04','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('glosau','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','고정운','U','M',to_date('75/10/15','RR/MM/DD'),'glosau@naver.com','01012345678','서울시 송파구','독서',to_date('17/03/05','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('lasken','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','유병우','U','F',to_date('79/07/02','RR/MM/DD'),'lasken@naver.com','01056745678','수원시 팔달구','운동,등산,독서',to_date('17/04/06','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('nesnesh','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','노민호','U','M',to_date('90/09/03','RR/MM/DD'),'nesnesh@naver.com','01056745678','서울시 관악구','운동,등산,독서',to_date('17/10/07','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('granite','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김진호','U','M',to_date('75/01/20','RR/MM/DD'),'granite@naver.com','01012345678','서울시 관악구','등산,독서',to_date('17/09/08','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('arachnid','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','장옹이','U','M',to_date('75/10/01','RR/MM/DD'),'arachnid@naver.com','01012345678','서울시 중랑구','운동,등산,독서',to_date('17/04/09','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('blight','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서지연','U','F',to_date('79/06/02','RR/MM/DD'),'blight@naver.com','01012345678','서울시 강남구','운동,등산,독서',to_date('17/10/10','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mist','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','서연요','U','M',to_date('75/09/20','RR/MM/DD'),'mist@naver.com','01012345678','서울시 강북구','운동,등산',to_date('17/02/11','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('mouse','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김연유','U','M',to_date('02/10/03','RR/MM/DD'),'mouse@naver.com','01056745678','서울시 중랑구','운동,등산,독서',to_date('17/07/12','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('scramble','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정지훈','U','M',to_date('75/10/20','RR/MM/DD'),'scramble@naver.com','01056745678','서울시 관악구','운동,등산,독서',to_date('17/01/13','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('rime','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정수윤','U','F',to_date('90/04/02','RR/MM/DD'),'rime@naver.com','01012345678','서울시 관악구','운동,독서',to_date('17/10/14','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('wireless','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','안성호','U','M',to_date('79/07/01','RR/MM/DD'),'wireless@naver.com','01012345678','서울시 강북구','운동',to_date('17/02/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('fiend','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','이주흔','U','M',to_date('79/04/03','RR/MM/DD'),'fiend@naver.com','01012345678','서울시 강북구','운동,독서',to_date('17/01/16','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('pebble','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김보리차','U','M',to_date('01/04/02','RR/MM/DD'),'pebble@naver.com','01056745678','서울시 중구','운동,등산,독서',to_date('17/02/17','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('disperse','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','차보라','U','M',to_date('79/06/15','RR/MM/DD'),'disperse@naver.com','01056745678','서울시 서초구','등산,독서',to_date('17/02/18','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('inferno','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','장경택','U','M',to_date('01/09/02','RR/MM/DD'),'inferno@naver.com','01012345678','서울시 관악구','운동',to_date('17/10/19','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('virtue','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','정은택','U','M',to_date('90/02/01','RR/MM/DD'),'virtue@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('17/04/20','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('plague','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김정인','U','F',to_date('79/01/03','RR/MM/DD'),'plague@naver.com','01012345678','서울시 서초구','등산,독서',to_date('17/03/21','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('light','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김보람','U','M',to_date('01/09/02','RR/MM/DD'),'light@naver.com','01098765678','서울시 중구','운동,등산,독서',to_date('17/02/22','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('plasma','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','구본승','U','M',to_date('02/04/02','RR/MM/DD'),'plasma@naver.com','01098765678','인천','등산',to_date('17/02/23','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('nightshade','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','가제현','U','M',to_date('90/10/20','RR/MM/DD'),'nightshade@naver.com','01012345678','서울시 관악구','운동,독서',to_date('17/01/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('ooze','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','한고은','U','F',to_date('01/06/02','RR/MM/DD'),'ooze@naver.com','01012345678','서울시 강남구','운동,등산,독서',to_date('17/09/25','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('shift','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','두고은','U','F',to_date('76/02/20','RR/MM/DD'),'shift@naver.com','01012345678','서울시 강남구','등산,독서',to_date('17/03/26','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('luna','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','세고은','U','F',to_date('02/02/03','RR/MM/DD'),'luna@naver.com','01012345678','서울시 강북구','운동,등산,독서',to_date('17/09/27','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('cecirh','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','네고은','U','F',to_date('01/04/15','RR/MM/DD'),'cecirh@naver.com','01012345678','서울시 관악구','운동,등산,독서',to_date('17/04/28','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('illuminos','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','마동탁','U','M',to_date('76/02/02','RR/MM/DD'),'illuminos@naver.com','01012345678','서울시 중구','운동,등산,독서',to_date('17/10/29','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('shockwave','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','아무나','U','M',to_date('83/01/01','RR/MM/DD'),'shockwave@naver.com','01012345678','서울시 강북구','여행',to_date('17/02/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('thunder','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','애니바디','U','M',to_date('76/09/20','RR/MM/DD'),'thunder@naver.com','01012341234','서울시 중구','등산',to_date('17/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('steelskin','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김쇠살','U','M',to_date('90/10/01','RR/MM/DD'),'steelskin@naver.com','01040021863','서울시 강남구',null,to_date('17/04/01','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('glutton','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','감사용','U','M',to_date('83/02/02','RR/MM/DD'),'glutton@naver.com','01012341234','부산시 동래구','운동,등산',to_date('17/04/19','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('puma','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','하퓨마','U','M',to_date('76/04/03','RR/MM/DD'),'puma@naver.com','01012341234','부산광역시','운동',to_date('17/04/18','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('shadow','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','그리무','U','M',to_date('01/10/20','RR/MM/DD'),'shadow@naver.com','01012341234','대구','독서',to_date('17/04/17','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('bandit','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','반디','U','M',to_date('76/02/02','RR/MM/DD'),'bandit@naver.com','01012341234','충청남도','등산',to_date('17/04/16','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('pandemonium','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','김판돌','U','M',to_date('83/03/03','RR/MM/DD'),'pandemonium@naver.com','01012341234','경상북도','등산,여행',to_date('17/04/15','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('shqkel','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','노바디','U','M',to_date('90/09/02','RR/MM/DD'),'shqkel@naver.com','01012341234','서울시 중구','등산',to_date('18/03/24','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('neoneo','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','네오','U','M',to_date('76/10/02','RR/MM/DD'),'neoneo@naver.com','01040021863','서울시 강남구',null,to_date('18/04/20','RR/MM/DD'));
Insert into WEB.MEMBER (MEMBER_ID,PASSWORD,MEMBER_NAME,MEMBER_ROLE,GENDER,BIRTHDAY,EMAIL,PHONE,ADDRESS,HOBBY,ENROLL_DATE) values ('kamsayoyo','1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==','감사용','U','M',to_date('83/06/20','RR/MM/DD'),'ksy@naver.com','01012341234','부산시 동래구','운동,등산',to_date('18/04/19','RR/MM/DD'));

commit;


--페이징쿼리
select
    *
from(
select
    row_number ()over(order by enroll_date desc) rnum,
    m.*
from
    member m)
where
    rnum between 1 and 10;
    
select count(*)from member;


-----------------------------------------------------
-- 게시판
-----------------------------------------------------
create table board(
    no number,
    title varchar2(100) not null,
    writer varchar2(20),
    content varchar2(4000) not null,
    read_count number default 0,
    reg_date date default sysdate,
    constraint pk_board_no primary key(no),
    constraint fk_board_writer foreign key(writer)  references member(member_id) on delete set null
);

create sequence seq_board_no;

create table attachment (
    no number,
    board_no number not null,
    original_filename varchar2(255) not null,
    renamed_filename varchar2(255) not null,
    reg_date date default sysdate,
    constraint pk_attachment_no primary key(no),
    constraint fk_attachment_board_no foreign key(board_no) references board(no) on delete cascade
);

create sequence seq_attachment_no;

comment  on table board is '게시글';
comment on column board.no is '게시글번호';
comment on column board.title is '게시글제목';
comment on column board.writer is '게시글작성자 아이디';
comment on column board.content is '게시글내용';
comment on column board.read_count is '조회수';
comment on column board.reg_date is '게시글작성일시';

comment  on table attachment is '첨부파일';
comment on column attachment.no is '첨부파일번호(PK)';
comment on column attachment.board_no is '게시판글번호(FK)';
comment on column attachment.original_filename is '업로드한 첨부파일명';
comment on column attachment.renamed_filename is '서버에 저장된 첨부파일명';
comment on column attachment.reg_date is '첨부파일업로드일시';
				
        
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 1','honggd','반갑습니다',to_date('18/02/10','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 2','qwerty','안녕하세요',to_date('18/02/12','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 3','admin','반갑습니다',to_date('18/02/13','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 4','honggd','안녕하세요',to_date('18/02/14','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 5','qwerty','반갑습니다',to_date('18/02/15','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 6','admin','안녕하세요',to_date('18/02/16','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 7','honggd','반갑습니다',to_date('18/02/17','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 8','qwerty','안녕하세요',to_date('18/02/18','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 9','admin','반갑습니다',to_date('18/02/19','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 10','honggd','안녕하세',to_date('18/02/20','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 11','qwerty','반갑습니다',to_date('18/03/11','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 12','admin','안녕하세',to_date('18/03/12','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 13','honggd','반갑습니다',to_date('18/03/13','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 14','qwerty','안녕하세',to_date('18/03/14','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 15','admin','반갑습니다',to_date('18/03/15','RR/MM/DD'),0);


insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 16','honggd','안녕하세',to_date('18/03/16','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 17','qwerty','반갑습니다',to_date('18/03/17','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 18','admin','안녕하세',to_date('18/03/18','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 19','honggd','반갑습니다',to_date('18/03/19','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 20','qwerty','안녕하세',to_date('18/03/20','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 21','admin','반갑습니다',to_date('18/04/01','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 22','honggd','안녕하세',to_date('18/04/02','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 23','qwerty','반갑습니다',to_date('18/04/03','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 24','admin','안녕하세',to_date('18/04/04','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 25','honggd','반갑습니다',to_date('18/04/05','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 26','qwerty','안녕하세',to_date('18/04/06','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 27','admin','반갑습니다',to_date('18/04/07','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 28','honggd','안녕하세',to_date('18/04/08','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 29','qwerty','반갑습니다',to_date('18/04/09','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 30','admin','안녕하세',to_date('18/04/10','RR/MM/DD'),0);

insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 31','honggd','반갑습니다',to_date('18/04/16','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 32','qwerty','안녕하세',to_date('18/04/17','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 33','admin','반갑습니다',to_date('18/04/18','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 34','honggd','안녕하세',to_date('18/04/19','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 35','qwerty','반갑습니다',to_date('18/04/20','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 36','admin','안녕하세',to_date('18/05/01','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 37','honggd','반갑습니다',to_date('18/05/02','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 38','qwerty','안녕하세',to_date('18/05/03','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 39','admin','반갑습니다',to_date('18/05/04','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 40','honggd','안녕하세',to_date('18/05/05','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 41','qwerty','반갑습니다',to_date('18/05/06','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 42','admin','안녕하세',to_date('18/05/07','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 43','honggd','반갑습니다',to_date('18/05/08','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 44','qwerty','안녕하세',to_date('18/05/09','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 45','admin','반갑습니다',to_date('18/05/10','RR/MM/DD'),0);

insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 46','honggd','안녕하세',to_date('18/05/16','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 47','qwerty','반갑습니다',to_date('18/05/17','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 48','admin','안녕하세',to_date('18/05/18','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 49','honggd','반갑습니다',to_date('18/05/19','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 50','qwerty','안녕하세',to_date('18/05/20','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 51','admin','반갑습니다',to_date('18/05/01','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 52','honggd','안녕하세',to_date('18/06/02','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 53','qwerty','반갑습니다',to_date('18/06/03','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 54','admin','안녕하세',to_date('18/06/04','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 55','honggd','반갑습니다',to_date('18/06/05','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 56','qwerty','안녕하세',to_date('18/06/06','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 57','admin','반갑습니다',to_date('18/06/07','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 58','honggd','안녕하세',to_date('18/06/08','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 59','qwerty','반갑습니다',to_date('18/06/09','RR/MM/DD'),0);
insert into web.board (no,title,writer,content,reg_date,read_count) values (seq_board_no.nextval,'안녕하세요, 게시판입니다 - 60','admin','안녕하세',to_date('18/06/10','RR/MM/DD'),0);

insert into web.attachment(no, board_no, original_filename, renamed_filename)
values(seq_attachment_no.nextval, 60, 'test.txt', '20211007_12345.txt');

commit;

select * from board;
select count(*) from board;

select
    *
from(
    select
        row_number ()over(order by reg_date desc) rnum,
        b.*,
        (select count(*) from attachment where board_no = b.no) attach_count
    from board b)
where rnum between 1 and 10;


select
    *
from board b left join attachment a 
    on b.no = a.board_no;
    

select * from attachment;		
--insert into attachment(no, board_no, original_filename, renamed_filename) values(seq_attachment_no.nextval,( select seq_board_no.currval from dual), 'aaa','bbb');

select * from board;
select * from attachment where board_no = 67;

select b.*, a.*, a.no attach_no from board b left join attachment a on b.no = a.board_no where b.no = 45;

update board set read_count = read_count + 1 where no = 69;

commit;


delete from board where no =66;
rollback;

