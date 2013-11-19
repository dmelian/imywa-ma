set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'MENUPANNEL.TABLE.SQL');

select @currFile as file, 'TABLE menu' as command;
create table if not exists menu(

	menu varchar(10),

	primary key ( menu )
) engine InnoDB, default character set utf8;


select @currFile as file, 'TABLE menuAction' as command;
create table if not exists menuAction(

	menu varchar(10) not null,
	action varchar(10) not null,
	active bool,
	caption varchar(30),
	actionOrder integer,

	primary key ( menu, action )
) engine InnoDB, default character set utf8;


select @currFile as file, 'TABLE menuPannel' as command;
create table if not exists menuPannel(

	business varchar(10) not null,
	pos integer not null,
	currentMenu varchar(10),
	pageWidth integer,
	viewWidth integer,
	pageCount integer,
	currentPage integer,

	primary key ( business, pos )
) engine InnoDB, default character set utf8;


select @currFile as file, 'TABLE menuButton' as command;
create table if not exists menuButton(

	business varchar(10) not null,
	pos integer not null,
	id varchar(10) not null,
	action varchar(10),
	active bool,
	disabled bool,
	visible bool,
	caption varchar(30) not null,
	bound bool,
	buttonOrder integer,
	secondCaption varchar(30),
	class varchar(80),

	primary key ( business, pos, id )
) engine InnoDB, default character set utf8;



