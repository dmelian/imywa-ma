set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'CAPTION.RELATION.SQL');

select @currFile as file, 'RELATIONS OF TABLE caption' as command;
alter table caption add 
	foreign key ( language ) references language ( language ) 
		on delete cascade on update cascade;


