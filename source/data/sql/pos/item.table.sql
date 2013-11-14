set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'ITEM.TABLE.SQL');


select @currFile as file, 'TABLE item' as command;
create table if not exists item(
	
	business varchar(10) not null,
	item varchar(20) not null,
	description varchar(30),
	VATType varchar(10),

	primary key ( business, item )
) engine InnoDB, default character set utf8;




