set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'SELECTPANNEL.TABLE.SQL');

select @currFile as file, 'TABLE selectPannel' as command;
create table if not exists selectPannel(
	business varchar(10) not null,
	pos integer not null,
	currentGroup varchar(10),
	currentPage integer default 0,
	pageWidth integer,
	rowCount integer,
	colCount integer,
	viewWidth integer,
	pageCount integer,
	homeGroup varchar(10),
	dimLeft float, dimTop float,
	dimWidth float, dimHeight float,
	primary key ( business, pos )
) engine InnoDB, default character set utf8;

select @currFile as file, 'TABLE selectButton' as command;
create table if not exists selectButton(
	business varchar(10) not null,
	pos integer not null,
	id varchar(20) not null,
	action enum('group', 'item', 'pannelAction', 'nop'),
	caption varchar(30),
	bound bool default false,
	buttonOrder integer,
	amount double,
	quantity integer,
	secondCaption varchar(30),
	class varchar(80),
	row integer,
	col integer,

	primary key ( business, pos, id ),
	index ( business, pos, buttonOrder )
) engine InnoDB, default character set utf8;


