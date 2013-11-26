set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'POS.TABLE.SQL');

select @currFile as file, 'TABLE pos' as command;
create table if not exists pos(
	business varchar(10) not null,
	pos integer not null,
	saleSerialNo varchar(10),
	status enum( 'opened', 'closed', 'locked' ),
	defaultTariff varchar(10),
	mainGroup varchar(10),
	currentSession varchar(20),
	currentTurn integer,
	currentLanguage varchaR(3),

	primary key ( business, pos )
) engine InnoDB, default character set utf8;



