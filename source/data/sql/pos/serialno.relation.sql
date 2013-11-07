set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'SERIALNO.RELATION.SQL');

select @currFile as file, 'RELATIONS OF TABLE serialPeriod' as command;
alter table serialPeriod add
	foreign key ( serialNo ) references serialNo( serialNo ) 
		on delete RESTRICT on update cascade;

