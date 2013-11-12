set @fileCount= @fileCount + 1;
set @currFile= concat_ws(' - ', @fileCount, 'SALE.PROCEDURE.SQL');

delimiter $$

select @currFile as file, 'PROCEDURE _sale_new ( business, pos, workDay, turn, presale ) : ( ticket, saleAmount )' as command;
drop procedure if exists _sale_new$$
create procedure _sale_new(

	in ibusiness varchar(10),
	in ipos integer,
	in workDay date,
	in turn integer,
	in presale integer,
	out ticket varchar(20),
	out saleAmount double

) _sale_new: begin

	declare inextTicket varchar(20);
	declare iVATpercentage float;
	declare function_return varchar(50);

	if not @errorNo is null then leave _sale_new; end if;

	-- Generamos el nuevo ticket. Agrupamos los items y construimos las líneas de este.
	select nextSerialNumber() into inextTicket ;
	select pricesIncludeVAT*VATPercentage into iVATpercentage from pos where id=1;
	insert into ticket(	ticketNo,workDay,creationTime,description,saleAmount,discountAmount,VATAmount,totalAmount) select inextTicket,iworkday,now(),"ticket",saleAmount,discountAmount,round((saleAmount-discountAmount)*iVATpercentage,2),round((saleAmount-discountAmount)*(1+iVATpercentage),2) from sale where saleNo = isaleNo ;
	
-- 		Creamos las lineas del ticket.		
	select create_ticketLine(inextTicket,isaleNo,1) into function_return;
	
-- 		Comprobamos que se ha realizado correctamente.
	if function_return = "OK" then
		select 0 as error ,"$_ticketNo" as message, inextTicket as ticketNo;
	else
		select 1 as error, function_return as message;
	end if;



end _sale_new$$

select @currFile as file, 'PROCEDURE _sale_renew ( business, ticket, pos, workDay, turn, presale ) : ( saleAmount )' as command;
drop procedure if exists _sale_renew$$
create procedure _sale_renew(

	in ibusiness varchar(10),
	in ticket varchar(20),
	in ipos integer,
	in workDay date,
	in turn integer,
	in presale integer,
	out saleAmount double

) _sale_renew: begin

	if not @errorNo is null then leave _sale_renew; end if;



end _sale_renew$$

select @currFile as file, 'PROCEDURE _sale_charge ( business, ticket, paymentType, chargedAmount ) : ( owedAmount  )' as command;
drop procedure if exists _sale_charge$$
create procedure _sale_charge(

	in ibusiness varchar(10),
	in iticket varchar(20),
	in ipaymentType varchar(10),
	in ichargedAmount double,
	out iowedAmount double

) _sale_charge: begin

	if not @errorNo is null then leave _sale_charge; end if;

/*
	select max(version) into _version from saleVersion where saleNo=isaleNo;
	select ticketNo into iticket from saleVersion where saleNo=isaleNo and version=iversion;
	select totalAmount into itotalSale from ticket where ticketNo=iticket;

	if( ichargedAmount is null)  or (itypePayment = 'creditCard') then
-- 			select saleAmount into ichargedAmount from sale where workDay=iworkday and saleNo=isaleNo;
		set ichargedAmount = itotalSale;
	end if;
	
	update sale set state='paid' , chargedAmount=ichargedAmount , owedAmount= round(ichargedAmount-itotalSale,2) , typePayment= itypePayment where saleNo = isaleNo;

	insert into saleVersion (workDay,saleNo,version,creationTime,action,ticketNo) values (iworkday,isaleNo,iversion+1,now(),'paid',iticket);
	
	select owedAmount into iowedAmount from sale where workDay=iworkday and saleNo=isaleNo;
	
	if iowedAmount < 0 then
		select 1 as error, 'El importe entregado es menor al total' as message;
	else
		select 0 as error,"$_owedAmount" as message,iowedAmount as owedAmount;
	end if;

*/


end _sale_charge$$


delimiter ;

