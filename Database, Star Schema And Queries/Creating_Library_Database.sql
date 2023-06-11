use master 
go 

create database LIBDW
collate Greek_CI_AS;
go

use LIBDW
go

create table libdata
(bibno int,
 title varchar(200), 
 material varchar(30), 
 lang char(3),
 place varchar(40), 
 copyno char(8), 
 copyloc char(3),
 bid int, 
 bname varchar(60),
 sex char(1), 
 depcode int, 
 depname varchar(30), 
 lid int,
 loandate date
 );


BULK INSERT libdata
 FROM 'My path'
WITH (DATAFILETYPE = 'widechar', FIRSTROW =2, FIELDTERMINATOR= '|', ROWTERMINATOR = '\n');

