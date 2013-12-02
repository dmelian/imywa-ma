set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'DISPLAYPANNEL.RELATION.SQL');

select @currFile as file, 'RELATIONS OF TABLE displayVars' as command;
alter table displayVars add 
	foreign key ( display ) references display ( display ) 
		on delete cascade on update cascade;
alter table displayVars add 
	foreign key ( var ) references var ( var ) 
		on delete cascade on update cascade;

select @currFile as file, 'RELATIONS OF TABLE displayPannel' as command;
alter table displayPannel add 
	foreign key ( business, pos ) references pos ( business, pos ) 
		on delete cascade on update cascade;

alter table displayPannel add 
	foreign key ( currentDisplay ) references display ( display ) 
		on delete cascade on update cascade;

select @currFile as file, 'RELATIONS OF TABLE displayLabel' as command;
alter table displayLabel add 
	foreign key ( business, pos ) references displayPannel ( business, pos ) 
		on delete restrict on update cascade;


/*
set @currentMenu= 'SELECT';
select @currFile as file, concat_ws(' ', @currentMenu, 'MENU VALUES') as command;
insert into menu(menu) values (@currentMenu);
call _menuAction_new(@currentMenu, 'HOME', 'en', 'Home', 10); call _menuAction_setCaption(@currentMenu, 'HOME', 'es', 'Inicio');
call _menuAction_new(@currentMenu, 'PARENT', 'Parent', 12); call _menuAction_setCaption(@currentMenu, 'PARENT', 'es', 'Volver');
call _menuAction_new(@currentMenu, 'LOCK', 'Lock', 11); call _menuAction_setCaption(@currentMenu, 'LOCK', 'es', 'Bloqueo');
call _menuAction_new(@currentMenu, 'QTY', 'Quantity', 20); call _menuAction_setCaption(@currentMenu, 'QTY', 'es', 'Cantidad');
call _menuAction_new(@currentMenu, 'BILL', 'Bill', 30); call _menuAction_setCaption(@currentMenu, 'BILL', 'es', 'Facturar');
call _menuAction_new(@currentMenu, 'PRICE', 'Price List', 100); call _menuAction_setCaption(@currentMenu, 'PRICE', 'es', 'Lista de precios');
call _menuAction_new(@currentMenu, 'CHARGE', 'Charge', 31); call _menuAction_setCaption(@currentMenu, 'CHARGE', 'es', 'Cobrar');
call _menuAction_new(@currentMenu, 'CASHCHG', 'Cash Charge', 35); call _menuAction_setCaption(@currentMenu, 'CASHCHG', 'es', 'Efectivo');
call _menuAction_new(@currentMenu, 'CREDITCHG', 'Credit Card Charge', 36); call _menuAction_setCaption(@currentMenu, 'CREDITCHG', 'es', 'Visa');
call _menuAction_new(@currentMenu, 'NEW', 'New Invoice', 40); call _menuAction_setCaption(@currentMenu, 'NEW', 'es', 'Nuevo');
call _menuAction_new(@currentMenu, 'DELETE', 'Delete', 41); call _menuAction_setCaption(@currentMenu, 'DELETE', 'es', 'Borrar');
call _menuAction_new(@currentMenu, 'RECEIV', 'Receivables', 50); call _menuAction_setCaption(@currentMenu, 'RECEIV', 'es', 'Pte cobro');
call _menuAction_new(@currentMenu, 'DISCOUNT', 'Discount', 45); call _menuAction_setCaption(@currentMenu, 'DISCOUNT', 'es', 'Descuento');
call _menuAction_new(@currentMenu, 'CLOSED', 'Closed Sales', 51); call _menuAction_setCaption(@currentMenu, 'CLOSED', 'es', 'Facturas cobradas');
call _menuAction_new(@currentMenu, 'SALES', 'List Sales', 52); call _menuAction_setCaption(@currentMenu, 'SALES', 'es', 'Lista de facturas');
call _menuAction_new(@currentMenu, 'STATUS', 'Status', 60); call _menuAction_setCaption(@currentMenu, 'STATUS', 'es', 'Estado');
call _menuAction_new(@currentMenu, 'CASHCOUNT', 'Cash Count', 61); call _menuAction_setCaption(@currentMenu, 'CASHCOUNT', 'es', 'Arqueo');
call _menuAction_new(@currentMenu, 'REMOVE', 'Remove', 42); call _menuAction_setCaption(@currentMenu, 'REMOVE', 'es', 'Quitar');
-- call _menuAction_new(); call _menuAction_setCaption(@currentMenu, '', 'es', '');
*/


