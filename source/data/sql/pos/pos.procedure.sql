set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'POS.PROCEDURE.SQL');

delimiter $$

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

	declare _presale integer;
	declare _qty integer;
	
	if not @errorNo is null then leave pos_selectItem; end if;
	
	select max(presale), 1 into _presale, _qty
		from presale
		-- TODO all on this.
	;

	call _presale_select( ibusiness, ipos, _presale, iitem, _qty );
	if not @errorNo is null then leave pos_selectItem; end if;
	

end pos_selectItem$$




delimiter ;

