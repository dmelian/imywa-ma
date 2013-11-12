set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'SALE.TABLE.SQL');

select @currFile as file, 'TABLE sale' as command;
create table if not exists sale(

	business varchar(10) not null,
	sale varchar(20) not null,
	workDay date,
	turn integer,
	creationTime datetime,

	primary key ( business, sale )
) engine InnoDB, default character set utf8;


