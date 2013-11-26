drop database if exists mybusiness;
create database mybusiness;
use mybusiness;

set @fileCount= 0;

source serialno.table.sql
source presale.table.sql
source turn.table.sql 
source sale.table.sql
source item.table.sql
source selectPannel.table.sql
source menuPannel.table.sql
source displayPannel.table.sql
source pos.table.sql
source group.table.sql
source business.table.sql
source vattype.table.sql
source workday.table.sql
source tariff.table.sql
source caption.table.sql

source serialno.relation.sql
source presale.relation.sql
source turn.relation.sql 
source sale.relation.sql
source item.relation.sql
source selectPannel.relation.sql
source menuPannel.relation.sql
source displayPannel.relation.sql
source pos.relation.sql
source group.relation.sql
source business.relation.sql
source workday.relation.sql
source tariff.relation.sql
source caption.relation.sql

source create.procedure.sql
