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
select * from attachment where board_no = 66;

select b.*, a.*, a.no attach_no from board b left join attachment a on b.no = a.board_no where b.no = 45;

update board set read_count = read_count + 1 where no = 69;

commit;


delete from board where no =66;
rollback;

update board set title = '?', content = '?' where no = 65;

-----------------------------------------------------------
-- 게시판 댓글
-----------------------------------------------------------
create table board_comment(
    no number,
    comment_level number default 1, -- 댓글 1, 대댓글 2
    writer varchar2(15),
    content varchar2(2000),
    board_no number,
    comment_ref number, -- 대댓글인 경우, 참조하는 댓글번호, 댓글인 경우 NULL
    reg_date date default sysdate,
    constraint pk_board_comment_no primary key(no),
    constraint fk_board_comment_writer foreign key(writer) references member (member_id) on delete set null,
    constraint fk_board_comment_board_no foreign key(board_no) references board(no) on delete cascade,
    constraint fk_board_comment_comment_ref foreign key (comment_ref) references board_comment(no) on delete cascade
);

create sequence seq_board_comment_no;

-- 댓글데이터 생성
select*from board order by no desc; --72

insert into board_comment values( seq_board_comment_no.nextval, default, 'honggd', '멋진글입니다', 72, null, default);
insert into board_comment values( seq_board_comment_no.nextval, default, 'qwerty', '멋진글입니다', 72, null, default);
insert into board_comment values( seq_board_comment_no.nextval, default, 'admin', '멋진글입니다', 72, null, default);
--대댓글
insert into board_comment values( seq_board_comment_no.nextval, 2, 'sejong', '감사합니다', 72, 1, default);
insert into board_comment values( seq_board_comment_no.nextval, 2, 'honggd', '별말씀을요~', 72, 1, default);

commit;

select * from board_comment;

--계층형 쿼리
--행과 행 사이의 부모/자식관계를 고려해 조회
-- start with 조건절 : 최상위 부모행의 조건을 작성
-- connect by a=b : 부모/자식행의 연결조건 작성. PRIOR키워드 부모컬럼 앞에 위치
-- level 가상컬럼 제공. 최상위부모부터 1씩 증가 처리

select
    *
from
    board_comment
where
    board_no = 72
start with
    comment_level = 1
connect by prior
    no = comment_ref
order siblings by
    no;
    
select
    *
from(
    select
        row_number() over(order by no desc) rnum,
        b.*,
        (select count(*) from attachment where board_no = b.no) attach_count,
        (select count(*) from board_comment where board_no = b.no) comment_count
    from
        board b);

