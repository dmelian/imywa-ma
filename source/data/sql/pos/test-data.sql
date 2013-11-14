set @business= 'mybusiness';
set @pos= 1;
set @tariff= 'default';
set @vat= 'general';
set @mainGroup= 'main';
set @item= 1;
set @workDay= '2013/01/01';

select 'CONFIGURATION';

insert into business ( business, currentWorkDay ) values ( @business, @workDay );
insert into pos ( business, pos, saleSerialNo, defaultTariff, mainGroup, currentTurn, status ) values 
	( @business, @pos, null, @tariff, @mainGroup, 1, 'opened' )
;

insert into tariff( business, tariff ) values ( @business, @tariff );

insert into workDay ( business, workDay, opening, openUser, openPos ) values ( @business, @workDay, @workDay, 'anonymous', @pos );

insert into turn (business, pos, workDay, turn, opening, openUser)
	values ( @business, @pos, @workDay, 1, @workDay, 'anonymous')
;

insert into selectPannel ( business, pos ) select business, pos from pos; 


insert into itemGroup ( business, itemGroup, description ) values
	( @business, @mainGroup, 'Main' )
;

insert into VATType ( VATType ) values ( @vat );

SELECT 'GROUP';

set @order= 1;
set @group= 'A';
insert into itemGroup ( business, itemGroup, parentGroup, description ) values
	( @business, @group, @mainGroup, concat_ws(' ', 'Group', @group) );

SELECT 'ITEMS';
	
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
set @group= 'B';
insert into itemGroup ( business, itemGroup, parentGroup, description ) values
	( @business, @group, @mainGroup, concat_ws(' ', 'Group', @group) );
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
set @group= 'C';
insert into itemGroup ( business, itemGroup, parentGroup, description ) values
	( @business, @group, @mainGroup, concat_ws(' ', 'Group', @group) );
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
set @group= 'D';
insert into itemGroup ( business, itemGroup, parentGroup, description ) values
	( @business, @group, @mainGroup, concat_ws(' ', 'Group', @group) );
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
set @group= 'E';
insert into itemGroup ( business, itemGroup, parentGroup, description ) values
	( @business, @group, @mainGroup, concat_ws(' ', 'Group', @group) );
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
set @group= 'F';
insert into itemGroup ( business, itemGroup, parentGroup, description ) values
	( @business, @group, @mainGroup, concat_ws(' ', 'Group', @group) );
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
insert into item(business, item, description, VATType) values (@business, @item, concat_ws(' ', 'Item', @item), @vat);
insert into groupItems ( business, itemGroup, item, itemOrder ) values ( @business, @group, @item, @order); 
set @item= @item + 1; set @order= @order + 1;
set @group= 'G';
insert into itemGroup ( business, itemGroup, parentGroup, description ) values
	( @business, @group, @mainGroup, concat_ws(' ', 'Group', @group) );


	
select 'PRICE';
insert into price ( business, tariff, item, price )
	select @business, @tariff, item, item * 0.1 from item;

