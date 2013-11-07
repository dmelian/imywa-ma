set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'TURN.RELATION.SQL');

/*
select @currFile as file, 'RELATIONS OF TABLE turn' as command;
alter table turn add 
	foreign key ( business, pos ) references pos ( business, pos ) 
		on delete restrict on update cascade;

alter table turn add 
	foreign key ( business, workDay ) references workDay ( business, workDay ) 
		on delete restrict on update cascade;


*/


