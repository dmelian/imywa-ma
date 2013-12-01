set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'POS.PROCEDURE.SQL');

delimiter $$

select @currFile as file, 'PROCEDURE pos_initialize (  ) : (  )' as command$$
drop procedure if exists pos_initialize$$
create procedure pos_initialize(


) pos_initialize: begin

	if not @errorNo is null then leave pos_initialize; end if;

	call _selectPannel_init( @business, @pos, 2, 4 );
	call _selectPannel_loadItem( @business, @pos, 'main' );
	call _menuPannel_init( @business, @pos, 2, 4 );
	call _menuPannel_loadMenu( @business, @pos, 'SELECT' );
	call _displayPannel_init( @business, @pos, 3, 10 );

end pos_initialize$$

select @currFile as file, 'PROCEDURE pos_getContent (  ) : (  )' as command$$
drop procedure if exists pos_getContent$$
create procedure pos_getContent(


) pos_getContent: begin

	if not @errorNo is null then leave pos_getContent; end if;
	call _selectPannel_getButtons( @business, @pos);
	call _menuPannel_getButtons( @business, @pos);
	call _displayPannel_getContent( @business, @pos);


end pos_getContent$$


select @currFile as file, 'PROCEDURE pos_executeAction ( action, target ) : (  )' as command$$
drop procedure if exists pos_executeAction$$
create procedure pos_executeAction(


) pos_executeAction: begin

	if not @errorNo is null then leave pos_executeAction; end if;


end pos_executeAction$$


select @currFile as file, 'PROCEDURE pos_openSession (  ) : (  )' as command$$
drop procedure if exists pos_openSession$$
create procedure pos_openSession(

	in ibusiness varchar(10),
	in ipos integer

) pos_openSession: begin

	declare _currentSession varchar(20);
	
	if not @errorNo is null then leave pos_openSession; end if;

	update pos set 
		currentSession= @sessionId
		where business = ibusiness and pos = ipos
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

