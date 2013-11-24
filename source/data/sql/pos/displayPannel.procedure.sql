set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'DISPLAYPANNEL.PROCEDURE.SQL');


delimiter $$

select @currFile as file, 'PROCEDURE mmm (  ) : (  )' as command$$
drop procedure if exists mmm$$
create procedure mmm(


) mmm: begin

	if not @errorNo is null then leave mmm; end if;


end mmm$$

delimiter ;


