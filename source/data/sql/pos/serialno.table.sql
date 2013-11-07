set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'SERIALNO.TABLE.SQL');


select @currFile as file, 'TABLE serialNo' as command;
create table if not exists serialNo(

	serialNo varchar(10) not null primary key,
	prefix varchar(10), -- use:  %x/%v week, %Y year4, %y year2, %y/%m month (from mysql date_format)
	padding integer,
	period enum( 'none', 'year', 'month', 'week' ),
	periodFormat varchar(5)

) engine InnoDB, default character set utf8;

select @currFile as file, 'TABLE serialPeriod' as command;
create table if not exists serialPeriod(

	serialNo varchar(10) not null,
	period varchar(10),
	counter integer,
	primary key ( serialNo, period )

) engine InnoDB, default character set utf8;


