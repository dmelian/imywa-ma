set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'DISPLAYPANNEL.PROCEDURE.SQL');


delimiter $$

select @currFile as file, 'PROCEDURE _displayPannel_init ( business, pos, pageWidth )' as command$$
drop procedure if exists _displayPannel_init$$
create procedure _displayPannel_init(

	in ibusiness varchar(10),
	in ipos integer,
	in irowCount integer,
	in icolCount integer

) _displayPannel_init: begin

	if not @errorNo is null then leave _displayPannel_init; end if;

	-- TODO Check if the pos is not being used.

	update displayPannel
		set rowCount= irowCount, colCount= icolCount
		where business = ibusiness and pos = ipos
	;

end _displayPannel_init$$


select @currFile as file, 'PROCEDURE _displayPannel_getContent ( business, pos ) : (  )' as command$$
drop procedure if exists _displayPannel_getContent$$
create procedure _displayPannel_getContent(

	in ibusiness varchar(10),
	in ipos integer

) _displayPannel_getContent: begin

	if not @errorNo is null then leave _displayPannel_getContent; end if;

	select 'display' as resultId, displayVars.row, displayVars.col, displayVars.Width
		, var.var, var.alignment, caption.captionText as caption, displayValues.varValue as displayValue
		from displayPannel 
			inner join displayValues on displayPannel.business = displayValues.business and displayPannel.pos = displayValues.pos
			inner join displayVars on displayVars.display = displayPannel.currentDisplay and displayVars.var = displayValues.var
			inner join var on displayVars.var = var.var
		where displayPannel.business = ibusiness and displayPannel.pos = ipos
		order by displayVars.row, displayVars.col
	;

end _displayPannel_getContent$$

delimiter ;


