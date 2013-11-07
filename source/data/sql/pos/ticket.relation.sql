set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'TICKET.RELATION.SQL');

/*
select @currFile as file, 'RELATIONS OF TABLE ticket' as command;
alter table ticket add 
	foreign key ( business ) references business ( business ) 
		on delete restrict on update cascade;
*/

