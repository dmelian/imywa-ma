set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'SALE.RELATION.SQL');


select @currFile as file, 'RELATIONS OF TABLE sale' as command;
alter table sale add 
	foreign key ( business ) references business ( business ) 
		on delete cascade on update cascade;


