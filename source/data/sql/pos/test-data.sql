set @business= 'amupark';
set @pos= 1;
set @catalog= 'default';
set @vat= 'general';
set @mainGroup= 'main';
set @item= 1;

insert into pos ( business, pos, catalog )	values 
	( @business, @pos, @catalog )
;
insert into selectPannel ( business, pos ) select business, pos from pos; 


insert into item ( business, item, catalog, type, description ) values
	( @business, @mainGroup, @catalog, 'group', 'Main' )
;

set @group= 'A';
insert into item ( business, item, catalog, type, itemGroup, description ) values
	( @business, @group, @catalog, 'group', @mainGroup, concat_ws(' ', 'Group', @group) )
;

set @order= 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;

set @group= 'B';
insert into item ( business, item, catalog, type, itemGroup, description ) values
	( @business, @group, @catalog, 'group', @mainGroup, concat_ws(' ', 'Group', @group) )
;

set @order= 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;

set @group= 'C';
insert into item ( business, item, catalog, type, itemGroup, description ) values
	( @business, @group, @catalog, 'group', @mainGroup, concat_ws(' ', 'Group', @group) )
;

set @order= 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;

set @group= 'D';
insert into item ( business, item, catalog, type, itemGroup, description ) values
	( @business, @group, @catalog, 'group', @mainGroup, concat_ws(' ', 'Group', @group) )
;

set @order= 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, catalog, type, itemGroup, itemOrder, description, price, VATType ) values
	( @business, @item, @catalog, 'item', @group, @order, concat_ws(' ', 'Item', @item), @item * 0.1, @vat )
; set @item= @item + 1; set @order= @order + 1;

