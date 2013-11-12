set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'CATALOG.RELATION.SQL');

select @currFile as file, 'RELATIONS OF TABLE catalog' as command;
alter table catalog add 
	foreign key ( mainItemGroup ) references item ( item ) 
		on delete set null on update cascade;

alter table catalog add 
	foreign key ( business ) references business ( business ) 
		on delete cascade on update cascade;

