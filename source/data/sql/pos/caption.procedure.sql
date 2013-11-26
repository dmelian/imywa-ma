set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'CAPTION.PROCEDURE.SQL');

delimiter $$

select @currFile as file, 'PROCEDURE _caption_new ( language, captionText ) : ( caption )' as command$$
drop procedure if exists _caption_new$$
create procedure _caption_new(

	in ilanguage varchar(3),
	in icaptionText varchar(30),
	out ocaption integer

) _caption_new: begin


	if not @errorNo is null then leave _caption_new; end if;
	
	select max(caption)+1 into ocaption from caption;
	if ocaption is null then set ocaption= 1; end if;

	insert into caption( language, caption, captionText) values ( ilanguage, ocaption, icaptionText );

end _caption_new$$

select @currFile as file, 'PROCEDURE _caption_set ( language, caption, captionText ) : (  )' as command$$
drop procedure if exists _caption_set$$
create procedure _caption_set(

	in ilanguage varchar(3),
	in icaption integer,
	in icaptionText varchar(30)

) _caption_set: begin

	declare _caption integer;

	if not @errorNo is null then leave _caption_set; end if;
	
	select caption into _caption from caption where caption = icaption and language = ilanguage;
	if _caption is null then
		insert into caption (language, caption, captionText) values (ilanguage, icaption, icaptionText);
	else
		update caption set captionText= icaptionText where language = ilanguage and caption = _caption;
	end if;


end _caption_set$$

select @currFile as file, 'PROCEDURE _caption_get ( language, caption ) : ( captionText )' as command$$
drop procedure if exists _caption_get$$
create procedure _caption_get(

	in ilanguage varchar(3),
	in icaption varchar(30),
	out ocaptionText integer

) _caption_get: begin

	if not @errorNo is null then leave _caption_get; end if;
	
	select captionText into ocaptionText from caption where language = ilanguage and caption = icaption;


end _caption_get$$



delimiter ;


