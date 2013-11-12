set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'PRICE.TABLE.SQL');

select @currFile as file, 'TABLE price' as command;
create table if not exists price(
	business varchar(10) not null,
	catalog varchar(19) not null,
	item varchar(20) not null,
	price double,

	primary key ( business, catalog, item )
) engine InnoDB, default character set utf8;




