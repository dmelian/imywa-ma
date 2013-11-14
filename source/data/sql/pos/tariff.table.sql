set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'TARIFF.TABLE.SQL');



select @currFile as file, 'TABLE tariff' as command;
create table if not exists tariff(

	business varchar(10) not null,
	tariff varchar(10) not null,
	description varchar(30),

	primary key ( business, tariff )
) engine InnoDB, default character set utf8;


select @currFile as file, 'TABLE price' as command;
create table if not exists price(
	
	business varchar(10) not null,
	tariff varchar(10) not null,
	item varchar(20) not null,
	price double,

	primary key ( business, tariff, item )
) engine InnoDB, default character set utf8;



