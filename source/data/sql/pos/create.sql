drop database if exists amupark;
create database amupark;
use amupark;

set @fileCount= 0;

source serialno.table.sql
source presale.table.sql
source turn.table.sql 
source ticket.table.sql
source item.table.sql

source serialno.relation.sql
source presale.relation.sql
source turn.relation.sql 
source ticket.relation.sql
source item.relation.sql

source serialno.procedure.sql
source presale.procedure.sql
source turn.procedure.sql 
source ticket.procedure.sql
source item.procedure.sql


