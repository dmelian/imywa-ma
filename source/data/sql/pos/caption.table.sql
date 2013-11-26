set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'CAPTION.TABLE.SQL');

select @currFile as file, 'TABLE caption' as command;
create table if not exists caption(

	language varchar(3) not null,
	caption integer not null,
	captionText varchar(30),

	primary key ( language, caption )
) engine InnoDB, default character set utf8;


select @currFile as file, 'TABLE language' as command;
create table if not exists language(

	language varchar(3) not null,

	primary key ( language )
) engine InnoDB, default character set utf8;



