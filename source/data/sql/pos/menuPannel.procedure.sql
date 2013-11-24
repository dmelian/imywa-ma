set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'MENUPANNEL.PROCEDURE.SQL');

delimiter $$

select @currFile as file, 'PROCEDURE _menuPannel_init ( business, pos, pageWidth )' as command$$
drop procedure if exists _menuPannel_init$$
create procedure _menuPannel_init(

	in ibusiness varchar(10),
	in ipos integer,
	in irowCount integer,
	in icolCount integer

) _menuPannel_init: begin

	if not @errorNo is null then leave _menuPannel_init; end if;

	-- TODO Check if the pos is not being used.

	update menuPannel
		set rowCount= irowCount, colCount= icolCount
			, pageWidth= irowCount * icolCount, currentPage= 0
		where business = ibusiness and pos = ipos
	;

end _menuPannel_init$$

select @currFile as file, 'PROCEDURE _menuPannel_loadMenu ( business, pos, menu )' as command$$
drop procedure if exists _menuPannel_loadMenu$$
create procedure _menuPannel_loadMenu(

	in ibusiness varchar(10),
	in ipos integer,
	in imenu varchar(10)

) _menuPannel_loadMenu: begin

	declare _workDay date;
	declare _turn integer;
	declare _maxOrder integer;
	declare _buttonCount integer;
	declare _pageWidth integer;
	declare _pageCount integer;


	if not @errorNo is null then leave _menuPannel_loadMenu; end if;

	call _turn_check( ibusiness, ipos, _workDay, _turn );	
	if not @errorNo is null then leave _menuPannel_loadMenu; end if;

	delete from menuButton where business = ibusiness and pos = ipos;

	insert into menuButton(business, pos, id, action, caption, buttonOrder)
		select ibusiness, ipos, action, action, caption, actionOrder
			from menuAction where menu = imenu
	;
	
	select max(buttonOrder) + 1 into _maxOrder 
		from menuButton where business = ibusiness and pos = ipos
	;
	if _maxOrder is null then set _maxOrder= 1; end if;
	
	call _menuPannel_arrangeButtons( ibusiness, ipos );
	if not @errorNo is null then leave _menuPannel_loadMenu; end if;
	

end _menuPannel_loadMenu$$

select @currFile as file, 'PROCEDURE _menuPannel_arrangeButtons ( business, pos )' as command$$
drop procedure if exists _menuPannel_arrangeButtons$$
create procedure _menuPannel_arrangeButtons(

	in ibusiness varchar(10),
	in ipos integer

) _menuPannel_arrangeButtons: begin
	
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
		select id from menuButton where business = ibusiness and pos = ipos order by buttonOrder;
	declare continue handler for not found set notfound = true;

	if not @errorNo is null then leave _menuPannel_arrangeButtons; end if;

	-- view Adjust.
	
	select count(*) into _buttonCount from menuButton where business = ibusiness and pos = ipos;
	select pageWidth, rowCount, colCount into _pageWidth, _rowCount, _colCount 
		from menuPannel where business = ibusiness and pos = ipos
	;
	
	set _viewWidth= if ( _buttonCount <= _pageWidth , _pageWidth , _pageWidth - 2 );
	set _pageCount= _buttonCount div _viewWidth;
	
	set _buttonsToAdd= if ( _buttonCount mod _viewWidth > 0, _viewWidth - ( _buttonCount mod _viewWidth ) , 0 );
	if _buttonsToAdd > 0 then set _pageCount= _pageCount + 1; end if;
	
	update menuPannel
		set viewWidth= _viewWidth, pageCount= _pageCount, currentPage= 0
		where business = ibusiness and pos = ipos
	;
	
	-- Nop buttons (disabled buttons).

	select max(buttonOrder) + 1 into _maxOrder 
		from menuButton where business = ibusiness and pos = ipos
	;
	if _maxOrder is null then set _maxOrder= 1; end if;
	
	set _iButton= 0;
	while _iButton < _buttonsToAdd do
		insert into menuButton (business, pos, id, action, caption, class, buttonOrder)
			values (ibusiness, ipos, concat('NOP', _iButton), 'nop', ' -- ', 'disabled' , _maxOrder + _iButton)
		;
		set _iButton= _iButton + 1;
	end while;

	-- Reorder.
	
	set _buttonOrder= 0
		, _viewOrder= if (_pageCount > 1, 1, 0)
	;

	open ds;
	repeat
		set notfound = false;
		fetch ds into dsid;
		set endds = notfound;
		if not endds then

			update menuButton
				set buttonOrder= _buttonOrder
					, col= _viewOrder mod _colCount
					, row= _viewOrder div _colCount
				where business = ibusiness and pos = ipos and id = dsid
			;

			set _buttonOrder= _buttonOrder + 1;

			if _pageCount = 1 then set _viewOrder= _buttonOrder;
			else set _viewOrder= if( _buttonOrder mod _viewWidth = 0, 1, _viewOrder + 1);
			end if;

		end if;
	until endds end repeat;
	close ds;	

	-- pannelAction buttons.
	
	if _pageCount > 1 then
		insert into menuButton (business, pos, id, action, caption, buttonOrder, bound, row, col)
			values (ibusiness, ipos, 'PREVPAGE', 'PNLACTION', 'PREVIOUS', -1, true, 0, 0)
			, (ibusiness, ipos, 'NEXTPAGE', 'PNLACTION', 'NEXT', 9999, true, _rowCount - 1, _colCount -1)
		;
	end if;
	
	
end _menuPannel_arrangeButtons$$




select @currFile as file, 'PROCEDURE _menuPannel_getButtons ( business, pos )' as command;
drop procedure if exists _menuPannel_getButtons$$
create procedure _menuPannel_getButtons(

	in ibusiness varchar(10),
	in ipos integer

) _menuPannel_getButtons: begin

	if not @errorNo is null then leave _menuPannel_getButtons; end if;

	select 'buttons' as resultId, 
		button.id, button.caption, button.secondCaption
			, concat_ws(' ', button.class, concat('row', button.row), concat('col', button.col) ) as class
			, button.action, button.id as target
		
		from menuPannel as pannel inner join menuButton as button 
			on pannel.business = button.business and pannel.pos = button.pos
			
		where pannel.business = ibusiness and pannel.pos = ipos
			and ( button.buttonOrder div pannel.viewWidth = pannel.currentPage 
				or button.bound
			)
			
		order by buttonOrder
	;



end _menuPannel_getButtons$$


select @currFile as file, 'PROCEDURE _menuPannel_select ( business, pos, id )' as command$$
drop procedure if exists _menuPannel_select$$
create procedure _menuPannel_select(

	ibusiness varchar(10),
	ipos integer,
	iid varchar(20)

) _menuPannel_select: begin

	declare _action varchar(10);
	declare _id varchar(20);
	declare _currentGroup varchar(10);
	declare _homeGroup varchar(10);
	
	if not @errorNo is null then leave _menuPannel_select; end if;
	
	select id, action into _id, _action from menuButton
		where business = ibusiness and pos = ipos and id = iid
	;
	
	case _id 
		when 'PREVPAGE' then
			update menuPannel
				set currentPage= if ( currentPage > 0, currentPage - 1, pageCount - 1 )
				where business = ibusiness and pos = ipos
			;
				
		when 'NEXTPAGE' then
			update menuPannel
				set currentPage= if ( CurrentPage < pageCount - 1, currentPage + 1, 0 )
				where business = ibusiness and pos = ipos
			;

		when 'HOME' then
			select currentGroup, homeGroup into _currentGroup, _homeGroup
				from selectPannel where business = ibusiness and pos = ipos
			;

			if _homeGroup = _currentGroup then
				select mainGroup into _currentGroup from pos 
					where business = ibusiness and pos = ipos
				; 
				update selectPannel set homeGroup = _currentGroup
					where business = ibusiness and pos = ipos
				;
			
			else
				set _currentGroup = _homeGroup;

			end if;

			call _selectPannel_loadItem( ibusiness, ipos, _currentGroup ); 
			if not @errorNo is null then leave _menuPannel_select; end if;

		when 'LOCK' then
			update selectPannel
				set homeGroup = currentGroup
				where business = ibusiness and pos = ipos
			;

		when 'PARENT' then
			select itemGroup.parentGroup into _currentGroup from itemGroup, selectPannel 
				where selectPannel.business = ibusiness and selectPannel.pos = ipos
					and itemGroup.business = ibusiness and itemGroup.itemGroup = selectPannel.currentGroup;
			
			call _selectPannel_loadItem( ibusiness, ipos, _currentGroup ); 
			if not @errorNo is null then leave _menuPannel_select; end if;
	
	end case;

	
end _menuPannel_select$$




delimiter ;

