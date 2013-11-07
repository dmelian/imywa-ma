set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'SELECTPANNEL.RELATION.SQL');

/*
select @currFile as file, 'RELATIONS OF TABLE selectPannel' as command;
alter table selectPannel add 
	foreign key ( business, pos ) references pos ( business, pos ) 
		on delete cascade on update cascade;
*/

select @currFile as file, 'RELATIONS OF TABLE selectButton' as command;
alter table selectButton add 
	foreign key ( business, pos ) references selectPannel ( business, pos ) 
		on delete cascade on update cascade;

