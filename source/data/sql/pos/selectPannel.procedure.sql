set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'SELECTPANNEL.PROCEDURE.SQL');

delimiter $$

select @currFile as file, 'PROCEDURE _selectPannel_init ( business, pos, pageWidth )' as command$$
drop procedure if exists _selectPannel_init$$
create procedure _selectPannel_init(

	in ibusiness varchar(10),
	in ipos integer,
	in ipageWidth integer

) _selectPannel_init: begin

	if not @errorNo is null then leave _selectPannel_init; end if;

	-- TODO Check if the pos is not being used.

	update selectPannel
		set pageWidth= ipageWidth,
			currentPage= 0
		where business = ibusiness and pos = ipos
	;

end _selectPannel_init$$

select @currFile as file, 'PROCEDURE _selectPannel_loadItem ( business, pos, itemGroup )' as command$$
drop procedure if exists _selectPannel_loadItem$$
create procedure _selectPannel_loadItem(

	in ibusiness varchar(10),
	in ipos integer,
	in igroup varchar(20)

) _selectPannel_loadItem: begin

	declare _workDay date;
	declare _turn integer;
	declare _firstItemOrder integer;

	if not @errorNo is null then leave _selectPannel_loadItem; end if;

	call _turn_check( ibusiness, ipos, _workDay, _turn );	
	if not @errorNo is null then leave _selectPannel_loadItem; end if;

	delete from selectButton where business = ibusiness and pos = ipos;

	insert into selectButton(business, pos, id, type, caption, buttonOrder)
		select ibusiness, ipos, itemGroup, 'group', description, groupOrder
			from itemGroup where business = ibusiness and parentGroup = igroup
	;
	
	select max(buttonOrder) + 1 into _firstItemOrder 
		from selectButton where business = ibusiness and pos = ipos
	;
	if _firstItemOrder is null then set _firstItemOrder= 1; end if;
	
	insert into selectButton(business, pos, id, type, caption, buttonOrder)
		select ibusiness, ipos, groupItems.item, 'item', item.description, groupItems.itemOrder + _firstItemOrder
		from groupItems inner join item on groupItems.business = item.business and groupItems.item = item.item
		where groupItems.business = ibusiness and groupItems.itemGroup = igroup
	;
	
	call _selectPannel_orderButtons( ibusiness, ipos );
	if not @errorNo is null then leave _selectPannel_loadItem; end if;

end _selectPannel_loadItem$$

select @currFile as file, 'PROCEDURE _selectPannel_orderButtons ( business, pos )' as command$$
drop procedure if exists _selectPannel_orderButtons$$
create procedure _selectPannel_orderButtons(

	in ibusiness varchar(10),
	in ipos integer

) _selectPannel_orderButtons: begin

	declare _buttonOrder integer;
	declare dsid varchar(20);
	declare notfound boolean default false;
	declare endds boolean;
	declare ds cursor for
		select id from selectButton where business = ibusiness and pos = ipos order by buttonOrder;
	declare continue handler for not found set notfound = true;

	if not @errorNo is null then leave _selectPannel_orderButtons; end if;

	set _buttonOrder= 0;

	open ds;
	repeat
		set notfound = false;
		fetch ds into dsid;
		set endds = notfound;
		if not endds then

			update selectButton
				set buttonOrder= _buttonOrder
				where business = ibusiness and pos = ipos and id = dsid
			;

			set _buttonOrder= _buttonOrder + 1;

		end if;
	until endds end repeat;
	close ds;	

end _selectPannel_orderButtons$$




select @currFile as file, 'PROCEDURE _selectPannel_getButtons ( business, pos )' as command;
drop procedure if exists _selectPannel_getButtons$$
create procedure _selectPannel_getButtons(

	in ibusiness varchar(10),
	in ipos integer

) _selectPannel_getButtons: begin

	if not @errorNo is null then leave _selectPannel_getButtons; end if;

	select 'buttons' as resultId, 
		button.id, button.caption, button.amount, button.quantity, button.secondCaption,
			'selectItem' as action, button.id as target
		
		from selectPannel as pannel inner join selectButton as button 
			on pannel.business = button.business and pannel.pos = button.pos
			
		where pannel.business = ibusiness and pannel.pos = ipos
			and ( button.buttonOrder div pannel.pageWidth = pannel.currentPage 
				or button.bound
			)
			
		order by buttonOrder
	;



end _selectPannel_getButtons$$


select @currFile as file, 'PROCEDURE _selectPannel_select ( business, pos, id )' as command$$
drop procedure if exists _selectPannel_select$$
create procedure _selectPannel_select(

	ibusiness varchar(10),
	ipos integer,
	iid varchar(20)

) _selectPannel_select: begin

	declare _type enum( 'group', 'item', 'pannelAction' );
	declare _id varchar(20);
	
	if not @errorNo is null then leave _selectPannel_select; end if;
	
	select id, type into _id, _type from selectButton
		where business = ibusiness and pos = ipos and id = iid
	;
	
	case _type 
		when 'group' then
			call _selectPannel_loadItem( ibusiness, ipos, _id ); 
			if not @errorNo is null then leave _selectPannel_select; end if;
		
		when 'item' then
			select mainGroup into _id from pos where business = ibusiness and pos = ipos;
			call _selectPannel_loadItem( ibusiness, ipos, _id ); 
			if not @errorNo is null then leave _selectPannel_select; end if;
		
--		when 'pannelAction' then
			-- TODO PREVIOUS PAGE NEXT PAGE		
			
--		else
	
	end case;
	

end _selectPannel_select$$



delimiter ;
