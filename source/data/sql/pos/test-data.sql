set @business= 'mybusiness';
set @pos= 1;
set @tariff= 'default';
set @vat= 'general';
set @mainGroup= 'main';
set @item= 1;
set @workDay= '2013/01/01';

select 'CONFIGURATION';

insert into business ( business, currentWorkDay, defaultLanguage ) values ( @business, @workDay, 'en' );
insert into pos ( business, pos, saleSerialNo, defaultTariff, mainGroup, currentTurn, status, currentLanguage ) values 
	( @business, @pos, null, @tariff, @mainGroup, 1, 'opened', 'en' )
;

insert into tariff( business, tariff ) values ( @business, @tariff );

insert into workDay ( business, workDay, opening, openUser, openPos ) values ( @business, @workDay, @workDay, 'anonymous', @pos );

insert into turn (business, pos, workDay, turn, opening, openUser)
	values ( @business, @pos, @workDay, 1, @workDay, 'anonymous')
;


insert into selectPannel ( business, pos, homeGroup ) select business, pos, @mainGroup from pos; 
insert into menuPannel ( business, pos ) select business, pos from pos; 

insert into language(language) values ('es'), ('en');

set @order= 1;
call _itemGroup_new( @business, @mainGroup, null, 'en', 'Main', @order ); set @order= @order +1;
call _itemGroup_setCaption (@business, @mainGroup, 'es', 'Principal');

insert into VATType ( VATType ) values ( @vat );

SELECT 'ITEMS';

set @group= 'A';
call _itemGroup_new( @business, @group, @mainGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );


call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;

set @group= 'B';
call _itemGroup_new( @business, @group, @mainGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;

set @group= 'C';
call _itemGroup_new( @business, @group, @mainGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;

set @group= 'D';
call _itemGroup_new( @business, @group, @mainGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;

set @group= 'E';
call _itemGroup_new( @business, @group, @mainGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;

set @group= 'F';
call _itemGroup_new( @business, @group, @mainGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;

set @group= 'G';
call _itemGroup_new( @business, @group, @mainGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;

set @group= 'GA'; 
call _itemGroup_new( @business, @group, @parentGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;


set @group= 'GB'; 
call _itemGroup_new( @business, @group, @parentGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;

set @group= 'GC'; 
call _itemGroup_new( @business, @group, @parentGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;

set @group= 'GD'; 
call _itemGroup_new( @business, @group, @parentGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;

set @group= 'GE'; 
call _itemGroup_new( @business, @group, @parentGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;

set @group= 'GF'; 
call _itemGroup_new( @business, @group, @parentGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;

set @group= 'GG'; 
call _itemGroup_new( @business, @group, @parentGroup, 'en', concat_ws(' ', 'Group', @group), @order );  set @order= @order +1;
call _itemGroup_setCaption( @business, @group, 'es', concat_ws(' ', 'Grupo', @group) );

call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;
call _item_new( @business, @group, @item, 'en', concat_ws(' ', 'Item', @item), @vat);
call _item_setCaption ( @business, @item, 'es', concat_ws(' ', 'Artículo', @item));
set @item= @item + 1;




	
select 'PRICE';
insert into price ( business, tariff, item, price )
	select @business, @tariff, item, item * 0.1 from item;


call _presale_new( @business, @pos , @presale);
