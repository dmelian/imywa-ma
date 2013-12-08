set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'POS.PROCEDURE.SQL');

delimiter $$

select @currFile as file, 'PROCEDURE pos_initialize (  ) : (  )' as command$$
drop procedure if exists pos_initialize$$
create procedure pos_initialize(


) pos_initialize: begin

	declare _selectRows integer;
	declare _selectCols integer;
	declare _menuRows integer;
	declare _menuCols integer;
	declare _displayRows integer;
	declare _displayCols integer;

	if not @errorNo is null then leave pos_initialize; end if;

	set _selectRows= 2, _selectCols= 5
		, _menuRows= 2, _menuCols= 5
		, _displayRows= 10, _displayCols= 3
	;

	call _selectPannel_init( @business, @pos, _selectRows, _selectCols );
	call _selectPannel_loadItem( @business, @pos, 'main' );
	call _menuPannel_init( @business, @pos, _menuRows, _menuCols );
	call _menuPannel_loadMenu( @business, @pos, 'SELECT' );
	call _displayPannel_init( @business, @pos, _displayRows, _displayCols );

	select 'posConfig' as resultId
		, _selectRows as selectRows, _selectCols as selectCols
		, _menuRows as menuRows, _menuCols as menuCols
		, _displayRows as displayRows, _displayCols as displayCols
	;

end pos_initialize$$

select @currFile as file, 'PROCEDURE pos_getContent (  ) : (  )' as command$$
drop procedure if exists pos_getContent$$
create procedure pos_getContent(


) pos_getContent: begin

	if not @errorNo is null then leave pos_getContent; end if;
	call _selectPannel_getButtons( @business, @pos);
	call _menuPannel_getButtons( @business, @pos);
	-- call _displayPannel_getContent( @business, @pos);


end pos_getContent$$


select @currFile as file, 'PROCEDURE pos_executeAction ( action, target ) : (  )' as command$$
drop procedure if exists pos_executeAction$$
create procedure pos_executeAction(

	in iaction varchar(10),
	in itarget varchar(20)

) pos_executeAction: begin

	if not @errorNo is null then leave pos_executeAction; end if;
	case iaction 
		when 'select' then
			call _selectPannel_select( @business, @pos, itarget );

		when 'menu' then
			call _menuPannel_select( @business, @pos, itarget );

		-- else error.
	end case;	


end pos_executeAction$$


select @currFile as file, 'PROCEDURE pos_openSession (  ) : (  )' as command$$
drop procedure if exists pos_openSession$$
create procedure pos_openSession(

) pos_openSession: begin

	declare _currentSession varchar(20);
	
	if not @errorNo is null then leave pos_openSession; end if;

	update pos set 
		currentSession= @sessionId
		where business = @business and pos = @pos
	;


end pos_openSession$$

select @currFile as file, 'PROCEDURE pos_selectItem ( business, pos, item )' as command$$
drop procedure if exists pos_selectItem$$
create procedure pos_selectItem(

	in ibusiness varchar(10),
	in ipos integer,
	in iitem varchar(20)

) pos_selectItem: begin

	declare _selectedGroup varchar(10);
	declare _presale integer;
	declare _qty integer;
	
	if not @errorNo is null then leave pos_selectItem; end if;
	
	select currentGroup into _selectedGroup from selectPannel where business = ibusiness and pos = ipos;

	select max(presale), 1 into _presale, _qty
		from presale
		-- TODO all on this.
	;

	call _presale_select( ibusiness, ipos, _presale, _selectedGroup, iitem, _qty );
	if not @errorNo is null then leave pos_selectItem; end if;
	

end pos_selectItem$$




delimiter ;

