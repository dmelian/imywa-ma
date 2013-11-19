set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'MENUPANNEL.PROCEDURE.SQL');

delimiter $$

select @currFile as file, 'PROCEDURE _menuPannel_init ( business, pos, pageWidth )' as command$$
drop procedure if exists _menuPannel_init$$
create procedure _menuPannel_init(

	in ibusiness varchar(10),
	in ipos integer,
	in ipageWidth integer

) _menuPannel_init: begin

	if not @errorNo is null then leave _menuPannel_init; end if;

	-- TODO Check if the pos is not being used.

	update menuPannel
		set pageWidth= ipageWidth,
			currentPage= 0
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
	select pageWidth into _pageWidth from menuPannel where business = ibusiness and pos = ipos;
	
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
	
	set _buttonOrder= 0;

	open ds;
	repeat
		set notfound = false;
		fetch ds into dsid;
		set endds = notfound;
		if not endds then

			update menuButton
				set buttonOrder= _buttonOrder
				where business = ibusiness and pos = ipos and id = dsid
			;

			set _buttonOrder= _buttonOrder + 1;

		end if;
	until endds end repeat;
	close ds;	

	-- pannelAction buttons.
	
	if _pageCount > 1 then
		insert into menuButton (business, pos, id, action, caption, buttonOrder, bound)
			values (ibusiness, ipos, 'PREVPAGE', 'PNLACTION', 'PREVIOUS', -1, true)
			, (ibusiness, ipos, 'NEXTPAGE', 'PNLACTION', 'NEXT', 9999, true)
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
		button.id, button.caption, button.secondCaption, button.class,
			button.action, button.id as target
		
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
					
	
	end case;

	
end _menuPannel_select$$




delimiter ;

