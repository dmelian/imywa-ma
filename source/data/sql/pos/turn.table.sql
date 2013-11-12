set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'TURN.TABLE.SQL');


select @currFile as file, 'TABLE turn' as command;
create table if not exists turn(

	business varchar(10) not null,
	pos integer not null,
	workDay date not null,
	turn integer not null,
	catalog varchar(10),
	opening datetime,
	openUser varchar(10),
	closing datetime,
	closeUser varchar(10),


	primary key ( business, pos, workDay, turn )
) engine InnoDB, default character set utf8;


