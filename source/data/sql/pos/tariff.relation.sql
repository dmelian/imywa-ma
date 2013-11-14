set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'TARIFF.RELATION.SQL');

select @currFile as file, 'RELATIONS OF TABLE tariff' as command;
alter table tariff add 
	foreign key ( business ) references business ( business ) 
		on delete cascade on update cascade;

		
select @currFile as file, 'RELATIONS OF TABLE price' as command;
alter table price add 
	foreign key ( business, tariff ) references tariff ( business, tariff  ) 
		on delete cascade on update cascade;
		
alter table price add 
	foreign key ( business, item ) references item ( business, item  ) 
		on delete cascade on update cascade;

