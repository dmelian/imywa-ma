set @business= 'mybusiness';
set @pos= 1;
set @catalog= 'default';
set @vat= 'general';
set @mainGroup= 'main';
set @item= 1;

insert into business ( business ) values ( @business );

insert into pos ( business, pos, defaultCatalog )	values 
	( @business, @pos, @catalog )
;
insert into selectPannel ( business, pos ) select business, pos from pos; 

insert into catalog( business, catalog, mainItemGroup ) values
	( @business, @catalog, @mainGroup )
;

insert into item ( business, item, type, description ) values
	( @business, @mainGroup, 'group', 'Main' )
;

insert into VATType ( VATType ) values ( @vat );

set @group= 'A';
insert into item ( business, item, type, itemGroup, description ) values
	( @business, @group, 'group', @mainGroup, concat_ws(' ', 'Group', @group) )
;

set @order= 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;

set @group= 'B';
insert into item ( business, item, type, itemGroup, description ) values
	( @business, @group, 'group', @mainGroup, concat_ws(' ', 'Group', @group) )
;

set @order= 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;

set @group= 'C';
insert into item ( business, item, type, itemGroup, description ) values
	( @business, @group, 'group', @mainGroup, concat_ws(' ', 'Group', @group) )
;

set @order= 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;

set @group= 'D';
insert into item ( business, item, type, itemGroup, description ) values
	( @business, @group, 'group', @mainGroup, concat_ws(' ', 'Group', @group) )
;

set @order= 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;
insert into item ( business, item, type, itemGroup, itemOrder, description, VATType ) values
	( @business, @item, 'item', @group, @order, concat_ws(' ', 'Item', @item), @vat )
; set @item= @item + 1; set @order= @order + 1;

insert into price ( business, catalog, item, price )
	select @business, @catalog, item, item * 0.1 from item where type = 'item';

