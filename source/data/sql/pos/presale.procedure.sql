set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'PRESALE.PROCEDURE.SQL');

delimiter $$

select @currFile as file, 'PROCEDURE _presale_new ( business, pos )' as command;
drop procedure if exists _presale_new$$
create procedure _presale_new(

	in ibusiness varchar(10),
	in ipos integer,
	out opresale integer

) _presale_new: begin

	declare _workDay date;
	declare _turn integer;
	declare _presale integer;

	if not @errorNo is null then leave _presale_new; end if;

	call _turn_check( ibusiness, ipos, _workDay, _turn );	
	if not @errorNo is null then leave _presale_new; end if;

	select max(presale) into _presale 
		from presale
		where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn
	;
	if _presale is null then set _presale = 1;
	else set _presale = _presale + 1;
	end if;

	insert into presale ( business, pos, workDay, turn, presale, state ) 
		values ( _business, _pos, _workDay, _turn, _presale, 'draft' )
	;

	insert into presaleVersion (  business, pos, workDay, turn, presale, version, creationTime, action ) 
		values ( _business, _pos, _workDay, _turn, _presale, 1, now(), 'new' )
	;
	
	set opresale= _presale;

end _presale_new$$


select @currFile as file, 'PROCEDURE _presale_bill ( business, pos, presale )' as command;
drop procedure if exists _presale_bill$$
create procedure _presale_bill(

	in ibusiness varchar(10),	
	in ipos integer,
	in ipresale integer

) _presale_bill: begin

	declare _workday date;
	declare _turn integer;
	declare _presale integer;
	declare _state enum('draft', 'deleted', 'billed', 'revising', 'annulled', 'charged');
	declare _ticket varchar(20);
	declare _version integer;

	if not @errorNo is null then leave _presale_bill; end if;
	
	call _turn_check( ibusiness, ipos, _workDay, _turn );	
	if not @errorNo is null then leave _presale_bill; end if;

	select presale, state into _presale, _state
		from presale
		where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn and presale = ipresale
	;
	
	if _presale is null then
		set @errorno= 'E030';
		select 'ma_error' as resultId, @errorno as errorNo, ibusiness as business, ipos as pos, _workDay as workDay, _turn as turn, ipresale as presale;
		leave _presale_bill;
	end if;
	if _state <> 'draft' or _state <> 'revising' then
		set @errorno= 'E031';
		select 'ma_error' as resultId, @errorno as errorNo, ibusiness as business, ipos as pos, _workDay as workDay, _turn as turn, ipresale as presale, _status as status;
		leave _presale_bill;
	end if;

	call _presale_calcAmounts( ibusiness, ipos, _workDay, _turn, _presale );

	if _state = 'draft' then
		call _ticket_new( ibusiness, ipos, _workDay, _turn, _presale, _ticket );
		if not @errorNo is null then leave _presale_bill; end if;
	else -- state = revising
		call _ticket_renew( ibusiness, _ticket, ipos, _workDay, _turn, _presale );
		if not @errorNo is null then leave _presale_bill; end if;
	end if;		

	select max(version) + 1 into _version 
		from presaleVersion 
		where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn and presale = _presale
	;

	insert into presaleVersion ( business, pos, workDay, turn, presale, version, creationTime, action ) 
		values ( ibusiness, ipos, _workDay, _turn, _presale, _version, now(), 'bill' )
	;

	update presale 
		set state= 'billed',
			ticketNo= _ticket
		where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn and presale = _presale
	;
	
end _presale_bill$$

select @currFile as file, 'PROCEDURE _presale_calcAmounts ( business, pos, workDay, turn, presale )' as command;
-- TODO: ¿ AMOUNTS AND DISCOUNTS ?
drop procedure if exists _presale_calcAmounts$$
create procedure _presale_calcAmounts(

	in ibusiness varchar(10),
	in ipos integer,
	in iworkDay date,
	in iturn integer,
	in ipresale integer

) begin

/*	update presale set 
		state= 'billed',
		discountAmount= round( discount * saleAmount, 2 ) -- TODO: ¿ Discount ? put calculated amounts on a auxiliary procedure.
		where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn and presale = _presale
	;
*/

end$$


select @currFile as file, 'PROCEDURE _presale_charge ( business, pos, presale, paymentType, chargedAmount ) : ( owedAmount )' as command;
drop procedure if exists _presale_charge$$
create procedure _presale_charge(

	in business varchar(10),
	in ipos integer,
	in ipresale integer,
	in ipaymentType varchar(10),
	in ichargedAmount double,
	out oowedAmount double

) _presale_charge: begin
	
	declare _workday date;
	declare _turn integer;
	declare _presale integer;
	declare _state enum( 'draft', 'deleted', 'billed', 'revising', 'annulled', 'charged' );
	declare _version integer;
	declare _ticket varchar(20);
	declare _owedAmount double;
	declare _saleAmount double;

	if not @errorNo is null then leave _presale_charge; end if;

	call _turn_check( ibusiness, ipos, _workDay, _turn );	
	if not @errorNo is null then leave _presale_charge; end if;

	call _presale_calcAmounts( ibusiness, ipos, _workDay, _turn, _presale );

	select presale, state, ticketNo into _presale, _state, _ticket
		from presale
		where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn and presale = ipresale
	;
	
	if _presale is null then
		set @errorno= 'E030';
		select 'ma_error' as resultId, @errorno as errorNo, ibusiness as business, ipos as pos, _workDay as workDay, _turn as turn, ipresale as presale;
		leave _presale_charge;
	end if;
	if _state <> 'billed' then
		set @errorno= 'E032';
		select 'ma_error' as resultId, @errorno as errorNo, ibusiness as business, ipos as pos, _workDay as workDay, _turn as turn, ipresale as presale, _status as status;
		leave _presale_charge;
	end if;

	call _ticket_charge ( ibusiness, _ticket, ipaymentType, ichargedAmount, _owedAmount);

	select max(version) + 1 into _version 
		from presaleVersion 
		where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn and presale = _presale
	;

	insert into presaleVersion ( business, pos, workDay, turn, presale, version, creationTime, action ) 
		values ( ibusiness, ipos, _workDay, _turn, _presale, _version, now(), 'charge' )
	;

	update presale 
		set state= 'charged',
			chargedAmount= ichargedAmount,			
			owedAmount= _owedAmount			
		where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn and presale = _presale
	;

	set oowedAmount= _owedAmount;
	
end _presale_charge$$

select @currFile as file, 'PROCEDURE _presale_delete ( pos, workDay, presale )' as command;
drop procedure if exists _presale_delete$$
create procedure _presale_delete(

	in ipos varchar(10),
	in iworkDay date,
	in ipresale integer

) _presale_delete: begin
	

	if not @errorNo is null then leave _presale_delete; end if;


end _presale_delete$$

select @currFile as file, 'PROCEDURE _presale_revise ( business, pos, presale )' as command;
drop procedure if exists _presale_revise$$
create procedure _presale_revise(

	in ipos varchar(10),
	in ipresale integer

) _presale_revise: begin
	

	if not @errorNo is null then leave _presale_revise; end if;


end _presale_revise$$

select @currFile as file, 'PROCEDURE _presale_select ( business, pos, presale, item, qty )' as command;
drop procedure if exists _presale_select$$
create procedure _presale_select(

	in ibusiness varchar(10),	
	in ipos integer,
	in ipresale integer,
	in item varchar(20),
	in iqty float

) _presale_select: begin

	declare _workday date;
	declare _turn integer;
	declare _state enum('draft', 'deleted', 'billed', 'revising', 'annulled', 'charged');
	declare _presale integer;
	declare _lineNo integer;
	declare _version integer;
	declare _price double;


	if not @errorNo is null then leave _presale_select; end if;

	call _turn_check( ibusiness, ipos, _workDay, _turn );	
	if not @errorNo is null then leave _presale_select; end if;

	select presale, state into _presale, _state
		from presale
		where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn and presale = ipresale
	;
	
	if _presale is null then
		set @errorno= 'E030';
		select 'ma_error' as resultId, @errorno as errorNo, ibusiness as business, ipos as pos, _workDay as workDay, _turn as turn, ipresale as presale;
		leave _presale_select;
	end if;
	if _state <> 'draft' or _state <> 'revising' then
		set @errorno= 'E031';
		select 'ma_error' as resultId, @errorno as errorNo, ibusiness as business, ipos as pos, _workDay as workDay, _turn as turn, ipresale as presale, _status as status;
		leave _presale_select;
	end if;

	select max(version) into _version 
		from presaleVersion 
		where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn and presale = _presale
	;

	-- Group lines by item (or not)
	select lineNo into _lineNo 
		from presaleLine
		where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn and presale = _presale
			and version = _version and item = iitem;

		update presaleLine
			set creationTime= now(),
				quantity= quantity + iqty
			where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn and presale = _presale
				and lineNo = _lineNo
		;

	if _lineNo is null then 

		select max(lineNo) into _lineNo from presaleLine 
			where business = ibusiness and pos = ipos and workDay = _workDay and turn = _turn and presale = _presale
		;
		if _lineNo is null then set _lineNo = 1;
		else set _lineNo = _lineNo + 1;
		end if;

		select price into _price 
			from item
			where business = ibusiness and item = iitem
		; -- TODO: Check the price first for another line in the ticket and second from the item table.

		insert into presaleLine ( business, pos, workDay, turn, presale, version, lineNo, creationTime, item, quantity, price, listPrice )
			values ( iworkday, ipos, _workDay, _turn, _presale, _version, _lineNo, now(), iitem, iqty, iprice, iprice );

	end if;
		
	-- TODO: Check negative total qtys for a item, and rigths for do it. 	

-- select item, sum(quantity),sum(price) from saleLine where saleNo=0 group by item having sum(quantity) > 0;

end _presale_select$$


/*
drop procedure if exists sale_delete$$
create procedure sale_delete()
begin
	declare isaleNo integer;
	declare iworkday date;
	declare iversion integer;

	select workDay into iworkday from pos where id=1;
	select max(saleNo) into isaleNo from sale where workDay=iworkday and state='draft';
	
	if isaleNo is null then
		select 1 as error, 'La venta no puede eliminarse' as message;
	else
		update sale set state='deleted' where saleNo = isaleNo;
		select max(version) into iversion from saleVersion where saleNo=isaleNo;
		insert into saleVersion (workDay,saleNo,version,creationTime,action) values (iworkday,isaleNo,iversion+1,now(),'delete');
		select 0 as error;
	end if;
end$$


drop procedure if exists sale_revise$$
create procedure sale_revise()
begin
	declare isaleNo integer;
	declare iworkday date;
	declare iversion integer;
	declare inextTicket varchar(20);
	declare function_return varchar(50);
	declare iVATpercentage float;
	
	select workDay into iworkday from pos where id=1;
	select max(saleNo) into isaleNo from sale where workDay=iworkday and state='billed';
	
	if isaleNo is null then
		select 1 as error, 'La venta no puede revisarse' as message;
	else
		update sale set state='revised' where saleNo = isaleNo;
		select pricesIncludeVAT*VATPercentage into iVATpercentage from pos where id=1;
		
		select nextSerialNumber() into inextTicket ;
		insert into ticket(	ticketNo,workDay,creationTime,description,saleAmount,discountAmount,VATAmount,totalAmount) select inextTicket,iworkday,now(),"ticket inverso.Revision",-1*saleAmount,discountAmount,-1*round((saleAmount-discountAmount)*iVATpercentage,2),-1*round((saleAmount-discountAmount)*(1+iVATpercentage),2) from sale where saleNo = isaleNo ;

		
		select max(version) into iversion from saleVersion where saleNo=isaleNo;
		insert into saleVersion (workDay,saleNo,version,creationTime,action,ticketNo) values (iworkday,isaleNo,iversion+1,now(),'revise',inextTicket);
		
-- 		Creamos las lineas del ticket inverso.
		select create_ticketLine(inextTicket,isaleNo,-1) into function_return;
		
-- 		Comprobamos que se ha realizado correctamente.
		if function_return = "OK" then
			select 0 as error ,"$_ticketNo" as message, inextTicket as ticketNo;
		else
			select 1 as error, function_return as message;
		end if;		
	end if;
end$$



drop procedure if exists sale_annull$$
create procedure sale_annull(
	in ireason varchar(15)
	)
begin
	declare isaleNo integer;
	declare iworkday date;
	declare iversion integer;
	declare inextTicket varchar(20);
	declare function_return varchar(50);
	
	select workDay into iworkday from pos where id=1;
	select max(saleNo) into isaleNo from sale where workDay=iworkday and state='paid';
	
	if isaleNo is null then
		select 1 as error, 'La venta no puede anularse' as message;
	else
		select max(version) into iversion from saleVersion where saleNo=isaleNo;
		update sale set state='anulled' where saleNo = isaleNo;
		
		select nextSerialNumber() into inextTicket ;
		insert into ticket(ticketNo,workDay,creationTime,description,saleAmount,discountAmount,VATAmount,totalAmount) select inextTicket,iworkday,now(),"ticket inverso.Anulacion",-1*saleAmount,discountAmount,-1*round((saleAmount-discountAmount)*iVATpercentage,2),-1*round((saleAmount-discountAmount)*(1+iVATpercentage),2) from sale where saleNo = isaleNo ;

		
		select max(version) into iversion from saleVersion where saleNo=isaleNo;
		insert into saleVersion (workDay,saleNo,version,creationTime,action,ticketNo,reason) values (iworkday,isaleNo,iversion+1,now(),'annul',inextTicket,ireason);
		
-- 		Creamos las lineas del ticket inverso.
		select create_ticketLine(inextTicket,isaleNo,-1) into function_return;
		
-- 		Comprobamos que se ha realizado correctamente.
		if function_return = "OK" then
			select 0 as error ,"$_ticketNo" as message, inextTicket as ticketNo;
		else
			select 1 as error, function_return as message;
		end if;
	end if;
	
end$$

-- select item, sum(quantity),sum(price) from saleLine where saleNo=0 group by item having sum(quantity) > 0;

*/

delimiter ;


