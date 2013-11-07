set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'MMM..SQL');

-- TABLE

select @currFile as file, 'TABLE mmm' as command;
create table if not exists mmm(

	primary key (  )
) engine InnoDB, default character set utf8;


-- RELATION

select @currFile as file, 'RELATIONS OF TABLE mmm' as command;
alter table mmm add 
	foreign key (  ) references xxx (  ) 
		on delete restrict on update cascade;

-- PROCEDURE

delimiter $$

select @currFile as file, 'PROCEDURE mmm (  ) : (  )' as command$$
drop procedure if exists mmm$$
create procedure mmm(


) mmm: begin

	if not @errorNo is null then leave mmm; end if;


end mmm$$

delimiter ;

-- PROCEDURE - CURSOR

select @currFile as file, 'PROCEDURE mmm (  ) : (  )' as command$$
drop procedure if exists mmm$$
create procedure mmm(


) mmm: begin

	declare ds_ _;
	declare notfound boolean default false;
	declare endds boolean;
	declare ds cursor for
		select _;
	declare continue handler for not found set notfound = true;

	if not @errorNo is null then leave mmm; end if;

	open ds;
	repeat
		set notfound = false;
		fetch ds into ds_;
		set endds = notfound;
		if not endds then




		end if;
	until endds end repeat;
	close ds;	

end mmm$$


