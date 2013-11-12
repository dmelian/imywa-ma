set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'VATTYPE.TABLE.SQL');

select @currFile as file, 'TABLE VATType' as command;
create table if not exists VATType(

	VATType varchar(10),
	percentage float,

	primary key ( VATType )
) engine InnoDB, default character set utf8;

