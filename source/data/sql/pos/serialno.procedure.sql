set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'MMM..SQL');
set @currFile= 'SERIALNO.PROCEDURE.SQL';

delimiter $$

select @currFile as file, 'PROCEDURE _serialNo_new (no, prefix, padding, period )' as command$$
drop procedure if exists _serialNo_new$$
create procedure _serialNo_new(

	in iserialNo varchar(10),
	in iprefix varchar(10),
	in ipadding integer,
	in iperiod enum( 'none', 'year', 'month', 'week' )

) _serialNo_new: begin
	
	declare _periodFormat varchar(5);

	if not @errorNo is null then leave _serialNo_new; end if;

	select case iperiod 
		when 'none' then null
		when 'year' then '%Y'
		when 'month' then '%Y-%m'
		when 'week' then '%x-%v'
		else null end
	into _periodFormat;
	
	insert into serialNo ( serialNo, prefix, padding, period, periodFormat)
		values ( iserialNo, iprefix, ipadding, iperiod, _periodFormat ); 


end _serialNo_new$$

select @currFile as file, 'PROCEDURE _serial_next ( no, [date] ) : ( nextNo )' as command$$
drop procedure if exists _serialNo_next$$
create procedure _serialNo_next(

	in iserialNo varchar(10),
	in idate date,
	out onextNo varchar(20)

) _serialNo_next: begin

	declare _serialNo varchar(10);
    declare _prefix varchar(5);
    declare _padding integer;
    declare _periodFormat varchar(5);

	declare _period varchar(10);
    declare _counter integer;

	if not @errorNo is null then leave _serialNo_next; end if;
    
	select serialNo, prefix, padding, periodFormat 
		into _serialNo, _prefix, _padding, _periodFormat 
		from serialNo 
		where serialNo = iserialNo;
	
	if _serialNo is null then
		set onextNo= null;
		set @errorno= 'E000';
		select 'ma_error' as resultId, @errorno as errorNo, iserialNo as serialNo;
		leave _serialNo_next;
	end if;

	set _period= date_format( idate, _periodFormat );
	if _period is null then 
		set _period= '$'; set idate= null; 
	end if;

	select counter into _counter 
		from serialPeriod 
		where serialNo = _serialNo and period = _period;

	if _counter is null then
		set _counter= 1;
		insert into serialPeriod ( serialNo, period, counter ) values ( _serialNo, _period, _counter);

	else
		set _counter= _counter + 1;
		update serialPeriod set counter= _counter where serialNo = _serialNo;

	end if;
	
	set onextNo= concat( if( idate is null, _prefix , date_format( idate, _prefix ) ), lpad( _counter, _padding,'0' ) );
  
end _serialNo_next$$

delimiter ;

