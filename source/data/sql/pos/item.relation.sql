set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'ITEM.RELATION.SQL');

select @currFile as file, 'RELATIONS OF TABLE item' as command;

alter table item add 
	foreign key ( business ) references business ( business ) 
		on delete restrict on update cascade;

alter table item add 
	foreign key ( VATType ) references VATType ( VATType ) 
		on delete set null on update cascade;


