set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'POS.RELATION.SQL');

select @currFile as file, 'RELATIONS OF TABLE pos' as command;
alter table pos add 
	foreign key ( business ) references business ( business ) 
		on delete cascade on update cascade;

