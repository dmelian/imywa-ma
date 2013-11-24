set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'DISPLAYPANNEL.RELATION.SQL');

select @currFile as file, 'RELATIONS OF TABLE displayVar' as command;
alter table displayVar add 
	foreign key ( display ) references display ( display ) 
		on delete cascade on update cascade;

select @currFile as file, 'RELATIONS OF TABLE displayPannel' as command;
alter table displayPannel add 
	foreign key ( business, pos ) references pos ( business, pos ) 
		on delete cascade on update cascade;

alter table displayPannel add 
	foreign key ( display ) references display ( display ) 
		on delete cascade on update cascade;

