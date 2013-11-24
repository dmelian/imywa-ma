set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'DISPLAYPANNEL.TABLE.SQL');

select @currFile as file, 'TABLE display' as command;
create table if not exists display(

	display varchar(10) not null,

	primary key ( display )
) engine InnoDB, default character set utf8;


select @currFile as file, 'TABLE displayVar' as command;
create table if not exists displayVar(
	
	display varchar(10) not null,
	var varchar(10) not null,
	caption varchar(30),
	alignment enum ('left', 'right', 'center'),
	row integer,
	col integer,
	width integer,

	primary key ( display, var )
) engine InnoDB, default character set utf8;


select @currFile as file, 'TABLE displayPannel' as command;
create table if not exists displayPannel(

	business varchar(10) not null,
	pos integer not null,
	display varchar(10) not null,

	primary key ( business, pos, display )
) engine InnoDB, default character set utf8;


select @currFile as file, 'TABLE displayLabel' as command;
create table if not exists displayLabel(

	business varchar(10) not null,
	pos integer not null,
	display varchar(10) not null,
	var varchar(10) not null,
	varValue varchar(30),

	primary key ( business, pos, display, var, varValue )
) engine InnoDB, default character set utf8;


select @currFile as file, 'RELATIONS OF TABLE displayLabel' as command;
alter table displayLabel add 
	foreign key ( business, pos, display ) references displayPannel ( business, pos, display ) 
		on delete restrict on update cascade;

