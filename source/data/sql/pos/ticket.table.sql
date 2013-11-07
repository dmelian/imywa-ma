set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'TICKET.TABLE.SQL');

select @currFile as file, 'TABLE ticket' as command;
create table if not exists ticket(

	business varchar(10) not null,
	ticketNo varchar(20) not null,
	workDay date,
	turn integer,
	presale integer,
	creationTime datetime,

	primary key ( business, ticketNo )
) engine InnoDB, default character set utf8;


