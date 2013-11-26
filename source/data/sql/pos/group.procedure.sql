set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'GROUP.PROCEDURE.SQL');

delimiter $$

select @currFile as file, 'PROCEDURE _itemGroup_new ( business, group, parent, language, caption, order ) : (  )' as command$$
drop procedure if exists _itemGroup_new$$
create procedure _itemGroup_new(

	in ibusiness varchar(10),
	in igroup varchar(10),
	in iparent varchar(20),
	in ilanguage varchar(3),
	in icaptionText varchar(30),
	in iorder varchar(10)

) _itemGroup_new: begin

	declare _caption integer;

	if not @errorNo is null then leave _itemGroup_new; end if;

	if not icaptionText is null	then 
		call _caption_new ( ilanguage, icaptionText, _caption );
		if not @errorNo is null then leave _itemGroup_new; end if;
	else set _caption = null;
	end if;

	insert into itemGroup( business, itemGroup, parentGroup, caption, groupOrder ) 
		values ( ibusiness, igroup, iparent, _caption, iorder)
	;

end _itemGroup_new$$


select @currFile as file, 'PROCEDURE _itemGroup_setCaption ( business, group, language, caption ) : (  )' as command$$
drop procedure if exists _itemGroup_setCaption$$
create procedure _itemGroup_setCaption(

	in ibusiness varchar(10),
	in igroup varchar(10),
	in ilanguage varchar(3),
	in icaptionText varchar(30)

) _itemGroup_setCaption: begin

	declare _caption integer;

	if not @errorNo is null then leave _itemGroup_setCaption; end if;

	select caption into _caption from itemGroup where business = ibusiness and itemGroup = igroup;

	if _caption is null	then 
		call _caption_new ( ilanguage, icaptionText, _caption );
		if not @errorNo is null then leave _itemGroup_setCaption; end if;
		update itemGroup set caption = _caption where business = ibusiness and itemGroup = igroup;

	else 
		call _caption_set ( ilanguage, _caption, icaptionText );
		if not @errorNo is null then leave _itemGroup_setCaption; end if;
	end if;


end _itemGroup_setCaption$$


select @currFile as file, 'PROCEDURE _itemGroup_setOrder ( business, group, order ) : (  )' as command$$
drop procedure if exists _itemGroup_setOrder$$
create procedure _itemGroup_setOrder(

	in ibusiness varchar(10),
	in igroup varchar(10),
	in iorder integer

) _itemGroup_setOrder: begin

	declare _parent varchar(10);

	if not @errorNo is null then leave _itemGroup_setOrder; end if;
	
	select parentGroup into _parent from itemGroup where business = ibusiness and itemGroup = igroup;
	update itemGroup set groupOrder = iorder where business = ibusiness and itemGroup = igroup;
	update itemGroup set groupOrder = groupOrder + 1 
		where groupOrder >= iorder 
		and (business = ibusiness and parentGroup = _parent and itemGroup <> igroup)
	; 


end _itemGroup_setOrder$$



delimiter ;

