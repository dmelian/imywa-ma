set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'CATALOG.TABLE.SQL');

select @currFile as file, 'TABLE catalog' as command;
create table if not exists catalog(

	business varchar(10) not null,
	catalog varchar(10) not null,
	mainItemGroup varchar(20),

	primary key ( business, catalog )
) engine InnoDB, default character set utf8;

