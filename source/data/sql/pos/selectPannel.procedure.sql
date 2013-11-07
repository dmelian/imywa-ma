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

select @currFile as file, 'PROCEDURE _selectPannel_loadItem ( business, pos, itemGroup ) : (  )' as command$$
drop procedure if exists _selectPannel_loadItem$$
create procedure _selectPannel_loadItem(

	in ibusiness varchar(10),
	in ipos integer,
	in igroup varchar(20)

) _selectPannel_loadItem: begin

	if not @errorNo is null then leave _selectPannel_loadItem; end if;

	delete from selectButton where business = ibusiness and pos = ipos;

	insert into selectButton(business, pos, id, caption, buttonOrder)
		select ibusiness, ipos, item.item, item.description, item.itemOrder
		from item inner join pos on item.business = pos.business and item.catalog = pos.catalog
		where item.business = ibusiness 
			and pos.business = ibusiness and pos.pos = ipos
			and item.itemGroup = igroup
	;
	
	call _selectPannel_orderButtons( ibusiness, ipos );
	if not @errorNo is null then leave _selectPannel_loadItem; end if;

end _selectPannel_loadItem$$

select @currFile as file, 'PROCEDURE _selectPannel_orderButtons ( business, pos ) : (  )' as command$$
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




/*
select @currFile as file, 'PROCEDURE pos_pannel_select_getButtons (  ) : (  )' as command;
drop procedure if exists pos_pannel_select_getButtons$$
create procedure pos_pannel_select_getButtons(

	in ibusiness varchar(10),
	in ipos integer

) pos_pannel_select_getButtons: begin

	declare _currentGroup varchar(20);

	if not @errorNo is null then leave pos_pannel_select_getButtons; end if;

	select 'buttons' as resultId,
		from item
		where business = ibussines
			and group = _currentGroup
			and order div _pageWidth = _currentPage;



end pos_pannel_select_getButtons$$
*/

delimiter ;
