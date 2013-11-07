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

select @currFile as file, 'PROCEDURE _mmm_xxx (  ) : (  )' as command;
drop procedure if exists _mmm_xxx$$
create procedure _mmm_xxx(


) _mmm_xxx: begin

	if not @errorNo is null then leave _mmm_xxx; end if;


end _mmm_xxx$$




