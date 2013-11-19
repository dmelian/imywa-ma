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
	( @currentMenu, 'HOME', 'Home', 10)
	,( @currentMenu, 'PARENT', 'Parent', 12)
	,( @currentMenu, 'LOCK', 'Lock', 11)
	,( @currentMenu, 'QTY', 'Quantity', 20)
	,( @currentMenu, 'BILL', 'Bill', 30)
	,( @currentMenu, 'PRICE', 'Price List', 100)
	,( @currentMenu, 'CHARGE', 'Charge', 31)
	,( @currentMenu, 'CASHCHG', 'Cash Charge', 35)
	,( @currentMenu, 'CREDITCHG', 'Credit Card Charge', 36)
	,( @currentMenu, 'NEW', 'New Invoice', 40)
	,( @currentMenu, 'DELETE', 'Delete', 41)
	,( @currentMenu, 'RECEIV', 'Receivables', 50)
	,( @currentMenu, 'DISCOUNT', 'Discount', 45)
	,( @currentMenu, 'CLOSED', 'Closed Sales', 51)
	,( @currentMenu, 'SALES', 'List Sales', 52)
	,( @currentMenu, 'STATUS', 'Status', 60)
	,( @currentMenu, 'CASHCOUNT', 'Cash Count', 61)
	,( @currentMenu, 'REMOVE', 'Remove', 42)
--	,( @currentMenu, '', '', 0)
;


