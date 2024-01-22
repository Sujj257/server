DROP FUNCTION IF EXISTS public.lg_auth(integer, character varying, character varying, character varying, character varying);
DROP FUNCTION IF EXISTS public.lg_updateaccount(integer, bigint, character varying, character varying, boolean, boolean, bigint, bigint);
DROP FUNCTION IF EXISTS public.lg_updateaccount(integer, bigint, character varying, character varying, boolean, boolean, bigint, bigint, bigint);
DROP FUNCTION IF EXISTS public.sd_blockuser(integer, bigint, boolean);
DROP FUNCTION IF EXISTS public.sd_blockuser(integer, bigint, bigint, boolean);
DROP FUNCTION IF EXISTS public.sd_create_downline_query(bigint, boolean);
DROP FUNCTION IF EXISTS public.sd_get_topcount(integer, bigint, character varying, character varying, bigint, boolean, boolean, character varying, bigint);
DROP FUNCTION IF EXISTS public.lg_addcommission(integer, bigint, double precision, double precision, double precision, double precision, boolean);
DROP FUNCTION IF EXISTS public.sd_get_purchasehistory(integer, bigint, character varying, character varying, integer, boolean, character varying, bigint, boolean);
DROP FUNCTION IF EXISTS public.sd_update_winningprize(bigint, bigint, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric);
DROP FUNCTION IF EXISTS public.sd_get_winning_commission(bigint);
DROP FUNCTION IF EXISTS public.sd_get_winning_number(character varying, character varying, integer, character varying);
DROP FUNCTION IF EXISTS public.lg_createaccount(integer, character varying, character varying, boolean, boolean, bigint, bigint, bigint);
DROP FUNCTION IF EXISTS public.sd_daily_report(bigint, character varying, character varying, integer, boolean, json, bigint, boolean);
DROP FUNCTION IF EXISTS public.lg_createaccount(integer, character varying, character varying, boolean, boolean, bigint, bigint, bigint);
DROP FUNCTION IF EXISTS public.lg_setdraw(integer, bigint, boolean, boolean, boolean, boolean, boolean);
DROP FUNCTION IF EXISTS public.sd_editdrawtime(bigint, boolean, integer, character varying, character varying);
DROP FUNCTION IF EXISTS public.sd_get_draw(integer, bigint);
DROP FUNCTION IF EXISTS public.sd_purchasehistory(bigint, character varying, character varying, integer, boolean, character varying, bigint, boolean);
DROP FUNCTION IF EXISTS public.sd_delete_bill(integer, bigint, character varying, bigint);
DROP FUNCTION IF EXISTS public.sd_delete_booking(integer, bigint, bigint);
DROP FUNCTION IF EXISTS public.sd_delete_ticket(integer, bigint, bigint);
DROP FUNCTION IF EXISTS public.sd_execute_winning(bigint, character varying, character varying, character varying, character varying, character varying, character varying, character varying[], boolean);
DROP FUNCTION IF EXISTS public.sd_executewinning(bigint, character varying, character varying, character varying, character varying, character varying, character varying, character varying[], boolean, boolean);
DROP FUNCTION IF EXISTS public.sd_update_winningentry(bigint, bigint, character varying, numeric, numeric, boolean, boolean);
DROP FUNCTION IF EXISTS public.sd_winning_entry(bigint, bigint, character varying, numeric, numeric, boolean, boolean);
DROP FUNCTION IF EXISTS public.sd_update_winningcommission(bigint, bigint, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, boolean);
DROP FUNCTION IF EXISTS public.sd_update_winningprize(bigint, bigint, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric);
DROP FUNCTION IF EXISTS public.sd_get_profile(integer, bigint);
DROP FUNCTION IF EXISTS public.sd_winningresult(character varying, character varying, integer);
DROP FUNCTION IF EXISTS public.sd_getdownlist(bigint);
DROP FUNCTION IF EXISTS public.lg_updateaccount(integer, bigint, character varying, character varying, boolean, boolean, bigint, bigint, bigint);
DROP FUNCTION IF EXISTS public.sd_booking_ticket(integer, bigint, bigint, double precision, double precision, bigint, character varying);
DROP FUNCTION IF EXISTS public.sd_check_ticket_availability(character varying, bigint, character varying, bigint);
DROP FUNCTION IF EXISTS public.sd_create_ticket(bigint, character varying, character varying, bigint, double precision, double precision, character varying, bigint, character varying);







alter table user_login drop column c_amt;
alter table user_login drop column d_amt;

ALTER TABLE user_session DROP CONSTRAINT user_session_pkey;
ALTER TABLE user_session DROP CONSTRAINT us;
ALTER TABLE booking_ticket DROP CONSTRAINT ticket;


create table appconfig(
				event_id serial,
				event_name varchar(35) not null,
				events varchar(75) not null);

insert into appconfig(event_name,events) values('app_name','lottery');
insert into appconfig(event_name,events) values('maintenance','false');
insert into appconfig(event_name,events) values('min_version','1.1');
insert into appconfig(event_name,events) values('latest_version','1.2');
insert into appconfig(event_name,events) values('maintenance_msg','today no sales');

alter table user_login add column privilage_level int not null default 3;


create table drawconfig as select * from draw_type;


alter table drawconfig add column draw_start varchar(25) not null default '00:00'; 
alter table drawconfig add column delete_end varchar(25) not null default '00:00'; 
alter table drawconfig add column draw_end varchar(25) not null default '00:00'; 
alter table drawconfig drop column time_column;
alter table user_login RENAME COLUMN user_id TO account_id;



update drawconfig set draw_start='12:58:00' where draw_id=1;
update drawconfig set delete_end='12:50:00' where draw_id=1;
update drawconfig set draw_end='23:59:59' where draw_id=1;

update drawconfig set draw_start='15:00:00' where draw_id=2;
update drawconfig set delete_end='14:50:00' where draw_id=2;
update drawconfig set draw_end='23:59:59' where draw_id=2;

update drawconfig set draw_start='17:58:00' where draw_id=3;
update drawconfig set delete_end='17:50:00' where draw_id=3;
update drawconfig set draw_end='23:59:59' where draw_id=3;

update drawconfig set draw_start='19:58:00' where draw_id=4;
update drawconfig set delete_end='19:50:00' where draw_id=4;
update drawconfig set draw_end='23:59:59' where draw_id=4;



drop table if exists user_details;
create table user_details(
    account_id bigint not null,
    placement_id bigint not null default 0,
	daily_limit bigint not null default 0,
	weekly_limit bigint not null default 0,
	block_winning boolean DEFAULT false,
    draw_1 boolean not null default true,   
    draw_2 boolean not null default true,
    draw_3 boolean not null default true,
    draw_4 boolean not null default true,
    dc_single numeric(7,2) not null default 0,
    dc_double numeric(7,2) not null default 0,
    dc_dear numeric(7,2) not null default 0,
    dc_box numeric(7,2) not null default 0,
    wp_dear_1 numeric(7,2) DEFAULT 5000,
    wp_dear_2 numeric(7,2) DEFAULT 500,
    wp_dear_3 numeric(7,2) DEFAULT 250,
    wp_dear_4 numeric(7,2) DEFAULT 100,
    wp_dear_5 numeric(7,2) DEFAULT 50,
    wp_dear_6 numeric(7,2) DEFAULT 20,
	wc_dear_1 numeric(7,2) DEFAULT 400,
	wc_dear_2 numeric(7,2) DEFAULT 50,
	wc_dear_3 numeric(7,2) DEFAULT 20,
	wc_dear_4 numeric(7,2) DEFAULT 20,
	wc_dear_5 numeric(7,2) DEFAULT 20,
	wc_dear_6 numeric(7,2) DEFAULT 10,
	wp_single_1 numeric(7,2) DEFAULT 100,
	wc_single_1 numeric(7,2) DEFAULT 0,
	wp_double_1 numeric(7,2) DEFAULT 700,
	wc_double_1 numeric(7,2) DEFAULT 30,
	wp_box_same1 numeric(7,2) DEFAULT 7000,
	wc_box_same1 numeric(7,2) DEFAULT 450,
	wp_box_both1 numeric(7,2) DEFAULT 3800,
	wc_box_both1 numeric(7,2) DEFAULT 330,
	wp_box_both2 numeric(7,2) DEFAULT 1600,
	wc_box_both2 numeric(7,2) DEFAULT 60,
	wp_box_shuffle1 numeric(7,2) DEFAULT 3000,
	wc_box_shuffle1 numeric(7,2) DEFAULT 300,
	wp_box_shuffle2 numeric(7,2) DEFAULT 800,
	wc_box_shuffle2 numeric(7,2) DEFAULT 30,
	upline_members bigint[] NOT NULL DEFAULT '{}'
); 
 





create table manage_ticket(
	ticket_type character varying(100) not null,
	ticket_count character varying not null,
	updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP 	
);

insert into manage_ticket(ticket_type,ticket_count) values('a','2000');
insert into manage_ticket(ticket_type,ticket_count) values('b','2000');
insert into manage_ticket(ticket_type,ticket_count) values('c','2000');
insert into manage_ticket(ticket_type,ticket_count) values('ab','200');
insert into manage_ticket(ticket_type,ticket_count) values('bc','200');
insert into manage_ticket(ticket_type,ticket_count) values('ac','200');
insert into manage_ticket(ticket_type,ticket_count) values('dear','100');
insert into manage_ticket(ticket_type,ticket_count) values('box','50');
insert into manage_ticket(ticket_type,ticket_count) values('special','20');
insert into manage_ticket(ticket_type,ticket_count) values('special_numbers','{000,111,222,333,444,555,666,777,888,999,023,123}');



do
$$
declare
	item record;
begin
	for item in select * from crm_commission
	loop
		insert into user_details(account_id, dc_single, dc_double, dc_dear,dc_box) values(item.account_id,item.abc,item.abbcac,item.s_dear,item.s_box);
	end loop;
end
$$;





do
$$
declare
	item record;
begin
	for item in select * from user_login
	loop
	if item.isadmin=true then
		update user_login set privilage_level = 1 where account_id = item.account_id;
	elseif item.is_subadmin=true then
		update user_login set privilage_level = 2 where account_id = item.account_id;
	end if;
	end loop;
end
$$;



do
$$
declare
	item record;
begin
	for item in select * from sd_winning_commission
	loop
		update user_details set wp_dear_1=item.dear_1st_prize,
                                wp_dear_2=item.dear_2st_prize,
                                wp_dear_3=item.dear_3st_prize,
                                wp_dear_4=item.dear_4st_prize,
                                wp_dear_5=item.dear_5st_prize,
                                wp_dear_6=item.dear_6st_prize,
                                wc_dear_1=item.dear_1st_prize_commission,
                                wc_dear_2=item.dear_2st_prize_commission,
                                wc_dear_3=item.dear_3st_prize_commission,
                                wc_dear_4=item.dear_4st_prize_commission,
                                wc_dear_5=item.dear_5st_prize_commission,
                                wc_dear_6=item.dear_6st_prize_commission,
                                wp_single_1=item.abc_1st_prize,
                                wc_single_1=item.abc_1st_prize_commission,
                                wp_double_1=item.abbcac_1st_prize,
                                wc_double_1=item.abbcac_1st_prize_commission,
                                wp_box_same1=item.box_same_1st_prize,
                                wc_box_same1=item.box_same_1st_prize_commission,
                                wp_box_both1=item.box_both_1st_prize,
                                wc_box_both1=item.box_both_1st_prize_commission,
                                wp_box_both2=item.box_both_2st_prize,
                                wc_box_both2=item.box_both_2st_prize_commission,
                                wp_box_shuffle1=item.box_shuffle_1st_prize,
                                wc_box_shuffle1=item.box_shuffle_1st_prize_commission,
                                wp_box_shuffle2=item.box_shuffle_2st_prize,
                                wc_box_shuffle2=item.box_shuffle_2st_prize_commission,
                                block_winning=item.block_from_draw
                where account_id = item.dealer_account_id;
	end loop;
end
$$;




do
$$
declare
	item record;
	tempp bigint;
begin
	for item in select * from user_login
	loop
		if item.placement_id is null then
			tempp=0;
		else 
			tempp = item.placement_id;
		end if;
		update user_details set daily_limit=item.daily_limit, 
								weekly_limit=item.weekly_limit, 
								placement_id=tempp 
                                where account_id =(select account_id from account_login_map where user_id = item.account_id);
	end loop;
end
$$;





DO $$ 
DECLARE
   PLACEMENT__ID BIGINT = 0;
   ITEM RECORD;
   ITEM1 RECORD;
   UPLINE BIGINT[] := '{}';
BEGIN

	FOR ITEM IN select account_id,placement_id from user_details
	LOOP
		UPLINE := '{}';
		UPLINE := array_append(UPLINE, ITEM.account_id);
		PLACEMENT__ID = ITEM.placement_id;
		IF PLACEMENT__ID != 0 AND PLACEMENT__ID != 56 THEN
			UPLINE := array_append(UPLINE, PLACEMENT__ID);
		END IF;
	    WHILE PLACEMENT__ID != 0 LOOP
	   		select placement_id from user_details where account_id = PLACEMENT__ID INTO ITEM1;
			PLACEMENT__ID = ITEM1.placement_id;
			IF PLACEMENT__ID != 0 AND PLACEMENT__ID != 56 THEN
				UPLINE := array_append(UPLINE, PLACEMENT__ID);
			END IF;
		END LOOP;
		RAISE NOTICE 'UPLINE LIST: %',UPLINE;
		UPDATE USER_DETAILS SET UPLINE_MEMBERS = UPLINE WHERE ACCOUNT_ID = ITEM.ACCOUNT_ID;
	END LOOP;
END $$;




alter table user_login drop column daily_limit;
alter table user_login drop column weekly_limit;
alter table user_login drop column placement_id;
alter table user_login drop column is_subadmin;
alter table user_login drop column isadmin;


-- v3 added code



ALTER TABLE sd_winning_commission DROP CONSTRAINT sdwc;
ALTER TABLE sd_winning_history DROP CONSTRAINT sdwh;



DROP TABLE IF EXISTS appsettings;
DROP TABLE IF EXISTS crm_commission;
DROP TABLE IF EXISTS crm_draw;
DROP TABLE IF EXISTS dailtemptable;
DROP TABLE IF EXISTS ticket_controller;
DROP TABLE IF EXISTS timecontroller;
DROP TABLE IF EXISTS winning_check;
DROP TABLE IF EXISTS winning_temp_table;
DROP TABLE IF EXISTS account_statement;
DROP TABLE IF EXISTS timee;
DROP TABLE IF EXISTS account_login_map;
DROP TABLE IF EXISTS draw_type;
DROP TABLE IF EXISTS sd_winning_commission;



ALTER TABLE IF EXISTS PUBLIC.DRAWCONFIG ADD PRIMARY KEY(DRAW_ID);

ALTER TABLE  IF EXISTS user_details ADD column upline_admin bigint not null default 56; 

DROP TABLE IF EXISTS BOOKING_TICKETS;
DROP TABLE IF EXISTS TICKET_TABLE;
DROP TABLE IF EXISTS PURCHASE_COUNT;
DROP TABLE IF EXISTS TICKETCONFIG;
DROP TABLE IF EXISTS BLOCKED_TICKETS;
DROP TABLE IF EXISTS WINNING_HISTORY;
DROP TABLE IF EXISTS DELETE_HISTORY;
DROP TABLE IF EXISTS PROFILE_UPDATE_HISTORY;


CREATE TABLE IF NOT EXISTS BLOCKED_TICKETS(S_ID serial,
			TITLE CHARACTER VARYING(50) NOT NULL,
			B_NUMBERS CHARACTER VARYING[] NOT NULL DEFAULT '{}',
			MAX_LIMIT integer NOT NULL,
			ENABLED boolean NOT NULL DEFAULT TRUE);


CREATE TABLE IF NOT EXISTS TICKETCONFIG(ACCOUNT_ID bigint,
					DRAW_ID INT NOT NULL,
					SINGLE_A integer NOT NULL DEFAULT 2000,
					SINGLE_B integer NOT NULL DEFAULT 2000,
					SINGLE_C integer NOT NULL DEFAULT 2000,
					DOUBLE_AB integer NOT NULL DEFAULT 200,
					DOUBLE_BC integer NOT NULL DEFAULT 200,
					DOUBLE_AC integer NOT NULL DEFAULT 200,
					TRIPLE_DEAR integer NOT NULL DEFAULT 100,
					TRIPLE_BOX integer NOT NULL DEFAULT 50,
					CONSTRAINT TC_ACCOUNTID
					FOREIGN KEY(ACCOUNT_ID) REFERENCES USER_LOGIN(ACCOUNT_ID));

INSERT INTO BLOCKED_TICKETS(TITLE,B_NUMBERS,MAX_LIMIT) 
	VALUES ('special','{000,111,222,333,444,555,666,777,888,999,023}'::CHARACTER VARYING[],50);



CREATE TABLE BOOKING_TICKETS(BOOKING_ID BIGSERIAL NOT NULL PRIMARY KEY,
							D_NAME CHARACTER VARYING(30) NOT NULL,
							C_NAME CHARACTER VARYING(30),
							ACCOUNT_ID bigint NOT NULL,
							DRAW_ID integer NOT NULL,
							DRAW_TIME CHARACTER VARYING(20) NOT NULL,
							P_DATE CHARACTER VARYING(15) NOT NULL,
							TOTAL_COUNT integer NOT NULL DEFAULT 0,
							TOTAL_CAMT NUMERIC(7,2) NOT NULL  DEFAULT 0,
							TOTAL_DAMT NUMERIC(7,2) NOT NULL  DEFAULT 0,
							WINNING_EXECUTED boolean DEFAULT FALSE NOT NULL,
							SUB_PURCHASED boolean,
							DELETED boolean NOT NULL DEFAULT FALSE,
							DELETED_BY BIGINT,
							TICKET_MAP_LIST bigint[] NOT NULL DEFAULT '{}',
							TICKET_LIST bigint[] NOT NULL DEFAULT '{}', 
							CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
							UPDATED_AT TIMESTAMP,
							CONSTRAINT BT_ACCOUNTID
							FOREIGN KEY(ACCOUNT_ID) REFERENCES USER_LOGIN(ACCOUNT_ID),
							CONSTRAINT BT_DRAWID
							FOREIGN KEY(DRAW_ID) REFERENCES DRAWCONFIG(DRAW_ID));


CREATE TABLE TICKET_TABLE (BOOKING_ID bigint, TICKET_ID BIGSERIAL PRIMARY KEY,
                            DRAW_ID integer NOT NULL,
                            TICKET_TYPE CHARACTER VARYING(15) NOT NULL,
                            TICKET_NUMBER CHARACTER VARYING(8) NOT NULL,
                            TICKET_COUNT integer NOT NULL DEFAULT 0,
                            C_AMT NUMERIC(7,2) NOT NULL DEFAULT 0,
                            D_AMT NUMERIC(7,2) NOT NULL DEFAULT 0,
                            WINNED boolean DEFAULT FALSE,
                            DELETED boolean DEFAULT FALSE,
                            PURCHASE_DATE CHARACTER VARYING(15) NOT NULL,
                            WINNING_EXECUTED boolean DEFAULT FALSE,
							TICKETID_MAP_LIST bigint[] NOT NULL DEFAULT '{}',
                            CONSTRAINT TICKETS_BID
                            FOREIGN KEY (BOOKING_ID) REFERENCES PUBLIC.BOOKING_TICKETS (BOOKING_ID));


CREATE TABLE PURCHASE_COUNT (SERIAL_ID BIGSERIAL,
							ACCOUNT_ID bigint NOT NULL,
							PURCHASE_DATE CHARACTER VARYING(15) NOT NULL,
							DRAW_ID integer NOT NULL DEFAULT 0,
							SINGLE_A integer NOT NULL DEFAULT 0,
							SINGLE_B integer NOT NULL DEFAULT 0,
							SINGLE_C integer NOT NULL DEFAULT 0,
							DOUBLE_AB integer NOT NULL DEFAULT 0,
							DOUBLE_BC integer NOT NULL DEFAULT 0,
							DOUBLE_AC integer NOT NULL DEFAULT 0,
							TRIPLE_DEAR integer NOT NULL DEFAULT 0,
							TRIPLE_BOX integer NOT NULL DEFAULT 0,
							TRIPLE_SPECIAL integer NOT NULL DEFAULT 0,
							UPDATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
							CONSTRAINT PURCHASECOUNT_AID
						    FOREIGN KEY (ACCOUNT_ID) REFERENCES PUBLIC.USER_LOGIN (ACCOUNT_ID));


CREATE TABLE WINNING_HISTORY(S_ID serial PRIMARY KEY,
							updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
							draw_id int NOT NULL,
							draw_date character varying(14) NOT NULL,
							winning_1 character varying(5) NOT NULL,
							winning_2 character varying(4),
							winning_3 character varying(4),
							winning_4 character varying(4),
							winning_5 character varying(4),
							winning_6 character varying(4)[]);

CREATE TABLE DELETE_HISTORY(
							S_ID BIGSERIAL,
							ACCOUNT_ID BIGINT NOT NULL,
							BOOKING_ID BIGINT,
							TICKET_ID BIGINT,
							DELETED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE PROFILE_UPDATE_HISTORY(
							S_ID SERIAL PRIMARY KEY,
							UPDATED_BY BIGINT,
							ACCOUNT_ID  CHARACTER VARYING(20),
							UPDATE_TYPE CHARACTER VARYING(50),
							OLD_VALUE CHARACTER VARYING,
							NEW_VALUE CHARACTER VARYING,
							UPDATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE winners DROP CONSTRAINT winning_cons;


do
$$
declare
	item record;
begin
	for item in select * from user_login where account_id = 56
	loop
		insert into TICKETCONFIG(account_id,draw_id) values(item.account_id,1);
		insert into TICKETCONFIG(account_id,draw_id) values(item.account_id,2);
		insert into TICKETCONFIG(account_id,draw_id) values(item.account_id,3);
		insert into TICKETCONFIG(account_id,draw_id) values(item.account_id,4);
	end loop;
end
$$;



DO $$ 
BEGIN
    INSERT INTO winning_history (s_id, updated_at, draw_id, draw_date, winning_1, winning_2, winning_3, winning_4, winning_5, winning_6)
    SELECT
        winning_draw_id AS s_id,
        updated_at,
        draw_id,
        draw_date,
        top_prize_num AS winning_1,
        dear_2st_prize_num AS winning_2,
        dear_3st_prize_num AS winning_3,
        dear_4st_prize_num AS winning_4,
        dear_5st_prize_num AS winning_5,
        dear_6st_prize_num AS winning_6
    FROM sd_winning_history;
    RAISE NOTICE 'winning_history Data migration completed successfully!';
END $$;



CREATE OR REPLACE FUNCTION public.ext_downlinequery(
	privilage__level int,
	account__id bigint,
	req_by bigint,
	getall boolean,
	agent_rate boolean)
    RETURNS bigint[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    downlines bigint[];
BEGIN
	-- select ext_downlinequery(2,null,187,true,false);
	
	RAISE NOTICE 'privilage__level: %',privilage__level;
	
	IF privilage__level = 3 THEN
		downlines := ARRAY_APPEND(downlines,req_by);
	ELSEIF privilage__level = 2 THEN
		-- IF agent_rate = TRUE AND account__id IS null THEN
		IF agent_rate = TRUE THEN
			downlines := array_append(downlines,req_by);
		ELSE
			SELECT downline FROM USER_LOGIN WHERE ACCOUNT_ID = req_by INTO downlines;
			downlines := array_append(downlines,req_by);
			IF getall <> true THEN
				IF (SELECT downlines @> ARRAY[account__id] AS contains_account__id) THEN
					downlines := '{}';
					downlines := array_append(downlines,account__id);
				ELSE
					downlines := '{}';
					downlines := array_append(downlines,req_by);				
				END IF;
			END IF;
		END IF;
	ELSEIF privilage__level = 1 THEN
		IF getall = true THEN
			SELECT downline FROM USER_LOGIN WHERE ACCOUNT_ID = account__id INTO downlines;
			IF account__id = req_by THEN
				downlines := array_append(downlines,account__id);
			END IF;
		ELSE
			downlines := '{}';
			downlines := array_append(downlines,account__id);				
		END IF;
	ELSE
		downlines := array_append(downlines,req_by);
	END IF;
	
	RAISE NOTICE 'downlines: %',downlines;
	
	RETURN downlines;
END
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_get_upline(
	account__id bigint,
	showmyacc boolean DEFAULT true)
    RETURNS bigint[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	rec record;
	ITEM record;
	plcement__id BIGINT[] :='{}';
	continueloop boolean := true;
BEGIN

	-- select sd_get_upline(89);

	while continueloop = true
	loop
		plcement__id := array_append(plcement__id,account__id);
		if ((select privilage_level from user_login where account_id =account__id) = 1 ) then
			continueloop := false;
		else
			select placement_id from user_details where account_id = account__id into account__id;
		end if;
	end loop;

	RETURN plcement__id;
END;	
$BODY$;



CREATE OR REPLACE FUNCTION public.ext_checklimit(
	account__id bigint,
	d_amt double precision,
	purchase_date character varying DEFAULT CURRENT_DATE)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	from_date CHARACTER VARYING;
    to_date CHARACTER VARYING;
    dailydraw_check bigint;
    weeklydraw_check bigint;
BEGIN

	-- SELECT ext_checklimit(56,10000000);
	SELECT date_trunc('week', now() :: TIMESTAMP) :: CHARACTER VARYING INTO from_date;
	SELECT (date_trunc('week', now() :: TIMESTAMP) + INTERVAL '6 DAY') :: CHARACTER VARYING INTO to_date;
	
	select COALESCE(sum(total_damt),0) from booking_tickets where 
						account_id = account__id and p_date = purchase_date 
						and deleted=false into dailydraw_check;

	IF (dailydraw_check + d_amt >= (select daily_limit from user_details where account_id = account__id)) THEN 
		RETURN 'daily limit reached';
	END IF;

	select COALESCE(sum(total_damt),0) from booking_tickets where 
						account_id = account__id and p_date between from_date and to_date
						and deleted=false into weeklydraw_check;

	IF (weeklydraw_check + d_amt >= (select weekly_limit from user_details where account_id = account__id)) THEN
		RETURN 'weekly limit reached';
	END IF;
	
	RETURN '';
END
$BODY$;



CREATE OR REPLACE FUNCTION PUBLIC.SD_BOOKING_TICKET(
	ACCOUNT__ID bigint, 
	DRAWID bigint, 
	C_AMT double precision, 
	D_AMT double precision, 
	T_COUNT bigint, 
	P__DATE CHARACTER varying) 
	RETURNS JSON 
	LANGUAGE 'plpgsql' 
	COST 100 
	VOLATILE PARALLEL UNSAFE 
AS $BODY$
DECLARE
	draw_date CHARACTER VARYING;
	z_rec RECORD;
	new_ticket_id bigint;
	timecontroller record;
	accountcontroller record;
	limitcontroller varchar;
	bookinglist json[] := '{}';
	templist json;
	item bigint;
BEGIN

	--  select sd_booking_ticket(1,3,0,0,0,'null');

	select * from drawconfig where draw_id = drawid into timecontroller;

	IF ((NOW() :: TIME >= timecontroller.draw_start :: TIME) AND (NOW() :: TIME <= timecontroller.draw_end :: TIME)) THEN
		RETURN to_json(concat('{"data":null,"error":"timeup"}'));
	END IF;

	IF p__date != 'null' THEN
		draw_date = p__date;
	ELSEIF NOW() :: TIME <= timecontroller.draw_start :: TIME THEN
		SELECT CURRENT_DATE :: CHARACTER VARYING INTO draw_date;
	ELSE
		SELECT (NOW() + INTERVAL '1 DAY'):: TIMESTAMP :: DATE :: CHARACTER VARYING INTO draw_date;
	END IF;

	SELECT privilage_level,placement_id,user_name,upline_members FROM user_login
		INNER JOIN user_details USING (account_id) where account_id = account__id INTO z_rec;

	FOR item IN select unnest(z_rec.upline_members::bigint[])
	LOOP
		select ext_checklimit(item,d_amt,draw_date) into limitcontroller;

		IF (limitcontroller != '') THEN
			RETURN to_json(concat('{"data":null,"error":your ',limitcontroller,'}'));
		END IF;
	END LOOP;
	
	IF z_rec.upline_members is null then
		z_rec.upline_members := '{}';
		z_rec.upline_members := array_append(z_rec.upline_members,ACCOUNT__ID);
	end if;

	FOR item IN select unnest(z_rec.upline_members::bigint[])
	LOOP
		select user_name from user_login where account_id = item into accountcontroller;
		insert into booking_tickets(account_id,d_name,draw_id,draw_time,p_date,total_count,total_camt,total_damt)
				values(item,accountcontroller.user_name,DRAWID,timecontroller.draw_time,draw_date,t_count,c_amt,d_amt)
				RETURNING booking_id INTO new_ticket_id;
		SELECT json_build_object(item, new_ticket_id) into templist;
		RAISE NOTICE 'JSON : %',templist;
		bookinglist := array_append(bookinglist,templist);
	END LOOP;
	RETURN to_json(concat('{"data":{"ticket_list":',array_to_json(bookinglist),' },"error":null}'));
END
$BODY$;



CREATE OR REPLACE FUNCTION PUBLIC.SD_CREATE_TICKET(
	ACCOUNT__ID bigint, 
	BOOKING__ID bigint, 
	C_TYPE CHARACTER varying, 
	C__NUMBER CHARACTER varying, 
	C__COUNT bigint, 
	C__AMT double precision, 
	D__AMT double precision, 
	DRAW__ID bigint, 
	PURCHASE__DATE CHARACTER varying) 
	RETURNS JSON 
	LANGUAGE 'plpgsql' 
	COST 100 
	VOLATILE PARALLEL UNSAFE 
AS $BODY$
DECLARE
	new_ticket_id bigint;
	purchased_count bigint;
	bill_details record;
	p__date character varying;
	commissioncontroller record;
	timecontroller record;
	countcontroller record;
	accountcontroller int;
	specialcontroller CHARACTER VARYING [];
	z_query CHARACTER VARYING;
	z_column CHARACTER VARYING;
BEGIN

	-- select SD_CREATE_TICKET(91,1,'DEAR','342','34',340,340,null,3,'null');
	
	SELECT * FROM drawconfig WHERE draw_id = DRAW__ID INTO timecontroller;

    IF purchase__date != 'null' THEN
    	p__date := purchase__date;
	ELSEIF NOW() :: TIME <= timecontroller.draw_start :: TIME THEN
		SELECT CURRENT_DATE::character varying INTO p__date;
	ELSE
		SELECT (NOW() + INTERVAL '1 DAY'):: TIMESTAMP :: DATE::character varying INTO p__date;
	END IF;

	SELECT dc_single,dc_double,dc_dear,dc_box FROM user_details WHERE account_id = account__id INTO commissioncontroller;
	SELECT ticket_count::character varying[] FROM manage_ticket WHERE ticket_type = 'special_numbers' INTO specialcontroller;
	SELECT * FROM booking_tickets WHERE booking_id = booking__id INTO bill_details;
	
	

	IF c_type = ANY('{"A","B","C"}') THEN
		z_column := concat('SINGLE_',c_type,'');
		d__amt :=(c__count * commissioncontroller.dc_single);
	ELSEIF c_type = ANY('{"AB","BC","AC"}') THEN
		z_column := concat('DOUBLE_',c_type,'');
		d__amt :=(c__count * commissioncontroller.dc_double);
	ELSEIF c_type ='BOX' THEN
		z_column := concat('TRIPLE_BOX');
		d__amt :=(c__count * commissioncontroller.dc_box);
	ELSE
		IF c__number = ANY(specialcontroller) THEN
			z_column := concat('TRIPLE_SPECIAL');
		ELSE
			z_column := concat('TRIPLE_DEAR');
		END IF;
		d__amt :=(c__count * commissioncontroller.dc_dear);
	END IF;

	INSERT INTO TICKET_TABLE(BOOKING_ID,DRAW_ID,TICKET_TYPE,TICKET_NUMBER,TICKET_COUNT,C_AMT,D_AMT,PURCHASE_DATE)
		VALUES(booking__id,draw__id,c_type,c__number,c__count,c__amt,d__amt,p__date)
		RETURNING ticket_id INTO new_ticket_id;

	UPDATE BOOKING_TICKETS SET TOTAL_COUNT = (bill_details.TOTAL_COUNT + c__count),
								TOTAL_CAMT = ROUND((bill_details.TOTAL_CAMT + c__amt):: numeric, 2),
								TOTAL_DAMT = ROUND((bill_details.TOTAL_DAMT + d__amt):: numeric, 2),
								TICKET_LIST = array_append(bill_details.TICKET_LIST, new_ticket_id)
							WHERE BOOKING_ID = booking__id;

	IF (NOT EXISTS(SELECT * FROM PURCHASE_COUNT WHERE ACCOUNT_ID = account__id AND PURCHASE_DATE = p__date AND DRAW_ID = DRAW__ID)) THEN
		RAISE NOTICE 'IFFFFF';
		INSERT INTO PURCHASE_COUNT(ACCOUNT_ID,PURCHASE_DATE,DRAW_ID) VALUES(account__id,p__date,DRAW__ID);
	END IF;

	z_query := concat('SELECT ',z_column,' FROM PURCHASE_COUNT WHERE ACCOUNT_ID = ',account__id,E' AND PURCHASE_DATE = \'',p__date,E'\' AND DRAW_ID = ',DRAW__ID,'');
	RAISE NOTICE '%',z_query;
	EXECUTE(z_query) INTO purchased_count;
	RAISE NOTICE '%',purchased_count;

	z_query := concat('UPDATE PURCHASE_COUNT SET ',z_column,' = ',(purchased_count + C__COUNT),' WHERE ACCOUNT_ID = ',account__id,E' AND PURCHASE_DATE = \'',p__date,E'\' AND DRAW_ID = ',DRAW__ID,'');
	EXECUTE(z_query);

	RETURN to_json(concat('{"data":{"ticket_id":',new_ticket_id,'},"error":null}'));
END
$BODY$;


CREATE OR REPLACE FUNCTION public.sd_check_ticket_availability(
	ticket__type character varying,
	c__count bigint,
	c__number character varying,
	drawid bigint,
	req_by bigint)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
		vr_query CHARACTER VARYING;
		special CHARACTER VARYING [];
		z_rec RECORD;
		item RECORD;
		draw_date DATE;
		max_ticket_limit bigint;
		upline__admin bigint;
		tickets_count bigint;
		timecontroller record;
		is_sub CHARACTER VARYING:='';
		is_special boolean := false;
BEGIN

	-- select sd_check_ticket_availability('DEAR',2501,'342',3,92);
	select * from drawconfig where draw_id = drawid into timecontroller;

	IF ((NOW() :: TIME >= timecontroller.draw_start :: TIME) AND (NOW() :: TIME <= timecontroller.draw_end :: TIME)) THEN
		RETURN to_json(concat('{"data":null,"error":"timeup"}'));
	END IF;

	IF NOW() :: TIME <= timecontroller.draw_start :: TIME THEN
		SELECT CURRENT_DATE INTO draw_date;
	ELSE 
		SELECT (NOW() + INTERVAL '1 DAY'):: TIMESTAMP :: DATE INTO draw_date;
	END IF;
	
	
	FOR ITEM IN SELECT * FROM BLOCKED_TICKETS WHERE  ENABLED = TRUE
	LOOP
		IF ITEM.TITLE = 'special' THEN
			IF c__number = ANY(ITEM.b_numbers) AND ticket__type = 'BOX' THEN 
				RETURN to_json(concat('{"data":{"count":',c__count,',"type":"',ticket__type,'","number":',c__number,'},"error":null}'));
			END IF;
		END IF;
		IF c__number = ANY(ITEM.b_numbers) THEN
		 	max_ticket_limit := ITEM.MAX_LIMIT;
		END IF;
	END LOOP;
	
	select upline_admin from user_details where account_id = req_by into upline__admin;
	
	IF max_ticket_limit IS NULL THEN
		IF ticket__type = ANY('{A,B,C}') THEN
			vr_query := concat('single_',LOWER(ticket__type),'');
		ELSEIF ticket__type = ANY('{AB,BC,AC}') THEN
			vr_query := concat('double_',LOWER(ticket__type),'');
		ELSEIF ticket__type = ANY('{DEAR,BOX}') THEN
			vr_query := concat('triple_',LOWER(ticket__type),'');
		END IF;
		
		vr_query := concat('select ',vr_query,' from TICKETCONFIG WHERE ACCOUNT_ID = ',upline__admin,' AND DRAW_ID = ',drawid,'');
		EXECUTE(vr_query) INTO max_ticket_limit;
	END IF;
	
	RAISE NOTICE 'max_ticket_limit : %',max_ticket_limit;
	
	SELECT DOWNLINE FROM USER_LOGIN WHERE ACCOUNT_ID = upline__admin INTO ITEM;
	RAISE NOTICE 'ADMIN DOWNLINE : %',ITEM.DOWNLINE;
	-- 	select sd_check_ticket_availability('DEAR','400','976',4,185);

	SELECT (COALESCE(sum(ticket_count),0) + c__count) as total_purchased_count,
	sum(ticket_count) as ticket_count,
	max_ticket_limit - (COALESCE(sum(ticket_count),0) + c__count) as pending_num,
	COALESCE(sum(ticket_count),0) as previous_count
	FROM TICKET_TABLE 
		inner join booking_tickets using(booking_id) 
		where account_id = any(ITEM.DOWNLINE) 
		and ticket_type = ticket__type 
		and TICKET_TABLE.draw_id = drawid 
		and p_date = draw_date::character varying 
		and ticket_number = c__number 
		and booking_tickets.deleted= false
		and TICKET_TABLE.deleted= false INTO ITEM;

	RAISE NOTICE 'ITEM : %',ITEM;

	IF ITEM.total_purchased_count <= max_ticket_limit THEN 
		RETURN to_json(concat('{"data":"true","error":null}'));
	ELSE
		ITEM.pending_num := ABS(ITEM.pending_num);
		IF ITEM.pending_num > c__count THEN
			ITEM.pending_num := c__count;
		END IF;
		RETURN to_json(concat('{"data":{"count":',ITEM.pending_num,',"type":"',ticket__type,'","number":"',c__number,'"},"error":null}'));
	END IF;
END 
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_purchasehistory(
	account__id bigint,
	from_date character varying,
	to_date character varying,
	draw__id integer,
	getall boolean,
	filters character varying,
	req_by bigint,
	agent_rate boolean,
	page_no bigint,
	rows_per_page int)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	downlines bigint[];
	privilage__level int;
	ticketlist json[];
	item RECORD;
	mainlist json [] := '{}';
	temp_array CHARACTER VARYING [];
	overall_data record;
BEGIN

	-- select sd_purchasehistory(56,'2024-01-07','2024-01-07',4,true,'null',56,true,1,50);
	IF filters <> 'null' AND filters <> '' THEN 
		IF filters SIMILAR TO '%(_)%' THEN
			temp_array := string_to_array(filters, '_');
		ELSEIF filters != 'null' AND filters != '' THEN
			temp_array := array_append(temp_array,filters);
		END IF;
	END IF;
	
	SELECT PRIVILAGE_LEVEL FROM USER_LOGIN WHERE ACCOUNT_ID = req_by INTO privilage__level;
	SELECT ext_downlinequery(privilage__level,account__id,req_by,getall,agent_rate) INTO downlines;
	
	IF page_no = 1 THEN
		SELECT round((SUM(COALESCE(C_AMT,0))) :: numeric, 2) AS total_camt,
			   round((SUM(COALESCE(D_AMT,0))) :: numeric, 2) AS total_damt,
			   round((SUM(COALESCE(TICKET_COUNT,0))) :: numeric, 2) AS total_count
				  FROM TICKET_TABLE WHERE BOOKING_ID = ANY(SELECT BOOKING_ID FROM BOOKING_TICKETS 
				  WHERE P_DATE BETWEEN from_date AND to_date 
				  AND ((DRAW__ID IS NOT NULL AND DRAW_ID = DRAW__ID) OR DRAW__ID IS NULL)
				  AND ACCOUNT_ID = ANY(downlines) AND ((privilage__level <> 2 
					OR (ACCOUNT_ID = req_by AND agent_rate = FALSE AND sub_purchased = TRUE)
					OR (ACCOUNT_ID = req_by AND agent_rate = TRUE)OR ACCOUNT_ID <> req_by))
				  AND DELETED= FALSE) 
				  AND ((temp_array IS NOT NULL AND TICKET_TYPE = ANY(temp_array::character varying[])) OR temp_array IS NULL)
				  INTO overall_data;
		
	END IF;
	
    FOR item IN SELECT * FROM BOOKING_TICKETS WHERE P_DATE BETWEEN from_date AND to_date 
				AND ((DRAW__ID IS NOT NULL AND DRAW_ID = DRAW__ID) OR DRAW__ID IS NULL)
				AND ACCOUNT_ID = ANY(downlines) AND DELETED= FALSE 
				AND ((privilage__level <> 2 OR (ACCOUNT_ID = req_by AND agent_rate = FALSE AND sub_purchased = TRUE)
					OR (ACCOUNT_ID = req_by AND agent_rate = TRUE)OR ACCOUNT_ID <> req_by))
				ORDER BY P_DATE ASC
				LIMIT rows_per_page
				OFFSET (page_no - 1) * rows_per_page
    LOOP
		ticketlist := NULL;
		SELECT ARRAY(SELECT row_to_json(tt) FROM (SELECT ticket_id,ticket_type,ticket_number,
			ticket_count,c_amt,d_amt FROM TICKET_TABLE 
			WHERE TICKET_ID = ANY(item.ticket_list::BIGINT[]) AND DELETED = FALSE 
			AND CASE WHEN temp_array IS NULL THEN TRUE 
			ELSE TICKET_TYPE = ANY(temp_array::character varying[]) END) AS tt) INTO ticketlist;
			
			IF array_length(ticketlist, 1) IS NULL OR array_length(ticketlist, 1) = 0 THEN
			ELSE
				mainlist = array_append(mainlist, (SELECT json_build_object(
				'total_c_amt',item.total_camt,
				'total_d_amt',item.total_damt,
				'total_count',item.total_count,
				'bill_id',item.booking_id,
				'dealer_name',item.d_name,
				'customer_name',item.c_name,
				'date',item.p_date,
				'created_at',item.created_at,
				'tickets', array_to_json((COALESCE(ticketlist,'{}'))))));
			END IF;
    END LOOP;
	
	IF page_no = 1 THEN
		RETURN to_json(concat ('{"data":{"history":',array_to_json(mainlist),
							   ',"total_camt":',COALESCE(overall_data.total_camt,0),
							   ',"total_damt":',COALESCE(overall_data.total_damt,0),
							   ',"total_count":',COALESCE(overall_data.total_count,0),
							   '},"error":null}'));
	ELSE
		 RETURN to_json(concat ('{"data":{"history":',array_to_json(mainlist),'},"error":null}'));
	END IF;  
END 
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_topcount(
	account__id bigint,
	from_date character varying,
	to_date character varying,
	draw__id bigint,
	getall boolean,
	filters character varying,
	req_by bigint,
	page_no bigint,
	rows_per_page int)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	downlines bigint[];
	privilage__level int;
	result_json jsonb := jsonb_build_object();
	result_array jsonb;
	nodata json [] := '{}';
begin

	-- 	select sd_topcount(56,'2023-12-30','2023-12-30',4,true,null,56,2,10);
		
	SELECT PRIVILAGE_LEVEL FROM USER_LOGIN WHERE ACCOUNT_ID = req_by INTO privilage__level;
	SELECT ext_downlinequery(privilage__level,account__id,req_by,getall,false) INTO downlines;
	
	IF page_no = 1 THEN
		SELECT jsonb_build_object('total_count',  COALESCE(SUM(TICKET_COUNT), 0),
			'total_camt', COALESCE(SUM(COALESCE(TICKET_TABLE.C_AMT, 0)), 0),
            'total_damt', COALESCE(SUM(COALESCE(TICKET_TABLE.D_AMT, 0)), 0)) INTO result_json
		FROM TICKET_TABLE INNER JOIN BOOKING_TICKETS USING (BOOKING_ID) WHERE TICKET_TABLE.DELETED = FALSE 
		AND BOOKING_TICKETS.DELETED = FALSE AND ACCOUNT_ID = ANY(DOWNLINES)
		AND ((FROM_DATE IS NOT NULL AND TO_DATE IS NOT NULL AND P_DATE BETWEEN FROM_DATE AND TO_DATE) 
			OR(FROM_DATE IS NULL AND TO_DATE IS NULL))
		AND ((FILTERS IS NOT NULL AND LENGTH(TICKET_NUMBER) = FILTERS::INT) OR FILTERS IS NULL)
		AND ((DRAW__ID IS NOT NULL AND BOOKING_TICKETS.DRAW_ID = DRAW__ID) OR DRAW__ID IS NULL);
	END IF;
	
	SELECT COALESCE(jsonb_agg(result_row), '[]'::jsonb)  INTO result_array FROM (
		SELECT jsonb_build_object('ticket_number', TICKET_NUMBER,
            't_count',COALESCE(SUM(COALESCE(TICKET_COUNT,0)),0),
            'c_amt', COALESCE(SUM(COALESCE(TICKET_TABLE.C_AMT, 0)), 0),
            'd_amt', COALESCE(SUM(COALESCE(TICKET_TABLE.D_AMT, 0)), 0),
            'ticket_type', TICKET_TYPE) AS result_row 
		FROM TICKET_TABLE INNER JOIN BOOKING_TICKETS USING (BOOKING_ID)  
		WHERE TICKET_TABLE.DELETED = FALSE 
		AND BOOKING_TICKETS.DELETED = FALSE AND ACCOUNT_ID = ANY(DOWNLINES)
        AND ((FROM_DATE IS NOT NULL AND TO_DATE IS NOT NULL AND P_DATE BETWEEN FROM_DATE AND TO_DATE) 
            OR(FROM_DATE IS NULL AND TO_DATE IS NULL))
        AND ((FILTERS IS NOT NULL AND LENGTH(TICKET_NUMBER) = FILTERS::INT) 
            OR FILTERS IS NULL)
        AND ((DRAW__ID IS NOT NULL AND BOOKING_TICKETS.DRAW_ID = DRAW__ID) OR DRAW__ID IS NULL)
    	GROUP BY TICKET_NUMBER, TICKET_TYPE) AS subquery;
		
	result_json = jsonb_set(result_json, '{history}', result_array);
	
	return to_json(concat('{"data":',result_json,',"error":null}'));
end
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_totalcount(
	account__id bigint,
	from_date character varying,
	to_date character varying,
	draw__id bigint,
	getall boolean,
	req_by bigint)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	downlines bigint[];
	privilage__level int;
 	result_json jsonb;
BEGIN

	-- select sd_totalcount(56,'2023-12-31','2023-12-31',4,true,56);

	SELECT PRIVILAGE_LEVEL FROM USER_LOGIN WHERE ACCOUNT_ID = req_by INTO privilage__level;
	SELECT ext_downlinequery(privilage__level,account__id,req_by,getall,false) INTO downlines;

      SELECT jsonb_build_object(
        'count', COALESCE(SUM(total_count), 0),
        'c_amt', COALESCE(SUM(total_camt), 0),
        'd_amt', COALESCE(SUM(total_damt), 0)) 
		INTO result_json FROM BOOKING_TICKETS WHERE DELETED = FALSE AND ACCOUNT_ID = ANY(DOWNLINES)
        AND ((DRAW__ID IS NOT NULL AND BOOKING_TICKETS.DRAW_ID = DRAW__ID) OR DRAW__ID IS NULL)
        AND ((FROM_DATE IS NOT NULL AND TO_DATE IS NOT NULL AND P_DATE BETWEEN FROM_DATE AND TO_DATE)
        	OR (FROM_DATE IS NULL AND TO_DATE IS NULL));

    RETURN to_json(concat('{"data":',result_json,',"error":null}'));
END 
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_executewinning(
	draw__id bigint,
	draw__date character varying,
	win_num1 character varying,
	win_num2 character varying,
	win_num3 character varying,
	win_num4 character varying,
	win_num5 character varying,
	win_num6 character varying[],
	hidden_update boolean DEFAULT false)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	item RECORD;
	TEMP CHARACTER VARYING[];
	sixthprizeloop CHARACTER VARYING;
	vr_winning_drawid BIGINT;
	commission_amt RECORD;
	vr_num1 CHARACTER VARYING;
	vr_num2 CHARACTER VARYING;
	vr_num3 CHARACTER VARYING;
	vr_draw_date CHARACTER VARYING;
	z_query CHARACTER VARYING;
	issub CHARACTER VARYING;
	box_both_combination CHARACTER VARYING[];
	box_shuffle_combination CHARACTER VARYING[];
	tempp boolean;
	is_winned_checker boolean :=false;
BEGIN

	-- select sd_executewinning(4,'2023-12-31','498','123','','','','{}'::character varying[],false);
	
	IF NOW()::TIME <= (SELECT delete_end FROM drawconfig WHERE draw_id = draw__id)::TIME AND 
   												NOT hidden_update AND draw__date = 'null' THEN
    	RETURN '{"data": null, "error": "Unable to Execute Winning Before Draw is Blocked"}'::JSON;
	END IF;
	
	-- assign draw date
	vr_draw_date := COALESCE(NULLIF(draw__date, 'null')::date, CURRENT_DATE)::character varying;
	
	SELECT s_id FROM WINNING_HISTORY WHERE DRAW_DATE = vr_draw_date AND DRAW_ID = draw__id INTO vr_winning_drawid;

	IF vr_winning_drawid IS NULL THEN
		INSERT INTO winning_history (draw_id, draw_date, winning_1, winning_2, winning_3, winning_4, winning_5, winning_6) 
		VALUES (draw__id, vr_draw_date, win_num1, win_num2, win_num3, win_num4, win_num5, win_num6);
	ELSE
		UPDATE winning_history SET winning_1 = win_num1,winning_2 = win_num2,
			winning_3 = win_num3,winning_4 = win_num4, winning_5 = win_num5, 
			winning_6 = win_num6, updated_at = CURRENT_TIMESTAMP WHERE s_id = vr_winning_drawid;
	END IF;
	
	delete from winners where ticket_id in ((select ticket_id from tickets where purchase_date=vr_draw_date AND draw_id=draw__id));
	

	vr_num1 := LEFT(win_num1,1);
	vr_num2 := RIGHT((LEFT(win_num1,2))::character varying,1);
	vr_num3 := RIGHT(win_num1,1);
	
	box_shuffle_combination:= array_append(box_shuffle_combination,(concat('',vr_num1,'',vr_num2,'',vr_num3,''))::CHARACTER VARYING);
	box_shuffle_combination:= array_append(box_shuffle_combination,(concat('',vr_num1,'',vr_num3,'',vr_num2,''))::CHARACTER VARYING);
	box_shuffle_combination:= array_append(box_shuffle_combination,(concat('',vr_num2,'',vr_num1,'',vr_num3,''))::CHARACTER VARYING);
	box_shuffle_combination:= array_append(box_shuffle_combination,(concat('',vr_num2,'',vr_num3,'',vr_num1,''))::CHARACTER VARYING);
	box_shuffle_combination:= array_append(box_shuffle_combination,(concat('',vr_num3,'',vr_num1,'',vr_num2,''))::CHARACTER VARYING);
	box_shuffle_combination:= array_append(box_shuffle_combination,(concat('',vr_num3,'',vr_num2,'',vr_num1,''))::CHARACTER VARYING);
 	
	SELECT ARRAY(SELECT DISTINCT UNNEST(box_shuffle_combination::CHARACTER VARYING[]))::CHARACTER VARYING[] into box_both_combination;

	FOR item IN SELECT BOOKING_TICKETS.BOOKING_ID,TICKET_TABLE.TICKET_ID,TICKET_TABLE.TICKET_TYPE,TICKET_NUMBER,
					TICKET_COUNT,ACCOUNT_ID FROM TICKET_TABLE 
					INNER JOIN BOOKING_TICKETS USING (BOOKING_ID) WHERE P_DATE = vr_draw_date::character varying 
					AND BOOKING_TICKETS.DRAW_ID = draw__id AND TICKET_TABLE.DELETED = FALSE AND BOOKING_TICKETS.DELETED = FALSE
	LOOP
		is_winned_checker := false;
		SELECT * FROM USER_DETAILS WHERE ACCOUNT_ID = item.ACCOUNT_ID INTO commission_amt;
			
		IF LOWER(item.TICKET_TYPE) = LOWER('DEAR') THEN
			IF win_num1 = item.TICKET_NUMBER THEN
				is_winned_checker := true;
				select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'1',
					(item.TICKET_COUNT * commission_amt.wp_dear_1),
					(item.TICKET_COUNT * commission_amt.wc_dear_1)) into tempp;
				CONTINUE; 
			END IF;
			IF win_num2 = item.TICKET_NUMBER THEN
				is_winned_checker := true;
				select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'2',
					(item.TICKET_COUNT * commission_amt.wp_dear_2),
					(item.TICKET_COUNT * commission_amt.wc_dear_2)) into tempp;	
				CONTINUE;
			END IF;
			IF win_num3 = item.TICKET_NUMBER THEN
				is_winned_checker := true;
				select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'3',
					(item.TICKET_COUNT * commission_amt.wp_dear_3),
					(item.TICKET_COUNT * commission_amt.wc_dear_3)) into tempp;	
				CONTINUE;
			END IF;
			IF win_num4 = item.TICKET_NUMBER THEN
				is_winned_checker := true;
				select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'4',
					(item.TICKET_COUNT * commission_amt.wp_dear_4),
					(item.TICKET_COUNT * commission_amt.wc_dear_4)) into tempp;
				CONTINUE;
			END IF;
			IF win_num5 = item.TICKET_NUMBER THEN
				is_winned_checker := true;
				select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'5',
					(item.TICKET_COUNT * commission_amt.wp_dear_5),
					(item.TICKET_COUNT * commission_amt.wc_dear_5)) into tempp;	
				CONTINUE;
			END IF;
	
			IF item.TICKET_NUMBER = ANY(win_num6) THEN
				is_winned_checker := true;
				SELECT sd_winning_entry(item.BOOKING_ID, item.TICKET_ID, '6',
					(item.TICKET_COUNT * commission_amt.wp_dear_6),
					(item.TICKET_COUNT * commission_amt.wc_dear_6))
				INTO tempp;
				CONTINUE;
			END IF;
		ELSEIF (LOWER(item.TICKET_TYPE) = ANY('{"a","b","c"}')) THEN
			vr_num1 := LEFT(win_num1,1);
			vr_num2 :=RIGHT((LEFT(win_num1,2))::character varying,1);
			vr_num3 :=RIGHT(win_num1,1);
			
			IF ((item.TICKET_TYPE='A') AND (vr_num1 = item.TICKET_NUMBER)) 
			OR ((item.TICKET_TYPE='B') AND (vr_num2 = item.TICKET_NUMBER)) 
			OR ((item.TICKET_TYPE='C') AND (vr_num3 = item.TICKET_NUMBER)) THEN
				is_winned_checker := true;
				select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'1',
					(item.TICKET_COUNT * commission_amt.wp_single_1),
					(item.TICKET_COUNT * commission_amt.wc_single_1)) into tempp;
				CONTINUE;
			END IF;
		ELSEIF (LOWER(item.TICKET_TYPE) = ANY('{"ab","bc","ac"}')) THEN
			vr_num1 := LEFT(win_num1,2);
			vr_num2 := RIGHT(win_num1,2);
			vr_num3 :=concat('',LEFT(win_num1,1),'',RIGHT(win_num1,1),'' );
			
			IF ((item.TICKET_TYPE='AB') AND (vr_num1 = item.TICKET_NUMBER)) 
			OR ((item.TICKET_TYPE='BC') AND (vr_num2 = item.TICKET_NUMBER)) 
			OR ((item.TICKET_TYPE='AC') AND (vr_num3 = item.TICKET_NUMBER)) THEN
				is_winned_checker := true;
				select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'1',
					(item.TICKET_COUNT * commission_amt.wp_double_1),
					(item.TICKET_COUNT * commission_amt.wc_double_1)) into tempp;	
				CONTINUE;
			END IF;			
		ELSEIF (LOWER(item.TICKET_TYPE) = LOWER('BOX')) THEN
			vr_num1 := LEFT(win_num1,1);
			vr_num2 :=RIGHT((LEFT(win_num1,2))::character varying,1);
			vr_num3 :=RIGHT(win_num1,1);

			IF vr_num1 = vr_num2 AND vr_num2 = vr_num3 AND vr_num3 = vr_num1  THEN
				IF win_num1 = item.TICKET_NUMBER THEN
					is_winned_checker := true;
					 select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'1',
						(item.TICKET_COUNT * commission_amt.wp_box_same1),
						(item.TICKET_COUNT * commission_amt.wc_box_same1)) into tempp;
					CONTINUE;
				END IF;
			RAISE NOTICE 'BOX THREE NUMBER MATCH FOUND!';
			ELSEIF vr_num1 = vr_num2 OR vr_num2 = vr_num3 OR vr_num3 = vr_num1  THEN
				IF win_num1 = item.TICKET_NUMBER THEN
					is_winned_checker := true;
					select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'1',
						(item.TICKET_COUNT * commission_amt.wp_box_both1),
						(item.TICKET_COUNT * commission_amt.wc_box_both1)) into tempp;
					CONTINUE;
				ELSEIF item.TICKET_NUMBER = ANY(box_both_combination) THEN
					is_winned_checker := true;
					select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'2',
						(item.TICKET_COUNT * commission_amt.wp_box_both2),
						(item.TICKET_COUNT * commission_amt.wc_box_both2)) into tempp;
					CONTINUE;
				END IF;
			RAISE NOTICE 'BOX TWO NUMBER MATCH FOUND!';
			ELSE
				IF win_num1 = item.TICKET_NUMBER THEN
					is_winned_checker := true;
					select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'1',
						(item.TICKET_COUNT * commission_amt.wp_box_shuffle1),
						(item.TICKET_COUNT * commission_amt.wc_box_shuffle1)) into tempp;
					CONTINUE;
				ELSEIF item.TICKET_NUMBER = ANY(box_shuffle_combination) THEN
					is_winned_checker := true;
					select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'1',
						(item.TICKET_COUNT * commission_amt.wp_box_shuffle2),
						(item.TICKET_COUNT * commission_amt.wc_box_shuffle2)) into tempp;
					CONTINUE;
				END IF;
				RAISE NOTICE 'BOX NO SAME NUMBER MATCH FOUND!';
			END IF;
		END IF;
		IF is_winned_checker = false THEN
			RAISE NOTICE 'BOOKING_ID %',item.BOOKING_ID;
			RAISE NOTICE 'TICKET_ID %',item.TICKET_ID;
			select sd_winning_entry(item.BOOKING_ID,item.TICKET_ID,'',0,0,false) into tempp;
		END IF;
	END LOOP;
	
	RETURN to_json(concat('{"data":"draw_completed","error":null}'));
END;
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_winning_entry(
	booking__id bigint,
	ticket__id bigint,
	winning__rank character varying,
	winning__prize numeric,
	winning__commission numeric,
	is__winned boolean DEFAULT TRUE)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
	if is__winned = TRUE then
		raise notice '------------ winning_found----------   ticket__id----->% ',ticket__id;
		INSERT INTO WINNERS (BOOKING_ID,TICKET_ID,WINNING_RANK,WINNING_PRIZE,WINNING_COMMISSION) 
			VALUES(BOOKING__ID,TICKET__ID,WINNING__RANK,WINNING__PRIZE,WINNING__COMMISSION);
	end if;
	raise notice '------------ winning_not_found----------   ticket__id----->% ',ticket__id;
	UPDATE BOOKING_TICKETS SET WINNING_EXECUTED = TRUE WHERE BOOKING_ID = BOOKING__ID;
	
	UPDATE TICKET_TABLE SET WINNING_EXECUTED = TRUE AND WINNED = IS__WINNED WHERE TICKET_ID = TICKET__ID;
	return true;
END;
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_dailyreport(
	account__id bigint,
	from_date character varying,
	to_date character varying,
	draw__id integer,
	getall boolean,
	filters json,
	req_by bigint,
	agent_rate boolean)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	downlines bigint[];
	privilage__level int;
    json_result JSONB;
    grand_totals_result JSONB;
begin

	--  select sd_dailyreport(56,'2023-12-31','2023-12-31',4,true,null,56,false);
	
	SELECT PRIVILAGE_LEVEL FROM USER_LOGIN WHERE ACCOUNT_ID = req_by INTO privilage__level;
	SELECT ext_downlinequery(privilage__level,account__id,req_by,getall,agent_rate) INTO downlines;
	
	CREATE TEMPORARY TABLE temp_result_set AS ( SELECT
            COALESCE(SUM(T1.C_AMT), 0) AS c_amt, COALESCE(SUM(T1.D_AMT), 0) AS d_amt,
            COALESCE(SUM(T1.WINNING_PRIZE), 0) AS winning_prize, COALESCE(SUM(T1.WINNING_COMMISSION), 0) AS winning_commission,
            T1.USER_NAME AS username FROM (SELECT ACCOUNT_ID,
                D_NAME AS USER_NAME,TICKET_COUNT,TICKET_TABLE.C_AMT,TICKET_TABLE.D_AMT,TICKET_TABLE.DRAW_ID,
                WINNING_DATA.WINNING_COMMISSION,WINNING_DATA.WINNING_PRIZE,P_DATE FROM BOOKING_TICKETS
            INNER JOIN TICKET_TABLE USING (BOOKING_ID) LEFT JOIN (
                SELECT TICKET_ID, COALESCE(SUM(winning_commission), 0) AS WINNING_COMMISSION,
                COALESCE(SUM(winning_prize), 0) AS WINNING_PRIZE FROM WINNERS GROUP BY TICKET_ID
            ) AS WINNING_DATA ON TICKET_TABLE.TICKET_ID = WINNING_DATA.TICKET_ID
        WHERE P_DATE BETWEEN FROM_DATE AND TO_DATE AND ACCOUNT_ID = ANY(downlines)
        AND ACCOUNT_ID = ANY(downlines)
        AND ((DRAW__ID IS NOT NULL AND BOOKING_TICKETS.DRAW_ID = DRAW__ID) OR DRAW__ID IS NULL)
        AND TICKET_TABLE.DELETED = FALSE AND BOOKING_TICKETS.DELETED = FALSE) AS T1
        GROUP BY T1.USER_NAME ORDER BY T1.USER_NAME DESC);

    SELECT JSONB_AGG(
        JSONB_BUILD_OBJECT(
            'c_amt', c_amt::numeric,
            'd_amt', d_amt::numeric,
			'sales',(c_amt::numeric - d_amt::numeric),
            'winning_prize', winning_prize::numeric,
            'winning_commission', winning_commission::numeric,
            'dc_prize', winning_prize + winning_commission,
            'total',(c_amt+d_amt) - (winning_prize+winning_commission),
            'username', username
        )
    ) INTO json_result FROM temp_result_set;
    
    SELECT JSONB_BUILD_OBJECT(
            'grand_c_amt', grand_c_amt::numeric,
            'grand_d_amt', grand_d_amt::numeric,
            'grand_winning_prize', grand_winning_prize::numeric,
            'grand_winning_commission', grand_winning_commission::numeric,
            'grand_dc_prize', grand_dc_prize::numeric,
            'grand_sales', grand_sales::numeric,
            'grand_total', grand_total::numeric
        ) INTO grand_totals_result FROM (
        SELECT
            COALESCE(SUM(c_amt), 0) AS grand_c_amt,
            COALESCE(SUM(d_amt), 0) AS grand_d_amt,
            COALESCE(SUM(winning_prize), 0) AS grand_winning_prize,
            COALESCE(SUM(winning_commission), 0) AS grand_winning_commission,
            COALESCE((SUM(winning_prize) + SUM(winning_commission)), 0) AS grand_dc_prize,
            COALESCE((SUM(c_amt) - SUM(d_amt)), 0) AS grand_sales,
            COALESCE(((SUM(c_amt)+SUM(d_amt)) - (SUM(winning_prize)+SUM(winning_commission))),0) AS grand_total
        FROM temp_result_set) AS grand_totals_result1;

    DROP TABLE IF EXISTS temp_result_set;

	return to_json(concat ('{"data":{"history":',COALESCE(json_result,'[]')
						   ,',"sumofval":',grand_totals_result,'},"error":null}'));
end
$BODY$; 



CREATE OR REPLACE FUNCTION public.sd_deletebill(
	account__id bigint,
	bill__id bigint,
	ticket__id bigint
)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	Z_REC record;
	Z_DRAW CHARACTER VARYING;
	PRIVILAGE__LEVEL INT;
	DOWNLINES BIGINT[];
begin

	-- select sd_deletebill(187,204,null);

	IF bill__id IS NULL THEN
		RETURN to_json(concat('{"data":null,"error":"bill_id delete not implemented"}'));
	END IF;
	
	SELECT * FROM BOOKING_TICKETS INNER JOIN TICKET_TABLE 
				USING (BOOKING_ID) WHERE BOOKING_ID = bill__id INTO Z_REC;
	
	
	IF z_rec IS NULL THEN
  		RETURN to_json(concat('{"data":null,"error":"BILL NOT FOUND!"}'));
	END IF;
	
	SELECT PRIVILAGE_LEVEL,DOWNLINE FROM USER_LOGIN WHERE ACCOUNT_ID = ACCOUNT__ID INTO PRIVILAGE__LEVEL,DOWNLINES;
	SELECT DELETE_END FROM DRAWCONFIG WHERE DRAW_ID = Z_REC.DRAW_ID INTO Z_DRAW;
	
	IF NOT((PRIVILAGE__LEVEL) = ANY('{0,1}')) THEN
		IF ((now()::date != z_rec.p_date::date) or (now()::time >= Z_DRAW::time)) THEN
			RETURN to_json(concat('{"data":null,"error":"DELETE LOCKED... TIMES UP!"}'));
		END IF;
	END IF;
	
	RAISE NOTICE 'PRIVILAGE__LEVEL : %',PRIVILAGE__LEVEL;
	
	IF PRIVILAGE__LEVEL = 2 THEN
		DOWNLINES := ARRAY_APPEND(DOWNLINES,ACCOUNT__ID);
		IF NOT(Z_REC.ACCOUNT_ID = ANY(DOWNLINES)) THEN
			RETURN to_json(concat('{"data":null,"error":"YOU HAVE NO PRIVILAGE TO DELETE"}'));
		END IF;
	ELSEIF PRIVILAGE__LEVEL = 3 AND Z_REC.ACCOUNT_ID <> ACCOUNT__ID THEN
		RETURN to_json(concat('{"data":null,"error":"YOU HAVE NO PRIVILAGE TO DELETE"}'));
	END IF;
	
	INSERT INTO DELETE_HISTORY(ACCOUNT_ID,BOOKING_ID) VALUES(ACCOUNT__ID,BILL__ID);
	
	UPDATE TICKET_TABLE SET DELETED = TRUE WHERE BOOKING_ID = ANY(Z_REC.TICKET_MAP_LIST);
	UPDATE BOOKING_TICKETS SET DELETED = TRUE WHERE BOOKING_ID = ANY(Z_REC.TICKET_MAP_LIST);

	return to_json(concat('{"data":{"msg":"Bill deleted successfully"},"error":null}'));
end
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_winninghistory(
	account__id bigint,
	from_date character varying,
	to_date character varying,
	draw__id integer,
	getall boolean,
	filters json,
	req_by bigint,
	agent_rate boolean)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	vr_ticketmap json;
    z_output json;
	downlines bigint[];
	privilage__level int;
BEGIN
	-- select sd_winninghistory(56,'2023-12-31','2023-12-31',4,true,null,56,false);
	-- select sd_winninghistory(56,'2022-09-15','2022-09-15',1,true,'{"type":"DEAR","number":"034"}'::json,56,false);
	
	SELECT PRIVILAGE_LEVEL FROM USER_LOGIN WHERE ACCOUNT_ID = req_by INTO privilage__level;
	SELECT ext_downlinequery(privilage__level,account__id,req_by,getall,agent_rate) INTO downlines;
	
	CREATE TEMPORARY TABLE temp_winning_set AS(
		SELECT TICKET_TYPE,SUM(TICKET_COUNT) AS count,WINNING_RANK AS rank,SUM(WINNING_PRIZE) AS winned_prize,
		SUM(WINNING_COMMISSION) AS commission,TICKET_NUMBER AS number,P_DATE,
		COALESCE(SUM(WINNING_PRIZE),0) + COALESCE(SUM(WINNING_COMMISSION),0) AS total 
		FROM WINNERS INNER JOIN TICKET_TABLE USING(TICKET_ID) INNER JOIN BOOKING_TICKETS 
		ON BOOKING_TICKETS.BOOKING_ID = TICKET_TABLE.BOOKING_ID
			WHERE P_DATE BETWEEN FROM_DATE AND TO_DATE AND ACCOUNT_ID = ANY(downlines)
			AND BOOKING_TICKETS.DELETED = FALSE AND TICKET_TABLE.DELETED = FALSE AND WINNED = TRUE 
			AND BOOKING_TICKETS.WINNING_EXECUTED = TRUE AND TICKET_TABLE.WINNING_EXECUTED = TRUE
			AND ((FILTERS IS NOT NULL AND TICKET_NUMBER = filters->>('number') 
				  AND TICKET_TYPE = filters->>('type')) OR FILTERS IS NULL) 
			AND ((DRAW__ID IS NOT NULL AND BOOKING_TICKETS.DRAW_ID = DRAW__ID) OR DRAW__ID IS NULL)
			GROUP BY TICKET_TYPE,WINNING_RANK,TICKET_NUMBER,BOOKING_TICKETS.P_DATE
			ORDER BY LENGTH(TICKET_TYPE) DESC,TICKET_TYPE DESC,P_DATE DESC,WINNING_RANK DESC);
			
	SELECT JSON_AGG(t) FROM(
		SELECT * FROM temp_winning_set
	)t INTO vr_ticketmap;
	
	SELECT ROW_TO_JSON(t) FROM(
		SELECT COALESCE(SUM(WINNED_PRIZE),0) AS total_winning_prize, 
		COALESCE(SUM(COMMISSION),0) AS total_commission,
		COALESCE(SUM(WINNED_PRIZE),0) + COALESCE(SUM(COMMISSION),0) AS grant_total,
		COALESCE(SUM(COUNT),0) AS total_count
		FROM temp_winning_set
	)t INTO z_output;

	DROP TABLE IF EXISTS temp_winning_set;
	
	return to_json(concat ('{"data":{"history":',COALESCE(vr_ticketmap,'[]'),',"grand_values":',z_output,'},"error":null}'));
END
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_time_manage(
	draw__id integer,
	account__id bigint,
	event__name character varying,
	event__time character varying,
	is__edit boolean)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	z_data json;
	z_rec record;
	z_query character varying;
begin
	-- select sd_time_manage(1,56,'draw_end','12:52:00',true);
	-- select sd_time_manage(1,56,'draw_end','22:59:59',false);
	
	IF (SELECT PRIVILAGE_LEVEL FROM USER_LOGIN WHERE ACCOUNT_ID = account__id) != 1 THEN
		RETURN to_json(concat('{"data":null,"error":"NOT ENOUGH PRIVILAGE TO EDIT"}'));
	END IF;

	IF is__edit IS TRUE THEN
		z_query := CONCAT('UPDATE DRAWCONFIG set ',event__name,E' = \'',event__time,E'\' WHERE DRAW_ID = ',draw__id,'');
		EXECUTE(z_query);
		
		z_query := CONCAT('SELECT ',event__name,' FROM DRAWCONFIG WHERE DRAW_ID = ',draw__id,'');
		EXECUTE(z_query) INTO z_rec;
		
		INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
			VALUES(account__id,'All','TIME',CONCAT('',event__name,' : ',z_rec,''),event__time);
		return to_json(concat('{"data":"Update Success","error":null}'));
	ELSE
		SELECT JSON_AGG(t) FROM( SELECT DRAW_START,DELETE_END,DRAW_END FROM DRAWCONFIG 
				WHERE DRAW_ID = DRAW__ID AND ISDELETED = FALSE )t INTO Z_DATA;

		return to_json(concat('{"data":',to_json(z_data),',"error":null}'));
	END IF;
end
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_ticket_manage(
	draw__id integer,
	account__id bigint,
	column__name character varying,
	column__value bigint,
	is__edit boolean)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	z_data json;
	z_rec record;
	z_query character varying;
BEGIN
	-- select sd_ticket_manage(1,56,'single_a',2001,true);

	IF (SELECT PRIVILAGE_LEVEL FROM USER_LOGIN WHERE ACCOUNT_ID = account__id) != 1 THEN
		RETURN to_json(concat('{"data":null,"error":"NOT ENOUGH PRIVILAGE TO EDIT"}'));
	END IF;
	
	IF is__edit IS TRUE THEN
		z_query := CONCAT('SELECT ',column__name,' FROM TICKETCONFIG WHERE ACCOUNT_ID = ',account__id,' AND DRAW_ID = ',draw__id,'');
		EXECUTE(z_query) INTO z_rec;

		z_query = concat('UPDATE TICKETCONFIG SET ',column__name,' = ',column__value,' WHERE ACCOUNT_ID = ',account__id,' AND DRAW_ID = ',draw__id,'');
		execute(z_query);

		INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
			VALUES(account__id,'UNDER','TICKET COUNT',CONCAT('',column__name,' : ',z_rec,''),column__value);
		return to_json(concat('{"data":"Update Success","error":null}'));
		return to_json(concat('{"data":"SUCCESSFULLY UPDATED...","error":null}'));
	ELSE
		SELECT JSON_AGG(t) FROM (SELECT * FROM TICKETCONFIG WHERE ACCOUNT_ID = account__id AND DRAW_ID = draw__id)t INTO z_data;
		return to_json(concat('{"data":',to_json(z_data),',"error":null}'));
	END IF;
END
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_get_admincount(
	account__id bigint,
	from_date character varying,
	to_date character varying,
	draw__id bigint,
	getall boolean,
	req_by bigint)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	z_commission RECORD;
	z_data1 jsonb;
	DOWNLINES bigint[];
	privilage__level int;
	result_json jsonb := '{}';
BEGIN

	-- select sd_get_admincount(187,'2024-01-06','2024-01-07',null,true,'56');

	SELECT DC_SINGLE,DC_DOUBLE,DC_DEAR,DC_BOX FROM USER_DETAILS WHERE ACCOUNT_ID = ACCOUNT__ID INTO Z_COMMISSION;
	SELECT PRIVILAGE_LEVEL FROM USER_LOGIN WHERE ACCOUNT_ID = req_by INTO privilage__level;
	SELECT ext_downlinequery(privilage__level,account__id,req_by,getall,false) INTO DOWNLINES;
	
	SELECT TO_JSON(t) FROM
	(SELECT COALESCE(SUM(TICKET_COUNT),0) AS total_count, COALESCE(SUM(C_AMT),0) AS c_amt,
	 	COALESCE((SUM(TICKET_COUNT) * Z_COMMISSION.DC_SINGLE),0) AS d_amt 
		FROM TICKET_TABLE INNER JOIN BOOKING_TICKETS USING (BOOKING_ID) WHERE TICKET_TYPE = ANY('{A,B,C}')
		AND ACCOUNT_ID = ANY(DOWNLINES) AND TICKET_TABLE.DELETED = FALSE AND BOOKING_TICKETS.DELETED = FALSE
		AND ((DRAW__ID IS NOT NULL AND BOOKING_TICKETS.DRAW_ID = DRAW__ID) OR DRAW__ID IS NULL)
		AND P_DATE BETWEEN FROM_DATE AND TO_DATE)t INTO z_data1;
		
	result_json = jsonb_set(result_json, '{single}', z_data1);
	
	SELECT TO_JSON(t) FROM
		(SELECT COALESCE(SUM(TICKET_COUNT),0) AS total_count, COALESCE(SUM(C_AMT),0) AS c_amt,
	 	COALESCE((SUM(TICKET_COUNT) * Z_COMMISSION.DC_SINGLE),0) AS d_amt 
		FROM TICKET_TABLE INNER JOIN BOOKING_TICKETS USING (BOOKING_ID) WHERE TICKET_TYPE = ANY('{AB,BC,AC}')
		AND ACCOUNT_ID = ANY(DOWNLINES) AND TICKET_TABLE.DELETED = FALSE AND BOOKING_TICKETS.DELETED = FALSE
		AND ((DRAW__ID IS NOT NULL AND BOOKING_TICKETS.DRAW_ID = DRAW__ID) OR DRAW__ID IS NULL)
		AND P_DATE BETWEEN FROM_DATE AND TO_DATE)t INTO z_data1;
		
	result_json = jsonb_set(result_json, '{double}', z_data1);
	
	SELECT TO_JSON(t) FROM
		(SELECT COALESCE(SUM(TICKET_COUNT),0) AS total_count, COALESCE(SUM(C_AMT),0) AS c_amt,
	 	COALESCE((SUM(TICKET_COUNT) * Z_COMMISSION.DC_SINGLE),0) AS d_amt 
		FROM TICKET_TABLE INNER JOIN BOOKING_TICKETS USING (BOOKING_ID) WHERE TICKET_TYPE = ANY('{DEAR}')
		AND ACCOUNT_ID = ANY(DOWNLINES) AND TICKET_TABLE.DELETED = FALSE AND BOOKING_TICKETS.DELETED = FALSE
		AND ((DRAW__ID IS NOT NULL AND BOOKING_TICKETS.DRAW_ID = DRAW__ID) OR DRAW__ID IS NULL)
		AND P_DATE BETWEEN FROM_DATE AND TO_DATE)t INTO z_data1;
		
	result_json = jsonb_set(result_json, '{triple_dear}', z_data1);
	
	SELECT TO_JSON(t) FROM
		(SELECT COALESCE(SUM(TICKET_COUNT),0) AS total_count, COALESCE(SUM(C_AMT),0) AS c_amt,
	 	COALESCE((SUM(TICKET_COUNT) * Z_COMMISSION.DC_SINGLE),0) AS d_amt 
		FROM TICKET_TABLE INNER JOIN BOOKING_TICKETS USING (BOOKING_ID) WHERE TICKET_TYPE = ANY('{BOX}')
		AND ACCOUNT_ID = ANY(DOWNLINES) AND TICKET_TABLE.DELETED = FALSE AND BOOKING_TICKETS.DELETED = FALSE
		AND ((DRAW__ID IS NOT NULL AND BOOKING_TICKETS.DRAW_ID = DRAW__ID) OR DRAW__ID IS NULL)
		AND P_DATE BETWEEN FROM_DATE AND TO_DATE)t INTO z_data1;
		
	result_json = jsonb_set(result_json, '{triple_box}', z_data1);
	result_json = jsonb_set(result_json, '{values}', to_json(Z_COMMISSION)::jsonb);
	
    RETURN to_json(concat('{"data":',to_json(result_json),',"error":null}'));
END 
$BODY$;



CREATE OR REPLACE FUNCTION public.lg_updateaccount(
	account__id bigint,
	pass_word character varying,
	privilage__level int,
	daily__limit bigint,
	weekly__limit bigint,
	updated_by bigint,
	block boolean DEFAULT false)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	rec int;
	z_record record;
	z_item bigint;
BEGIN 
	-- SELECT lg_updateaccount(187,'null',null,100000,1000000,56,false);
	
    IF EXISTS(SELECT account_id FROM user_login WHERE account_id = account__id) IS NULL THEN
	       RETURN to_json(concat('{"data":null,"error":"username not found"}'));
    END IF;
	
	IF updated_by = account__id THEN 
		RETURN to_json(concat(E'{"data":null,"error":"you cant edit your own details"}'));
	END IF;
	
	SELECT privilage_level FROM user_login WHERE account_id = updated_by INTO rec;
	SELECT * FROM user_login INNER JOIN USER_DETAILS USING(ACCOUNT_ID) WHERE account_id = account__id INTO z_record;

	IF rec = 3 THEN 
		RETURN to_json(concat('{"data":null,"error":"Edit Account Access Restricted"}'));
	END IF;
	
	IF rec = 2  AND privilage__level = 1 THEN 
		RETURN to_json(concat('{"data":null,"error":"Sub Admin not enough privilage to edit"}'));
	END IF;

	IF pass_word != 'null' THEN
		update user_login set user_password =md5(pass_word) where account_id=account__id;
		INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
				VALUES(updated_by,account__id,'PROFILE - PASSWORD','',pass_word);
	END IF;

	IF privilage__level IS NOT NULL THEN
		update user_login set privilage_level = privilage__level where account_id=account__id;
		INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
			VALUES(updated_by,account__id,'PROFILE - PRIVILAGE_LEVEL',
				   z_record.privilage_level::CHARACTER VARYING,privilage__level::CHARACTER VARYING);
	END IF;

	IF block IS NOT NULL THEN
		if z_record.privilage_level = 2 then
			for z_item in select account_id from user_details where upline_members && z_record.downline::bigint[]
			loop
				raise notice '%',z_item;
				update user_login set user_disabled =block where account_id=z_item;
				INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
					VALUES(account__id,z_item,'PROFILE - BLOCK - SUBBLOCKED SO BELOW USER BLOCK','',block::CHARACTER VARYING);
				
			end loop;
		end if;
		update user_login set user_disabled = block where account_id=account__id;
		INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
			VALUES(updated_by,account__id,'PROFILE - BLOCK', z_record.user_disabled::CHARACTER VARYING,block::CHARACTER VARYING);
	END IF;

	IF daily__limit IS NOT NULL THEN
		update user_details set daily_limit =daily__limit where account_id=account__id;
		INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
			VALUES(updated_by,account__id,'PROFILE - DAILY_LIMIT', 
				   z_record.daily_limit::CHARACTER VARYING,daily__limit::CHARACTER VARYING);
	END IF;

	IF weekly__limit IS NOT NULL THEN
		update user_details set weekly_limit =weekly__limit where account_id=account__id;
		INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
			VALUES(updated_by,account__id,'PROFILE - WEEKLY_LIMIT', 
				   z_record.weekly_limit::CHARACTER VARYING,weekly__limit::CHARACTER VARYING);
	END IF;

	update user_login set updated_at =current_timestamp where account_id=account__id;
	RETURN to_json(concat('{"data":"success","error":null}'));
END;
$BODY$;



CREATE OR REPLACE FUNCTION public.lg_createaccount(
    user__name character varying,
    pass_word character varying,
    privilage int,
    daily__limit bigint,
    weekly__limit bigint,
	created_by bigint) 
	RETURNS json 
	LANGUAGE 'plpgsql' 
	COST 100 
	VOLATILE PARALLEL UNSAFE 
AS $BODY$ 
DECLARE 
    new_account_id BIGINT;
    z_rec record;
    z_downline bigint [];
	PLACEMENT__ID BIGINT = 0;
	ITEM1 RECORD;
    UPLINE BIGINT[] := '{}';
BEGIN

	-- SELECT lg_createaccount('test2','111',1,1000,2000,185);
	
    SELECT privilage_level, downline,user_disabled FROM user_login WHERE account_id = created_by INTO z_rec;
	
	IF z_rec.user_disabled = true THEN
		RETURN to_json(concat('{"data":null,"error":"your User Account Disabled"}'));
	END IF;
	
	IF z_rec.privilage_level = 3 THEN
		RETURN to_json(concat('{"data":null,"error":"Admin or subadmin only can create account"}'));
	END IF;
	
	-- IF z_rec.privilage_level != 1 AND privilage <= z_rec.privilage_level  THEN
	-- 	RETURN to_json(concat('{"data":null,"error":"SubAdmin cant Create Another Admin"}'));
	-- END IF;
	
	IF exists(SELECT account_id FROM user_login WHERE user_name = user__name) = true THEN
		RETURN to_json(concat('{"data":null,"error":"User Already Exist"}'));
	END IF;

	INSERT INTO user_login(user_name,user_password,privilage_level,created_at)
		VALUES(user__name,md5(pass_word),privilage,CURRENT_TIMESTAMP) 
		returning account_id INTO new_account_id;
		
	UPLINE := '{}';
	UPLINE := array_append(UPLINE, new_account_id);
	PLACEMENT__ID = created_by;
	IF PLACEMENT__ID != 0 and ((select privilage_level from user_login where account_id = PLACEMENT__ID) != 1) THEN
		UPLINE := array_append(UPLINE, PLACEMENT__ID);
	END IF;
	WHILE PLACEMENT__ID != 0 LOOP
		select placement_id from user_details where account_id = PLACEMENT__ID INTO ITEM1;
		PLACEMENT__ID = ITEM1.placement_id;
		IF PLACEMENT__ID != 0 AND ((select privilage_level from user_login where account_id = PLACEMENT__ID) != 1)  THEN
			UPLINE := array_append(UPLINE, PLACEMENT__ID);
		END IF;
	END LOOP;
	-- 	RAISE NOTICE 'UPLINE LIST: %',UPLINE;

	INSERT INTO user_details(account_id,placement_id,daily_limit,weekly_limit,upline_members) 
		VALUES (new_account_id,created_by,daily__limit,weekly__limit,UPLINE) 
		returning account_id INTO new_account_id;

	IF new_account_id IS NULL THEN 
		RETURN to_json(concat('{"data":null,"error":"Account Creation Failed"}'));
	ELSE
		z_downline := z_rec.downline;
		z_downline := array_append(z_downline, new_account_id);
		UPDATE user_login SET downline = z_downline WHERE  account_id = created_by;
		
		IF privilage = 1 THEN
			insert into TICKETCONFIG(account_id,draw_id) values(new_account_id,1);
			insert into TICKETCONFIG(account_id,draw_id) values(new_account_id,2);
			insert into TICKETCONFIG(account_id,draw_id) values(new_account_id,3);
			insert into TICKETCONFIG(account_id,draw_id) values(new_account_id,4);
		END IF;
		RETURN to_json(concat('{"data":{"msg":"Account Creation Success","account_id":',new_account_id,'},"error":null}'));
	END IF;
END;
$BODY$;



CREATE OR REPLACE FUNCTION public.lg_auth(
    user__name character varying,
    pass_word character varying,
    ip__address character varying,
    app__version character varying
	) 
	RETURNS json 
	LANGUAGE 'plpgsql' 
	COST 100 
	VOLATILE PARALLEL UNSAFE 
AS $BODY$ 
DECLARE 
    user_details RECORD;
    my_session_id BIGINT;
    z_data json;
BEGIN

	-- SELECT lg_auth('admin','111','192.168.1.111','1');
	
    IF (app__version :: numeric < (SELECT events FROM appconfig WHERE event_name = 'min_version') :: numeric) THEN 
        RETURN to_json(concat('{"data":null,"error":"app is outdated-',(SELECT events FROM appconfig WHERE event_name = 'app_name'),'_',
							  (SELECT events FROM appconfig WHERE event_name = 'latest_version'),'.apk"}'));
    END IF;

    SELECT * FROM user_login
        WHERE REPLACE(lower(user_name), ' ', '') = REPLACE(lower(user__name), ' ', '') 
        AND user_password = md5(pass_word) INTO user_details;

    IF user_details IS NULL THEN
        RETURN to_json(concat('{"data":null,"error":"Wrong Password"}'));
    END IF;
	
	IF user_details.user_disabled = TRUE THEN 
        RETURN to_json(concat('{"data":null,"error":"User not found or disabled!"}'));
    END IF;

    INSERT INTO user_session(account_id, ip_address)
        VALUES(user_details.account_id, ip__address :: cidr) 
        RETURNING session_id INTO my_session_id;

    SELECT json_build_object(
            'account_id',user_details.account_id,
            'session_id',my_session_id,
            'privilage_level',user_details.privilage_level,
            'username',user_details.user_name) INTO z_data;

    RETURN to_json(concat('{"data":', z_data, ',"error":null}'));
END;
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_draw(
	account__id bigint,
	one__pm boolean,
    three__pm boolean,
    six__pm boolean,
    eight__pm boolean,
    isedit boolean,
	updated_by bigint)
	RETURNS json
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	z_data json;
	z_rec record;
	vr_rec record;
	z_temp json[] := '{}';
	item bigint;
	z_query character varying;
	z_output json;
BEGIN

	-- select sd_draw(76,false,false,false,false,false,56);
	-- select sd_draw(76,true,false,false,false,true,56);
	
	IF isedit = true THEN
		SELECT privilage_level FROM user_login WHERE account_id = updated_by INTO z_rec;
		IF z_rec.privilage_level = 3 THEN
			RETURN to_json(concat('{"data":null,"error":"Admin or subadmin only can Edit values"}'));
		END IF;
		
		SELECT privilage_level FROM user_login 
		WHERE case when account__id is null then true else account_id = account__id end INTO z_rec;

		IF z_rec.privilage_level = 1 THEN
			RETURN to_json(concat('{"data":null,"error":"cant disable draw for admin"}'));
		ELSE
			UPDATE user_details SET draw_1 = one__pm, draw_2 = three__pm, draw_3 = six__pm, draw_4 = eight__pm
				WHERE account_id = account__id;
			RETURN to_json(concat('{"data":"success","error":null}'));
		END IF;
	END IF;
	
	FOR item IN select draw_id from  drawconfig order by draw_id asc
	LOOP
		z_query := concat('SELECT draw_id,draw_time,color,draw_type,current_timestamp::date as date
						  FROM user_details CROSS JOIN drawconfig 
						  WHERE account_id=',account__id,' and draw_id =',item,' and draw_',item,'= true');
		RAISE NOTICE 'z_query : %',z_query;
		EXECUTE(z_query) INTO z_rec;
		IF z_rec.draw_id IS NOT NULL THEN
			SELECT to_json(z_rec) into z_output;
			z_temp :=array_append(z_temp,z_output);
		END IF;
	END LOOP;
	RETURN to_json(concat('{"data":',array_to_json(z_temp),',"error":null}'));
END
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_getcommission(
	account__id bigint)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	z_data json='{}';
begin
	
	-- SELECT sd_get_commission(56);

	IF exists(SELECT account_id FROM user_login WHERE account_id = account__id) = false THEN
		RETURN to_json(concat('{"data":null,"error":"User Not Found!"}'));
	END IF;
	
	select row_to_json(t) FROM(
	select dc_single,dc_double,dc_dear,dc_box,current_timestamp::date as date from user_details where account_id = account__id
	) t into z_data;
	return to_json(concat('{"data":',z_data,',"error":null}'));
end
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_getdownlist(
	account__id bigint,
	showmyacc boolean)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	z_placement__id BIGINT[];
	z_output json := '[]';
	__temp json;
	item bigint;
	z_rec record;
BEGIN
	select sd_getdownfloor(account__id,showmyacc) into z_placement__id;
	raise notice 'oooof%',z_placement__id;

	select json_agg(t) from (
		select account_id,user_name,privilage_level from user_login 
		where account_id =ANY(z_placement__id) order by account_id desc
	)t into z_output;
	
	if z_output is null then 
		z_output='[]';
	end if;
	return to_json(concat('{"data":',to_json(z_output),',"error":null}'));
END;
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_getdownfloor(
	account__id bigint,
	showmyacc boolean DEFAULT true)
    RETURNS bigint[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	rec record;
	plcement__id BIGINT[] :='{}';
BEGIN
	-- select sd_getdownfloor(56,true);

	SELECT privilage_level,downline FROM user_login WHERE account_id=account__id INTO rec;
	
	IF rec.privilage_level != 3 THEN
		plcement__id := rec.downline;
	END IF;
	
	IF showmyacc = true THEN
		plcement__id := ARRAY[account__id] || plcement__id;
	END IF;
	
	
	RETURN plcement__id;
END;	
$BODY$;



CREATE OR REPLACE FUNCTION public.ext_checklimit(
	account__id bigint,
	d_amt double precision,
	purchase_date character varying default CURRENT_DATE)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	from_date CHARACTER VARYING;
    to_date CHARACTER VARYING;
    dailydraw_check bigint;
    weeklydraw_check bigint;
BEGIN

	-- SELECT ext_checklimit(56,10000000);
	SELECT date_trunc('week', now() :: TIMESTAMP) :: CHARACTER VARYING INTO from_date;
	SELECT (date_trunc('week', now() :: TIMESTAMP) + INTERVAL '6 DAY') :: CHARACTER VARYING INTO to_date;
	
	select COALESCE(sum(total_camt),0) from booking_tickets where 
						account_id = account__id and p_date = purchase_date 
						and deleted=false into dailydraw_check;

	IF (dailydraw_check + d_amt >= (select daily_limit from user_details where account_id = account__id)) THEN 
		RETURN 'daily limit reached';
	END IF;

	select COALESCE(sum(total_camt),0) from booking_tickets where 
						account_id = account__id and p_date between from_date and to_date
						and deleted=false into weeklydraw_check;

	IF (weeklydraw_check + d_amt >= (select weekly_limit from user_details where account_id = account__id)) THEN
		RETURN 'weekly limit reached';
	END IF;
	
	RETURN '';
END
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_update_winningcommission(
	account__id bigint,
	updated__by bigint,
	wc__dear_1 numeric,
	wc__dear_2 numeric,
	wc__dear_3 numeric,
	wc__dear_4 numeric,
	wc__dear_5 numeric,
	wc__dear_6 numeric,
	wc__single_1 numeric,
	wc__double_1 numeric,
	wc__box_same1 numeric,
	wc__box_both1 numeric,
	wc__box_both2 numeric,
	wc__box_shuffle1 numeric,
	wc__box_shuffle2 numeric,
	block boolean
 )
	RETURNS json
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	Z_RECORD CHARACTER VARYING;
BEGIN

	-- SELECT sd_update_winningcommission(88,56,5000,500, 251,100, 50,20,100, 700,7000 ,3800,1600,3000, 800,false);
	
	IF (NOT EXISTS(SELECT * FROM USER_DETAILS WHERE ACCOUNT_ID = account__id)) THEN
		RETURN to_json(concat('{"data":null,"error":"USER NOT EXIST"}'));
	END IF;

	IF (SELECT privilage_level FROM user_login WHERE account_id = updated__by) = 3 THEN
		RETURN to_json(concat('{"data":null,"error":"NOT ENOUGH PRIVILAGE"}'));
	END IF;
	
	UPDATE user_details SET wc_dear_1=wc__dear_1,
							wc_dear_2=wc__dear_2,
							wc_dear_3=wc__dear_3,
							wc_dear_4=wc__dear_4,
							wc_dear_5=wc__dear_5,
							wc_dear_6=wc__dear_6,
							wc_single_1=wc__single_1,
							wc_double_1=wc__double_1,
							wc_box_same1=wc__box_same1,
							wc_box_both1=wc__box_both1,
							wc_box_both2=wc__box_both2,
							wc_box_shuffle1=wc__box_shuffle1,
							wc_box_shuffle2=wc__box_shuffle2,
							block_winning = block 
						WHERE account_id=account__id;
	
	SELECT CONCAT('wc_dear_1: ', wc_dear_1,', wc_dear_2: ', wc_dear_2,', wc_dear_3: ', wc_dear_3,
		', wc_dear_4: ', wc_dear_4,', wc_dear_5: ', wc_dear_5,', wc_dear_6: ', wc_dear_6,', wc_single_1: ', wc_single_1,
		', wc_double_1: ', wc_double_1,', wc_box_same1: ', wc_box_same1,', wc_box_both1: ', wc_box_both1,
		', wc_box_both2: ', wc_box_both2,', wc_box_shuffle1: ', wc_box_shuffle1,', wc_box_shuffle2: ', wc_box_shuffle2,'')
		FROM user_details WHERE ACCOUNT_ID = account__id INTO Z_RECORD;
						
	INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
		VALUES(updated__by,account__id,'WINNING COMMISSION',Z_RECORD,CONCAT(
		'wc_dear_1: ', wc__dear_1,', wc_dear_2: ', wc__dear_2,', wc_dear_3: ', wc__dear_4,', wc_dear_4: ', wc__dear_4,
		', wc_dear_5: ', wc__dear_5,', wc_dear_6: ', wc__dear_6,', wc_single_1: ', wc__single_1,', wc_double_1: ', wc__double_1,
		', wc_box_same1: ', wc__box_same1,', wc_box_both1: ', wc__box_both1,', wc_box_both2: ', wc__box_both2,
		', wc_box_shuffle1: ', wc__box_shuffle1,', wc_box_shuffle2: ', wc__box_shuffle2,''));
						
	RETURN to_json(concat('{"data":"success","error":null}'));
	END;
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_update_winningprize(
	account__id bigint,
	updated__by bigint,
	wp__dear_1 numeric,
	wp__dear_2 numeric,
	wp__dear_3 numeric,
	wp__dear_4 numeric,
	wp__dear_5 numeric,
	wp__dear_6 numeric,
	wp__single_1 numeric,
	wp__double_1 numeric,
	wp__box_same1 numeric,
	wp__box_both1 numeric,
	wp__box_both2 numeric,
	wp__box_shuffle1 numeric,
	wp__box_shuffle2 numeric)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	privilage integer;
	Z_RECORD CHARACTER VARYING;
BEGIN
	-- SELECT sd_update_winningprize(193,56,5000,500, 251,100, 50,20,100, 700,7000 ,3800,1600,3000, 800);
	
	select privilage_level from user_login where account_id = updated__by into privilage;
	
	if (select privilage = any('{3,6}')) then
		return to_json(concat('{"data":null,"error":"unable to edit"}'));
	end if;
	
	UPDATE user_details SET wp_dear_1 = wp__dear_1,
						wp_dear_2 = wp__dear_2,
						wp_dear_3 = wp__dear_3,
						wp_dear_4 = wp__dear_4,
						wp_dear_5 = wp__dear_5,
						wp_dear_6 = wp__dear_6,
						wp_single_1 = wp__single_1,
						wp_double_1 = wp__double_1,
						wp_box_same1 = wp__box_same1,
						wp_box_both1 = wp__box_both1,
						wp_box_both2 = wp__box_both2,
						wp_box_shuffle1 = wp__box_shuffle1,
						wp_box_shuffle2 = wp__box_shuffle2
					where account_id=account__id;
	
	SELECT CONCAT('wp_dear_1: ', wp_dear_1,', wp_dear_2: ', wp_dear_2,
		', wp_dear_3: ', wp_dear_3,', wp_dear_4: ', wp_dear_4,', wp_dear_5: ', wp_dear_5,
		', wp_dear_6: ', wp_dear_6,', wp_single_1: ', wp_single_1,', wp_double_1: ', wp_double_1,
		', wp_box_same1: ', wp_box_same1,', wp_box_both1: ', wp_box_both1,', wp_box_both2: ', wp_box_both2,
		', wp_box_shuffle1: ', wp_box_shuffle1,', wp_box_shuffle2: ', wp_box_shuffle2,'')
		FROM user_details WHERE ACCOUNT_ID = account__id INTO Z_RECORD;
	
	INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
		VALUES(updated__by,account__id,'WINNING PRIZE',Z_RECORD,CONCAT('wp_dear_1: ', wp__dear_1,', wp_dear_2: ', wp__dear_2,', wp_dear_3: ', wp__dear_4,', wp_dear_4: ', wp__dear_4,
	', wp_dear_5: ', wp__dear_5,', wp_dear_6: ', wp__dear_6,', wp_single_1: ', wp__single_1,', wp_double_1: ', wp__double_1,
	', wp_box_same1: ', wp__box_same1,', wp_box_both1: ', wp__box_both1,', wp_box_both2: ', wp__box_both2,
	', wp_box_shuffle1: ', wp__box_shuffle1,', wp_box_shuffle2: ', wp__box_shuffle2,''));

	return to_json(concat('{"data":"success","error":null}'));
	END;
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_profiledetails(
	account__id bigint)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	z_data json;
	z_rec record;
begin

	-- select sd_profiledetails(56);

	if account__id is null or not Exists(select account_id from user_login where account_id = account__id) then 
		return to_json(concat('{"data":null,"error":"User not found"}'));
	end if;
	
	select row_to_json(t) from (
		select * from user_details inner join user_login using(account_id) where user_login.account_id = account__id
	)t into z_data;
	
	return to_json(concat('{"data":',to_json(z_data),',"error":null}'));
end
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_winningresult(
	from_date character varying,
	to_date character varying,
	draw__id integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	z_output json := '{}';
BEGIN
    -- select sd_winningresult('2023-11-01','2023-11-01',4);

	SELECT JSON_AGG(t) FROM (
			SELECT * FROM SD_WINNING_HISTORY WHERE IS_DELETE = FALSE 
				AND DRAW_DATE BETWEEN from_date AND to_date
				AND ((DRAW__ID IS NOT NULL AND DRAW_ID = DRAW__ID) OR DRAW__ID IS NULL)
		)t INTO z_output;

	RETURN to_json(concat ('{"data":{"history":', COALESCE(z_output,'[]') ,'},"error":null}'));	
END
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_addcommission(
	account__id bigint,
	c_single double precision,
	c_double double precision,
	c_dear double precision,
	c_box double precision,
	req_by bigint
	)
	RETURNS json
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	Z_RECORD CHARACTER VARYING;
BEGIN
	-- select sd_addcommission(193,0,0,2,0,56);
	if not exists(select account_id from user_login where account_id=account__id) then
		return to_json(concat('{"data":null,"error":"User Not Found"}'));
	end if;
	
	SELECT CONCAT('dc_single: ', dc_single,', dc_double: ', dc_double,', dc_dear: ', dc_dear,', dc_box: ', dc_box)
	FROM user_details WHERE ACCOUNT_ID = account__id INTO Z_RECORD;
	
	INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
		VALUES(req_by,account__id,'PURCHASE COMMISSION',Z_RECORD,CONCAT(
        'dc_single: ', c_single,', dc_double: ', c_double,', dc_dear: ', c_dear,', dc_box: ', c_box));
	
	update user_details set dc_single = c_single,dc_double = c_double,
		dc_dear = c_dear,dc_box = c_box where account_id=account__id;

	return to_json(concat('{"data":"success","error":null}'));	
END;
$BODY$;



CREATE OR REPLACE FUNCTION public.sd_editdrawtime(
	req_by bigint,
	is_edit boolean,
	draw__id int,
	event_name character varying,
	event_time character varying)
	RETURNS json
	LANGUAGE 'plpgsql'
	COST 100
	VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	z_query character varying;
	Z_RECORD character varying;
	z_output json := '{}';
BEGIN
	-- select sd_editdrawtime(56,true,1,'draw_end','13:00:00');
	-- select sd_editdrawtime(56,false,1,'draw_end','13:00:00');
	if is_edit = true then
		if (select privilage_level from user_login where account_id = req_by) = any('{0,1}') then
			z_query := concat('SELECT ',event_name,' FROM DRAWCONFIG WHERE draw_id = ',draw__id,'');
			execute(z_query) INTO Z_RECORD;
			
			INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
				VALUES(req_by,'All','DRAW_TIME',(CONCAT('',event_name,' - ',Z_RECORD,'')),
					   (CONCAT('',event_name,' - ',event_time,'')));
			z_query := concat('update drawconfig set ',event_name,E' =\'',event_time,E'\' where draw_id = ',draw__id,'');
			raise notice 'z_query : %',z_query;
			
			execute(z_query);
			return to_json(concat('{"data":"success","error":null}'));
		else
			return to_json(concat('{"data":null,"error":"admin only can edit"}'));
		end if;
	else
		select json_agg(t) from (
			select draw_id,draw_start,draw_end,delete_end from drawconfig order by draw_id asc
		)t into z_output;
		return to_json(concat('{"data":',to_json(z_output),',"error":null}'));
	end if;
END;
$BODY$;


CREATE OR REPLACE FUNCTION public.sd_appversions(
	event_id integer,
	keyname character varying,
	keyvalue character varying,
	isedit boolean,
	req_by bigint)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	z_query character varying;
	Z_RECORD character varying;
	z_output json := '{}';
BEGIN

	-- SELECT sd_appversions(0,'','',false,56);	
	IF ISEDIT = true THEN
		IF(SELECT PRIVILAGE_LEVEL FROM USER_LOGIN WHERE ACCOUNT_ID = REQ_BY) = ANY('{0,1}') THEN
			z_query := concat('SELECT EVENTS FROM APPCONFIG WHERE EVENT_ID = ',event_id,'');
			execute(z_query) INTO Z_RECORD;
			
			INSERT INTO PROFILE_UPDATE_HISTORY(UPDATED_BY,ACCOUNT_ID,UPDATE_TYPE,OLD_VALUE,NEW_VALUE)
				VALUES(REQ_BY,'All','APP_VERSION',(CONCAT('',keyname,' - ',Z_RECORD,'')),
					   (CONCAT('',keyname,' - ',keyvalue,'')));
			z_query := concat('UPDATE APPCONFIG SET ',keyname,E' =\'',keyvalue,E'\' WHERE EVENT_ID = ',event_id,'');
			raise notice 'z_query : %',z_query;
			
			execute(z_query);
			return to_json(concat('{"data":"success","error":null}'));
		else
			return to_json(concat('{"data":null,"error":"admin only can edit"}'));
		end if;
	else
		SELECT JSON_AGG(t) FROM (
		SELECT * FROM APPCONFIG WHERE APPCONFIG.EVENT_ID <>2 ORDER BY EVENT_ID ASC
		)t INTO z_output;
		return to_json(concat('{"data":',to_json(z_output),',"error":null}'));
	end if;
END;	
$BODY$;




delete from ticket_table;
delete from booking_tickets;
DROP TABLE IF EXISTS sd_winning_commission;
DROP TABLE IF EXISTS sub_winners;
DROP TABLE IF EXISTS sub_tickets;
DROP TABLE IF EXISTS sub_booking_ticket;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS booking_ticket;
delete from user_session;
delete from winners;
delete from purchase_count;

CREATE INDEX user_login_accountid ON user_login(account_id);
CREATE INDEX user_details_accountid ON user_details(account_id);
CREATE INDEX booking_tickets_1 ON booking_tickets(account_id,p_date,deleted);
CREATE INDEX booking_tickets_2 ON booking_tickets(booking_id);
CREATE INDEX booking_tickets_3 ON booking_tickets(account_id,DRAW_ID,p_date,deleted);
CREATE INDEX ticket_table_1 ON TICKET_TABLE(ticket_type,draw_id,ticket_number,deleted);
CREATE INDEX ticket_table_2 ON TICKET_TABLE(ticket_id);
CREATE INDEX ticket_table_3 ON TICKET_TABLE(ticket_id,deleted);