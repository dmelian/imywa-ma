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

	if not @errorNo is null then leave _turn_check; end if;


end _turn_check$$


delimiter ;

