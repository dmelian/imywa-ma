set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'MENUPANNEL.RELATION.SQL');

select @currFile as file, 'RELATIONS OF TABLE menuAction' as command;
alter table menuAction add 
	foreign key ( menu ) references menu ( menu ) 
		on delete cascade on update cascade;

select @currFile as file, 'RELATIONS OF TABLE menuPannel' as command;
alter table menuPannel add 
	foreign key ( currentMenu ) references menu ( menu ) 
		on delete restrict on update cascade;

alter table menuPannel add 
	foreign key ( business, pos ) references pos ( business, pos ) 
		on delete cascade on update cascade;

select @currFile as file, 'RELATIONS OF TABLE menuButton' as command;
alter table menuButton add 
	foreign key ( business,pos ) references menuPannel ( business, pos ) 
		on delete cascade on update cascade;


set @currentMenu= 'SELECT';
select @currFile as file, concat_ws(' ', @currentMenu, 'MENU VALUES') as command;
insert into menu(menu) values (@currentMenu);
insert into menuAction(menu, action, caption, actionOrder) values
	( @currentMenu, 'HOME', 'home', 10)
	,( @currentMenu, 'PARENT', 'parent', 0)
--	,( @currentMenu, '', '', 0)
--	,( @currentMenu, '', '', 0)
--	,( @currentMenu, '', '', 0)
--	,( @currentMenu, '', '', 0)
--	,( @currentMenu, '', '', 0)
--	,( @currentMenu, '', '', 0)
--	,( @currentMenu, '', '', 0)
--	,( @currentMenu, '', '', 0)
--	,( @currentMenu, '', '', 0)
--	,( @currentMenu, '', '', 0)
;


