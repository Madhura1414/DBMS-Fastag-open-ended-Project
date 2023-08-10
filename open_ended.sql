drop table toll_plaza cascade constraints;
drop table fastag cascade constraints;
drop table bank_details cascade constraints;
drop table plaza_details cascade constraints;
drop table vehicle cascade constraints;
drop table issuer_bank cascade constraints;
drop table NETC_mapper cascade constraints;
drop table acquirer_bank cascade constraints;
drop table vehicle_movement cascade constraints;
drop table transactions cascade constraints;



create table toll_plaza
(
plaza_code number(6) primary key,
p_type varchar(10),
city varchar(10),
state varchar(20),
plaza_name varchar(20)
);
   
create table fastag
(
color varchar(10) constraint pk primary key,
vehicle varchar(10)
);

create table bank_details
(
ifsc varchar(10) primary key,
bank_name varchar(20),
issuer varchar(3),
acquirer varchar(3) 
);

--drop table plaza_details;
create table plaza_details
(
plaza_code number(6)constraint fkey references toll_plaza(plaza_code)unique,
veh_type varchar(10) references fastag(color),
toll_amt number(4)unique,
acquirer varchar(10) references bank_details(ifsc),
vehicles_passed number,
primary key(plaza_code,veh_type,toll_amt)
);

create table vehicle
(VRN number(10) constraint unique_and_not_null unique not null,
model_ varchar(10),
chassis_number number(10) unique not null,
fastag_id number(10) primary key,
class_ varchar(10) references fastag(color),
issue_date date not null
);


create table issuer_bank
(ifsc varchar(10) references bank_details(ifsc)unique,
fastag_id number(10) references vehicle(fastag_id) unique,
user_name varchar(10),
phone number(10) not null unique,
account_no number(10) not null unique,
balance  number,
primary key (ifsc,fastag_id)
);

--drop table vehicle_movement cascade constraints;
create table vehicle_movement
(
plaza_code number(6),
fastag_id number(10) references vehicle(fastag_id),
toll_amt number(4,2),
time_ timestamp,
foreign key(plaza_code) references plaza_details(plaza_code),
foreign key(toll_amt) references plaza_details(toll_amt),
primary key(plaza_code, fastag_id,time_)
);

--drop table acquirer_bank cascade constraints;
create table acquirer_bank
(ifsc varchar(10) references bank_details(ifsc) unique,
plaza_code number(6),
account_no number(10) unique not null,
balance number,
foreign key(plaza_code)references plaza_details(plaza_code), 
primary key(ifsc,plaza_code)
);


create table NETC_mapper
(fastag_id number(10),
issuer_ifsc varchar(10),
status varchar(3),
bill_no number(10) primary key,
acquirer_ifsc varchar(10),
foreign key(fastag_id) references issuer_bank(fastag_id),
foreign key(issuer_ifsc) references issuer_bank(ifsc),
foreign key(acquirer_ifsc) references acquirer_bank(ifsc)
);


create table transactions
(
bill_no number(10) references NETC_mapper(bill_no),
status varchar(3),
payment_mode varchar(10)
);

desc toll_plaza;
desc fastag;
desc bank_details;
desc plaza_details;
desc vehicle;
desc issuer_bank;
desc vehicle_movement;
desc acquirer_bank;
desc NETC_mapper;
desc transactions;
 select * from toll_plaza;

insert all 
into toll_plaza values(13579, 'national', 'bangalore', 'karnataka', 'NH4 plaza')
into toll_plaza values(13243, 'national', 'dharwad', 'karnataka','vanagiri')
into toll_plaza values(25345,'state', 'pune','maharashtra','patas plaza')
into toll_plaza values(05200, 'national', 'mumbai', 'maharashtra','kini toll plaza')
into toll_plaza values(54265, 'state', 'ooty', 'tamil nadu', 'boothkudi')
into toll_plaza values(34526, 'state', 'vijaywada', 'andhra pradesh', 'nellore plaza')
select * from dual;

insert all
into fastag values('violet', 'car,jeep')
into fastag values('yellow', 'bus,truck')
into fastag values('black', 'heavy')
select * from dual;

insert all
into bank_details values('010AA', 'SBI', 'YES', 'NO')
into bank_details values('018AB', 'Axis', 'NO', 'YES')
into bank_details values('026HY', 'BOB', 'NO', 'YES')
into bank_details values('025JI', 'Axis', 'YES', 'NO')
into bank_details values('013PE', 'Canara', 'YES', 'NO')
into bank_details values('045AB', 'Yess', 'NO', 'YES')
select * from dual;


insert all
into plaza_details values(13579, 'violet', 200, '018AB', 0)
into plaza_details values(13579, 'yellow', 250, '018AB', 0)
into plaza_details values(13579, 'black', 300, '018AB', 0)
into plaza_details values(54265, 'violet', 100, '026HY', 0)
into plaza_details values(54265, 'yellow', 150, '026HY', 0)
into plaza_details values(54265, 'black', 170, '026HY', 0)
into plaza_details values(05200, 'violet', 250, '045AB', 0)
into plaza_details values(05200, 'yellow', 280, '045AB', 0)
into plaza_details values(05200, 'black', 350, '045AB', 0)
select * from dual;

insert all
into vehicle values(78888654, 'jeep suv', 7777466, 244424442, 'violet', '21-nov-2001')
into vehicle values(66654663, 'maruthi 800', 7888854, 344434443, 'violet', '14-sep-2001')
into vehicle values(82222393, 'traveller', 3339399,777733337, 'yellow', '01-jun-2002')
into vehicle values(11166633, 'hitachi', 1500008, 555533323, 'black', '08-nov-2000')
into vehicle values(7657657, 'mini bus', 3999399, 666553339, 'yellow', '21-nov-2001')
into vehicle values(44466633, 'hitachi', 1566508, 588665543, 'black', '18-aug-2003')
select * from dual;

insert all
into issuer_bank values('010AA', 344434443, 'prasad', 9998800044, 1122335544, 1500)
into issuer_bank values('025JI', 244424442 , 'asha', 9900049490, 2233445522, 1000)
into issuer_bank values('025JI', 777733337 , 'ravi', 9777336566, 4445553336, 1000)
into issuer_bank values('013PE', 555333237 , 'ram', 9888666555, 4866559996, 2000)
into issuer_bank values('010AA', 666553339 , 'ramya', 9899955466, 8866555444, 1500)
into issuer_bank values('013PE', 588665543 , 'krish', 8776443348, 6655544566, 2500)
select * from dual;

insert all
into vehicle_movement values(13579, 777733337, 250, '12-jan-2020 12:10:11')
into vehicle_movement values(13579, 588665543, 300, '12-jan-2020 12:11:10')
into vehicle_movement values(13579, 244424442, 200, '13-aug-2020 14:20:39')
into vehicle_movement values(05200, 244424442, 250, '13-aug-2020 02:20:39')
into vehicle_movement values(05200,666553339 , 280, '10-feb-2020 04:22:59')
into vehicle_movement values(13579,588665543 , 300, '10-jun-2020 04:22:59')
select * from dual;

insert all 
into acquirer_bank values('026HY', 8889990003, 54265, 208000)
into acquirer_bank values('018AB', 3339996663, 13579, 180500)
into acquirer_bank values('045AB', 5554443335, 05200, 58000)
select * from dual;

insert all 
into NETC_mapper values(588665543, '013PE', 'NO', null, '018AB')
into NETC_mapper values(666553339, '010AA', 'YES', 000001000, '045AB')
into NETC_mapper values(244424442, '025JI', 'YES', 000002000, '018AB')
into NETC_mapper values(244424442, '025JI', 'YES', 000003000, '045AB')
into NETC_mapper values(777733337, '025JI', 'YES', 000004000, '018AB')
select * from dual;

insert all
into transactions values(000002000, 'SUCCESS', 'net banking')
into transactions values(000001000, 'SUCCESS', 'UPI')
into transactions values(000003000, 'SUCCESS', 'net banking')
into transactions values(000004000, 'SUCCESS', 'UPI')
select * from dual;


--1(logical)user name, model and issue date of fastag from particular bank
select b.user_name, v.model_, v.issue_date
from issuer_bank b, vehicle v
where b.fastag_id = v.fastag_id and b.ifsc='010AA';

--2 (logical)users associated with different issuer banks 
select bank_name, user_name
from issuer_bank i, bank_details b
where b.issuer='YES' and b.ifsc=i.ifsc;

--3 ()
select b.bank_name, a.ifsc, a.plaza_code,balance
from bank_details b, acquirer_bank a
where b.acquirer='YES' and a.ifsc=b.ifsc;

--4
select plaza_name,toll_amt
from plaza_details p, toll_plaza t
where veh_type='black' and p.plaza_code=t.plaza_code;

--5
select bank_name ,count(*)
from bank_details 
group by bank_name
having count(*)>1;

--6 count the number of plaza in each state and print their names.
select t.state, count(t.plaza_name)
from toll_plaza t, toll_plaza p
where t.state=p.state
group by t.state;

--7

--drop table plaza_details;
--7 number of vehicles passed in the toll_plaza
select vm.plaza_code, count(vm.plaza_code)
from vehicle_movement vm, vehicle v, plaza_details p
where p.plaza_code=vm.plaza_code and v.class_=p.veh_type and vm.fastag_id=v.fastag_id 
group by vm.plaza_code;

--8 model of the vehicle passed through the toll_plaza
select distinct vm.plaza_code,v.model_
from vehicle_movement vm, vehicle v, plaza_details p
where p.plaza_code=vm.plaza_code and v.class_=p.veh_type and vm.fastag_id=v.fastag_id;


--9 vehicles that pass through multiple plaza
select (fastag_id) , plaza_code
from vehicle_movement
where fastag_id in (select v1.fastag_id
from vehicle_movement v1
having count(fastag_id)>1 
group by fastag_id) ;


--10same plaza multiple vehicles(clause)
select plaza_code, count(*)
from vehicle_movement
group by plaza_code;

--11 same vehicle passing through same plaza multiple times
select v1.fastag_id, v1.plaza_code
from  vehicle_movement v1,vehicle_movement v2
where v1.fastag_id=v2.fastag_id and v1.plaza_code=v2.plaza_code
having count(v1.fastag_id)>1 and count(v1.plaza_code)>1
group by v1.plaza_code, v1.fastag_id;
--and v1.fastag_id=v.fastag_id ;


--12 toll collected by each toll_plaza.
select plaza_name, balance
from toll_plaza t, acquirer_bank a
where t.plaza_code=a.plaza_code;

select * from vehicle_movement;

--13 toll collected by the plaza when vehicle passes
select vv.plaza_code,p.toll_amt, p.veh_type
from plaza_details p, vehicle_movement vv
where p.plaza_code=vv.plaza_code and vv.fastag_id=
(select v.fastag_id
from vehicle v where
v.class_=p.veh_type and v.fastag_id=vv.fastag_id);

--14 number of times a vehicle can pass through the plaza it has already passed based on account balance(nest)
select balance/toll_amt, vm.fastag_id
from plaza_details p, issuer_bank b, vehicle_movement vm
where p.plaza_code=vm.plaza_code and  vm.fastag_id=b.fastag_id and p.veh_type=
(select class_
from vehicle v
where v.class_=p.veh_type and v.fastag_id=vm.fastag_id);

--15 users who have issued fastag from their banks and date of issue
select i.user_name, b.bank_name, v.fastag_id,v.issue_date
from bank_details b, issuer_bank i, vehicle v
where b.ifsc=i.ifsc and i.fastag_id=v.fastag_id
order by b.bank_name; 

--16 plaza which are not active(clause)
select plaza_code, plaza_name
from toll_plaza
where plaza_code not in 
(select distinct plaza_code
from vehicle_movement);

--17 acquirer bank associated with multiple plazas(clause)
select a.ifsc
from acquirer_bank a
having count(a.ifsc)>1
group by a.ifsc;

--18 print users who pay by upi
select user_name, vv.model_
from issuer_bank i, vehicle_movement v,vehicle vv
where i.fastag_id=v.fastag_id and v.bill_no in
(select t.bill_no
from transactions t
where t.bill_no=v.bill_no and payment_mode='UPI')
and vv.fastag_id=i.fastag_id ;

--19 user/s who has travelled from bangalore to mumbai
select user_name, i.fastag_id
from issuer_bank i
where i.fastag_id in
(select vm.fastag_id
from vehicle_movement vm, toll_plaza t1
where i.fastag_id=vm.fastag_id and t1.plaza_code=vm.plaza_code and t1.city='bangalore')
and
fastag_id in(select v2.fastag_id
from vehicle_movement v2, toll_plaza t2
where i.fastag_id=v2.fastag_id and t2.plaza_code=v2.plaza_code and t2.city='mumbai'
);


--20 user_name and fastag_id who has travelled multiple(same or different) toll_plaza on the same day
select  distinct user_name,i.fastag_id
from issuer_bank i,vehicle_movement v1
where v1.fastag_id=i.fastag_id and(
select count(v1.fastag_id)
from vehicle_movement v2
where 
v1.fastag_id=v2.fastag_id and substr(v1.time_,1,11)=substr(v2.time_,1,11)
)>1;

--print users whose next transaction is going to fail if toll was Rs.300. print the negative balance
select user_name,balance-300
from issuer_bank  
where balance<300;


--21 user/s whose next transaction is going to fail because of less balance and print the negative balance obtained when 
--he passes through all plaza
select user_name, balance-toll_amt,p.plaza_code
from issuer_bank i, plaza_details p
where i.fastag_id in(
select vm.fastag_id
from vehicle_movement vm, vehicle v
where vm.fastag_id=v.fastag_id and v.class_=p.veh_type
having (i.balance-p.toll_amt)<0);


--flop
select p.ifsc, i.ifsc
from plaza_details p, issuer_bank i
where fastag_id in(
select vm.fastag_id
from vehicle_movement vm, vehicle v
where vm.fastag_id=v.fastag_id and v.class_=p.veh_type and i.fastag_id=v.fastag_id and i.fastag_id=vm.fastag_id);

--22 username ,phone number and vehicle of the user who has passed the toll
select phone, user_name, v.model_
from issuer_bank i, vehicle v
where v.fastag_id=i.fastag_id and  i.fastag_id in 
(select distinct vm.fastag_id
from vehicle_movement vm
where vm.fastag_id=i.fastag_id );

--23number of each type of vehicle passed through all the plaza
select class_, count(*) as number_of_vehicles
from vehicle v, vehicle_movement vm
where v.fastag_id=vm.fastag_id
group by class_;

--24 number of each type of vehicle passed through every plaza
select distinct p.plaza_code,class_, count(vm.fastag_id)
from plaza_details p, vehicle v, vehicle_movement vm
where v.fastag_id=vm.fastag_id and p.veh_type=v.class_ and vm.plaza_code=p.plaza_code
group by p.plaza_code,class_;

--25 number of fastag issued by bank on particularday
select count(*),issue_date
from vehicle
group by issue_date;

--26 user name and payment mode
select user_name, payment_mode,t.bill_no
from issuer_bank i, transactions t
where i.fastag_id in
(select fastag_id
from vehicle_movement vm
where vm.fastag_id=i.fastag_id and vm.bill_no=t.bill_no);
