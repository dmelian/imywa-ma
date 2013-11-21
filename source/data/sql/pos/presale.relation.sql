set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'PRESALE.RELATION.SQL');


select @currFile as file, 'RELATIONS OF TABLE presale' as command;
alter table presale add 
	foreign key ( business, pos, workDay, turn ) references turn ( business, pos, workDay, turn ) 
		on delete cascade on update cascade;
		
alter table presale add 
	foreign key ( business, sale ) references sale ( business, sale ) 
		on delete restrict on update cascade;


select @currFile as file, 'RELATIONS OF TABLE presaleVersion' as command;
alter table presaleVersion add
	foreign key ( reason ) references reason ( reason ) 
		on delete restrict on update cascade;

alter table presaleVersion add
	foreign key ( business, pos, workDay, turn, presale ) 
		references presale( business, pos, workDay, turn, presale ) 
		on delete restrict on update cascade;



select @currFile as file, 'RELATIONS OF TABLE presaleLine' as command;
alter table presaleLine add
	foreign key ( business, pos, workDay, turn, presale, version ) 
		references presaleVersion( business, pos, workDay, turn, presale, version ) 
		on delete restrict on update cascade;

alter table presaleLine add
	foreign key ( business, tariff, item ) references price ( business, tariff, item ) 
		on delete restrict on update cascade;

alter table presaleLine add
	foreign key ( business, itemGroup, item ) references groupItems ( business, itemGroup, item ) 
		on delete restrict on update cascade;

