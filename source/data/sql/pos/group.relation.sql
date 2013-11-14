set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'ITEMGROUP.RELATION.SQL');

select @currFile as file, 'RELATIONS OF TABLE itemGroup' as command;
alter table itemGroup add 
	foreign key ( business ) references business ( business ) 
		on delete cascade on update cascade;

alter table itemGroup add 
	foreign key ( business, parentGroup ) references itemGroup ( business, itemGroup ) 
		on delete cascade on update cascade;

select @currFile as file, 'RELATIONS OF TABLE groupItems' as command;
alter table groupItems add 
	foreign key ( business, itemGroup ) references itemGroup ( business, itemGroup ) 
		on delete restrict on update cascade;

alter table groupItems add 
	foreign key ( business, item ) references item ( business, item ) 
		on delete restrict on update cascade;

