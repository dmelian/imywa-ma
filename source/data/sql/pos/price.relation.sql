set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'PRICE.RELATION.SQL');

select @currFile as file, 'RELATIONS OF TABLE price' as command;
alter table price add 
	foreign key ( business, catalog ) references catalog ( business, catalog ) 
		on delete cascade on update cascade;
alter table price add 
	foreign key ( business, item ) references item ( business, item ) 
		on delete cascade on update cascade;

