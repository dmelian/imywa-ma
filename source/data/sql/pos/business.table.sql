set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'BUSINESS.TABLE.SQL');

select @currFile as file, 'TABLE business' as command;
create table if not exists business(

	business varchar(10) not null,
	name varchar(50),
	pricesIncludeVAT bool,

	primary key ( business )
) engine InnoDB, default character set utf8;

