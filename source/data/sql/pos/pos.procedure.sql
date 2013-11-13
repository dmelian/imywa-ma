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





delimiter ;

