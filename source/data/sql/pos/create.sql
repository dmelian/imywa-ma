drop database if exists amupark;
create database amupark;
use amupark;

set @fileCount= 0;

source serialno.table.sql
source presale.table.sql
source turn.table.sql 
source ticket.table.sql
source item.table.sql
source selectPannel.table.sql
source pos.table.sql
source catalog.table.sql
source business.table.sql

source serialno.relation.sql
source presale.relation.sql
source turn.relation.sql 
source ticket.relation.sql
source item.relation.sql
source selectPannel.relation.sql
source pos.relation.sql
source catalog.relation.sql
source business.relation.sql

source serialno.procedure.sql
source presale.procedure.sql
source turn.procedure.sql 
source ticket.procedure.sql
source item.procedure.sql
source selectPannel.procedure.sql
source pos.procedure.sql
source catalog.procedure.sql
source business.procedure.sql
