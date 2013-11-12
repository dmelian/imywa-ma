set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'WORKDAY.TABLE.SQL');

select @currFile as file, 'TABLE workDay' as command;
create table if not exists workDay(
	
	business varchar(10) not null,
	workDay date not null,
	opening datetime,
	openUser varchar(10),
	openPos integer,
	closing datetime,
	closeUser varchar(10),
	closePos integer,

	primary key ( business, workDay )
) engine InnoDB, default character set utf8;


