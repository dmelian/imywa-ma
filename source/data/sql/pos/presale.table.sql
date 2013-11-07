set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'PRESALE.TABLE.SQL');


select @currFile as file, 'TABLE presale' as command;
create table if not exists presale(

	business varchar(10) not null,
	pos integer not null,
	workDay date not null,
	turn integer not null,
	presale integer not null,
	state enum ('draft', 'deleted', 'billed', 'revising', 'annulled', 'charged'),
	listAmount double default 0,
	discount float default 0,
	discountAmount double default 0,
	presaleAmount double default 0,
	ticketNo varchar(20),
	saleAmount double default 0,
	chargedAmount double default 0,
	owedAmount double default 0,
	primary key ( business, pos, workDay, turn, presale )

) engine InnoDB, default character set utf8;


select @currFile as file, 'TABLE presaleVersion' as command;
create table if not exists presaleVersion(

	business varchar(10) not null,
	pos integer not null,
	workDay date not null,
	turn integer not null,
	presale integer not null,
	version integer not null,
	creationTime datetime,
	action enum('new', 'delete', 'bill', 'annull', 'revise', 'charge'),
	reason integer,
	primary key ( business, pos, workDay, turn, presale, version )
	
) engine InnoDB, default character set utf8;

select @currFile as file, 'TABLE saleLine' as command;
create table if not exists presaleLine(

	business varchar(10) not null,
	pos integer not null,
	workDay date not null,
	turn integer not null,
	presale integer not null,
	lineNo integer not null,
	version integer not null,
	creationTime datetime,
	item varchar(20) not null,
	quantity integer default 0,
	price double default 0,
	listPrice double default 0,
	primary key ( business, pos, workDay, turn, presale, lineNo )
	
) engine InnoDB, default character set utf8;


select @currFile as file, 'TABLE reason' as command;
create table if not exists reason(

	reason integer AUTO_INCREMENT,
	description varchar(50),
	primary key (reason)
	
) engine InnoDB, default character set utf8;



