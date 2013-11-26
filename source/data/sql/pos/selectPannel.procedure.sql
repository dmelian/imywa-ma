set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'SELECTPANNEL.PROCEDURE.SQL');

delimiter $$

select @currFile as file, 'PROCEDURE _selectPannel_init ( business, pos, pageWidth )' as command$$
drop procedure if exists _selectPannel_init$$
create procedure _selectPannel_init(

	in ibusiness varchar(10),
	in ipos integer,
	in irowCount integer,
	in icolCount integer

) _selectPannel_init: begin

	if not @errorNo is null then leave _selectPannel_init; end if;

	-- TODO Check if the pos is not being used.

	update selectPannel
		set rowCount= irowCount, colCount= icolCount,
			pageWidth= irowCount * icolCount, currentPage= 0
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
	declare _maxOrder integer;
	declare _buttonCount integer;
	declare _pageWidth integer;
	declare _pageCount integer;
	declare _language varchar(3);


	if not @errorNo is null then leave _selectPannel_loadItem; end if;

	call _turn_check( ibusiness, ipos, _workDay, _turn );	
	if not @errorNo is null then leave _selectPannel_loadItem; end if;

	select currentLanguage into _language 
		from pos where business = ibusiness and pos = ipos
	;

	update selectPannel set currentGroup= igroup where business = ibusiness and pos = ipos;

	delete from selectButton where business = ibusiness and pos = ipos;

	insert into selectButton(business, pos, id, action, caption, buttonOrder, class)
		select ibusiness, ipos, itemGroup, 'group', caption.captionText, groupOrder, 'group'
			from itemGroup 
				inner join caption on itemGroup.caption = caption. caption and caption.language = _language 
			where business = ibusiness and parentGroup = igroup
	;
	
	select max(buttonOrder) + 1 into _maxOrder 
		from selectButton where business = ibusiness and pos = ipos
	;
	if _maxOrder is null then set _maxOrder= 1; end if;
	
	insert into selectButton(business, pos, id, action, caption, buttonOrder, class)
		select ibusiness, ipos, groupItems.item, 'item', caption.captionText, groupItems.itemOrder + _maxOrder, 'item'
		from groupItems inner join item on groupItems.business = item.business and groupItems.item = item.item
			inner join caption on item.caption = caption.caption and caption.language = _language
		where groupItems.business = ibusiness and groupItems.itemGroup = igroup
	;
	
	call _selectPannel_arrangeButtons( ibusiness, ipos );
	if not @errorNo is null then leave _selectPannel_loadItem; end if;
	

end _selectPannel_loadItem$$

select @currFile as file, 'PROCEDURE _selectPannel_arrangeButtons ( business, pos )' as command$$
drop procedure if exists _selectPannel_arrangeButtons$$
create procedure _selectPannel_arrangeButtons(

	in ibusiness varchar(10),
	in ipos integer

) _selectPannel_arrangeButtons: begin
	
	declare _buttonCount integer;
	declare _pageWidth integer;
	declare _viewWidth integer;
	declare _pageCount integer;
	declare _buttonsToAdd integer;
	declare _iButton integer;
	declare _maxOrder integer;
	declare _viewOrder integer;
	declare _colCount integer;
	declare _rowCount integer;	

	declare _buttonOrder integer;
	declare dsid varchar(20);
	declare notfound boolean default false;
	declare endds boolean;
	declare ds cursor for
		select id from selectButton where business = ibusiness and pos = ipos order by buttonOrder;
	declare continue handler for not found set notfound = true;

	if not @errorNo is null then leave _selectPannel_arrangeButtons; end if;

	-- view Adjust.
	
	select count(*) into _buttonCount from selectButton where business = ibusiness and pos = ipos;
	select pageWidth, rowCount, colCount into _pageWidth, _rowCount, _colCount 
		from selectPannel where business = ibusiness and pos = ipos
	;
	
	set _viewWidth= if ( _buttonCount <= _pageWidth , _pageWidth , _pageWidth - 2 );
	set _pageCount= _buttonCount div _viewWidth;
	
	set _buttonsToAdd= if ( _buttonCount mod _viewWidth > 0, _viewWidth - ( _buttonCount mod _viewWidth ) , 0 );
	if _buttonsToAdd > 0 then set _pageCount= _pageCount + 1; end if;
	
	update selectPannel
		set viewWidth= _viewWidth, pageCount= _pageCount, currentPage= 0
		where business = ibusiness and pos = ipos
	;
	
	-- Nop buttons (disabled buttons).

	select max(buttonOrder) + 1 into _maxOrder 
		from selectButton where business = ibusiness and pos = ipos
	;
	if _maxOrder is null then set _maxOrder= 1; end if;
	
	set _iButton= 0;
	while _iButton < _buttonsToAdd do
		insert into selectButton (business, pos, id, action, caption, class, buttonOrder)
			values (ibusiness, ipos, concat('NOP', _iButton), 'nop', ' -- ', 'disabled' , _maxOrder + _iButton)
		;
		set _iButton= _iButton + 1;
	end while;

	-- Reorder, rows and cols.
	
	set _buttonOrder= 0
		, _viewOrder= if (_pageCount > 1, 1 , 0)
	;

	open ds;
	repeat
		set notfound = false;
		fetch ds into dsid;
		set endds = notfound;
		if not endds then

			update selectButton
				set buttonOrder= _buttonOrder
					, col= _viewOrder mod _colCount
					, row= _viewOrder div _colCount
				where business = ibusiness and pos = ipos and id = dsid
			;

			set _buttonOrder= _buttonOrder + 1;

			if _pageCount = 1 then set _viewOrder= _buttonOrder;
			else set _viewOrder= if ( _buttonOrder mod _viewWidth = 0, 1, _viewOrder + 1);
			end if;

		end if;
	until endds end repeat;
	close ds;	

	-- pannelAction buttons.
	
	if _pageCount > 1 then
		insert into selectButton (business, pos, id, action, caption, buttonOrder, bound, row, col)
			values (ibusiness, ipos, 'PREVIOUSPAGE', 'pannelAction', 'PREVIOUS', -1, true, 0, 0)
			, (ibusiness, ipos, 'NEXTPAGE', 'pannelAction', 'NEXT', 9999, true, _rowCount - 1, _colCount - 1)
		;
	end if;
	
	
end _selectPannel_arrangeButtons$$




select @currFile as file, 'PROCEDURE _selectPannel_getButtons ( business, pos )' as command;
drop procedure if exists _selectPannel_getButtons$$
create procedure _selectPannel_getButtons(

	in ibusiness varchar(10),
	in ipos integer

) _selectPannel_getButtons: begin

	if not @errorNo is null then leave _selectPannel_getButtons; end if;

	select 'buttons' as resultId, 
		button.id, button.caption, button.amount, button.quantity, button.secondCaption
			, concat_ws(' ', button.class, concat('row', button.row), concat('col', button.col) ) as class
			, button.action, button.id as target
		
		from selectPannel as pannel inner join selectButton as button 
			on pannel.business = button.business and pannel.pos = button.pos
			
		where pannel.business = ibusiness and pannel.pos = ipos
			and ( button.buttonOrder div pannel.viewWidth = pannel.currentPage 
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

	declare _action enum( 'group', 'item', 'pannelAction', 'nop' );
	declare _id varchar(20);
	
	if not @errorNo is null then leave _selectPannel_select; end if;
	
	select id, action into _id, _action from selectButton
		where business = ibusiness and pos = ipos and id = iid
	;
	
	case _action 
		when 'group' then
			call _selectPannel_loadItem( ibusiness, ipos, _id ); 
			if not @errorNo is null then leave _selectPannel_select; end if;
		
		when 'item' then
			call pos_selectItem(ibusiness, ipos, _id );
			if not @errorNo is null then leave _selectPannel_select; end if;
			select homeGroup into _id from selectPannel where business = ibusiness and pos = ipos;
			call _selectPannel_loadItem( ibusiness, ipos, _id ); 
			if not @errorNo is null then leave _selectPannel_select; end if;
		
		when 'pannelAction' then
			case _id
				when 'PREVIOUSPAGE' then
					update selectPannel
						set currentPage= if ( currentPage > 0, currentPage - 1, pageCount - 1 )
						where business = ibusiness and pos = ipos
					;
						
				when 'NEXTPAGE' then
					update selectPannel
						set currentPage= if ( CurrentPage < pageCount - 1, currentPage + 1, 0 )
						where business = ibusiness and pos = ipos
					;
					
			end case;
			
--		else
	
	end case;
	

end _selectPannel_select$$



delimiter ;
