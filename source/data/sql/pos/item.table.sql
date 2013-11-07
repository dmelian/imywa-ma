set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'ITEM.TABLE.SQL');


select @currFile as file, 'TABLE item' as command;
create table if not exists item(
	
	business varchar(10) not null,
	item varchar(20) not null,
	catalog varchar(10),
	type enum( 'group', 'item' ),
	itemGroup varchar(20),
	itemOrder integer,
	description varchar(30),
	price double,
	VATType varchar(10),

	primary key ( business, item ),
	index (business, catalog, itemGroup, type, item )
) engine InnoDB, default character set utf8;




