set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'ITEMGROUP.TABLE.SQL');


select @currFile as file, 'TABLE itemGroup' as command;
create table if not exists itemGroup(

	business varchar(10) not null,
	itemGroup varchar(10) not null,
	parentGroup varchar (10),
	caption integer,
	description varchar(30), /*TODO erase this.*/
	groupOrder integer,
	
	primary key ( business, itemGroup )
) engine InnoDB, default character set utf8;



select @currFile as file, 'TABLE groupItems' as command;
create table if not exists groupItems(

	business varchar(10) not null,
	itemGroup varchar(10) not null,
	item varchar(20) not null,
	itemOrder integer,

	primary key ( business, itemGroup, item )
) engine InnoDB, default character set utf8;



