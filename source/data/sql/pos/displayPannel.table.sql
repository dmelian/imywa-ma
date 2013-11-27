set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'DISPLAYPANNEL.TABLE.SQL');

select @currFile as file, 'TABLE display' as command;
create table if not exists display(

	display varchar(10) not null,

	primary key ( display )
) engine InnoDB, default character set utf8;


select @currFile as file, 'TABLE displayVars' as command;
create table if not exists displayVars(
	
	display varchar(10) not null,
	var varchar(10) not null,
	row integer,
	col integer,
	width integer,

	primary key ( display, var )
) engine InnoDB, default character set utf8;

select @currFile as file, 'TABLE var' as command;
create table if not exists var(
	
	var varchar(10) not null,
	caption integer,
	alignment enum ('left', 'right', 'center'),

	primary key ( var )
) engine InnoDB, default character set utf8;



select @currFile as file, 'TABLE displayPannel' as command;
create table if not exists displayPannel(

	business varchar(10) not null,
	pos integer not null,
	rowCount integer,
	colCount integer,
	currentDisplay varchar(10),

	primary key ( business, pos )
) engine InnoDB, default character set utf8;


select @currFile as file, 'TABLE displayLabel' as command;
create table if not exists displayLabel(

	business varchar(10) not null,
	pos integer not null,
	var varchar(10) not null,
	varValue varchar(30),

	primary key ( business, pos, var )
) engine InnoDB, default character set utf8;



