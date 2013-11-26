set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'ITEM.PROCEDURE.SQL');

delimiter $$

select @currFile as file, 'PROCEDURE _item_new ( business, group, item, language, caption ) : (  )' as command$$
drop procedure if exists _item_new$$
create procedure _item_new(

	in ibusiness varchar(10),
	in igroup varchar(10),
	in iitem varchar(20),
	in ilanguage varchar(3),
	in icaptionText varchar(30),
	in iVATType varchar(10)

) _item_new: begin

	declare _order integer;
	declare _caption integer;

	if not @errorNo is null then leave _item_new; end if;

	select max(itemOrder) + 1 into _order from groupItems where business = ibusiness and itemGroup = igroup;
	if _order is null then set _order = 1; end if;
	
	if not icaptionText is null	then 
		call _caption_new ( ilanguage, icaptionText, _caption );
		if not @errorNo is null then leave _item_new; end if;
	else set _caption = null;
	end if;

	insert into item( business, item, caption, VATType ) values ( ibusiness, iitem, _caption , iVATType);
	insert into groupItems ( business, itemGroup, item, itemOrder ) values ( ibusiness, igroup, iitem, _order); 

end _item_new$$


select @currFile as file, 'PROCEDURE _item_setCaption ( business, item, language, caption ) : (  )' as command$$
drop procedure if exists _item_setCaption$$
create procedure _item_setCaption(

	in ibusiness varchar(10),
	in iitem varchar(20),
	in ilanguage varchar(3),
	in icaptionText varchar(30)

) _item_setCaption: begin

	declare _caption integer;

	if not @errorNo is null then leave _item_setCaption; end if;

	select caption into _caption from item where business = ibusiness and item = iitem;

	if _caption is null	then 
		call _caption_new ( ilanguage, icaptionText, _caption );
		if not @errorNo is null then leave _item_setCaption; end if;
		update item set caption = _caption where business = ibusiness and item = iitem;

	else 
		call _caption_set ( ilanguage, _caption, icaptionText );
		if not @errorNo is null then leave _item_setCaption; end if;
	end if;


end _item_setCaption$$


select @currFile as file, 'PROCEDURE _item_setOrder ( business, group, item, order ) : (  )' as command$$
drop procedure if exists _item_setOrder$$
create procedure _item_setOrder(

	in ibusiness varchar(10),
	in igroup varchar(10),
	in iitem varchar(20),
	in iorder integer

) _item_setOrder: begin

	declare _group varchar(10);

	if not @errorNo is null then leave _item_setOrder; end if;
	
	select itemGroup into _group from groupItems where business = ibusiness and itemGroup = igroup and item = iitem;
	if _group is null then 
		insert into groupItems ( business, itemGroup, item, itemOrder ) values ( ibusiness, igroup, iitem, iorder); 
	else 
		update groupItems set itemOrder = iorder where business = ibusiness and item = iitem and itemGroup = igroup;
	end if;

	update groupItems set itemOrder = itemOrder + 1 
		where itemOrder >= iorder 
		and (business = ibusiness and itemGroup = igroup and item <> iitem)
	; 


end _item_setOrder$$



delimiter ;

