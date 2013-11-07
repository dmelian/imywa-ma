set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'SELECTPANNEL.TABLE.SQL');

select @currFile as file, 'TABLE selectPannel' as command;
create table if not exists selectPannel(
	business varchar(10) not null,
	pos integer not null,
	currentGroup varchar(20),
	currentPage integer default 0,
	pageWidth integer,
	dimLeft float, dimTop float,
	dimWidth float, dimHeight float,
	primary key ( business, pos )
) engine InnoDB, default character set utf8;

select @currFile as file, 'TABLE selectButton' as command;
create table if not exists selectButton(
	business varchar(10) not null,
	pos integer not null,
	id varchar(20) not null,
	caption varchar(30),
	bound bool default false,
	buttonOrder integer,
	amount double,
	quantity integer,
	secondCaption varchar(30),
	classes varchar(80),

	primary key ( business, pos, id ),
	index ( business, pos, buttonOrder )
) engine InnoDB, default character set utf8;


