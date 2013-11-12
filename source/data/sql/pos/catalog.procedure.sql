set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'CATALOG.PROCEDURE.SQL');

delimiter $$

delimiter ;
