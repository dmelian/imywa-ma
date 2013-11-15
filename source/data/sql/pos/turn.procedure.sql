set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'TURN.PROCEDURE.SQL');

delimiter $$


select @currFile as file, 'PROCEDURE _turn_check ( business, pos ) : ( workDay, turn )' as command$$
drop procedure if exists _turn_check$$
create procedure _turn_check(

	in ibusiness varchar(10),
	in ipos integer,
	out oworkDay date,
	out oturn integer

) _turn_check: begin

	declare _workDay date;
	declare _turn integer;

	if not @errorNo is null then leave _turn_check; end if;

	select business.currentWorkDay, pos.currentTurn into _workDay, _turn
		from business inner join pos on business.business = pos.business
		where business.business = ibusiness and pos.pos = ipos
	;

	set oworkDay= _workDay, oturn= _turn;


end _turn_check$$


delimiter ;

