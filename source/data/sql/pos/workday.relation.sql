set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'WORKDAY.RELATION.SQL');

select @currFile as file, 'RELATIONS OF TABLE workDay' as command;
alter table workDay add 
	foreign key ( business ) references business ( business ) 
		on delete cascade on update cascade;

