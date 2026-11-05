
create database agritrack;
use agritrack;

-- 1. farmers
create table farmers (
    farmer_id int primary key,
    farmer_name varchar(100) not null,
    phone varchar(15) unique,
    village varchar(100) not null
);

-- 2. farms
create table farms (
    farm_id int primary key,
    farmer_id int not null,
    farm_name varchar(100) not null,
    location varchar(100) not null,
    area_acres decimal(8,2) not null,
    foreign key (farmer_id) references farmers(farmer_id),
    check (area_acres > 0)
);

-- 3. crops
create table crops (
    crop_id int primary key,
    crop_name varchar(100) not null,
    growing_season varchar(30),
    market_price_per_kg decimal(10,2) not null,
    check (market_price_per_kg >= 0)
);

-- 4. harvests
create table harvests (
    harvest_id int primary key,
    farm_id int not null,
    crop_id int not null,
    harvest_date date not null,
    quantity_kg decimal(10,2) not null,
    foreign key (farm_id) references farms(farm_id),
    foreign key (crop_id) references crops(crop_id),
    check (quantity_kg > 0)
);

-- 5. buyers
create table buyers (
    buyer_id int primary key,
    buyer_name varchar(100) not null,
    phone varchar(15) unique,
    buyer_type varchar(50)
);

-- 6. produce orders
create table produce_orders (
    order_id int primary key,
    buyer_id int not null,
    order_date date not null,
    order_status varchar(30) default 'Pending',
    foreign key (buyer_id) references buyers(buyer_id)
);

-- 7. order details
create table order_details (
    order_detail_id int primary key,
    order_id int not null,
    crop_id int not null,
    quantity_kg decimal(10,2) not null,
    price_per_kg decimal(10,2) not null,
    foreign key (order_id) references produce_orders(order_id),
    foreign key (crop_id) references crops(crop_id),
    check (quantity_kg > 0),
    check (price_per_kg >= 0)
);

-- 8. pesticides
create table pesticides (
    pesticide_id int primary key,
    farm_id int not null,
    pesticide_name varchar(100) not null,
    pesticide_type varchar(50),
    target_pest varchar(100),
    quantity_litres decimal(8,2) not null,
    price_per_litre decimal(10,2) not null,
    purchase_date date not null,
    foreign key (farm_id) references farms(farm_id),
    check (quantity_litres > 0),
    check (price_per_litre >= 0)
);

-- 9. equipment rentals
create table equipment_rentals (
    rental_id int primary key,
    farm_id int not null,
    equipment_name varchar(100) not null,
    rental_date date not null,
    return_date date,
    rental_cost decimal(10,2) not null,
    rental_status varchar(30) default 'Booked',
    foreign key (farm_id) references farms(farm_id),
    check (rental_cost >= 0),
    check (return_date is null or return_date >= rental_date)
);

-- insert data into farmers
insert into farmers values
(1, 'Ravi Kumar', '9000000001', 'Mandya'),
(2, 'Lakshmi Devi', '9000000002', 'Mysuru'),
(3, 'Suresh Gowda', '9000000003', 'Hassan'),
(4, 'Anitha Reddy', '9000000004', 'Kolar'),
(5, 'Manjunath Rao', '9000000005', 'Tumakuru');
INSERT INTO farmers
(farmer_id, farmer_name, phone, village)
VALUES
(6, 'Arjun Shetty', '9000000006', 'Bengaluru'),
(7, 'Priya Sharma', '9000000007', 'Chikkamagaluru'),
(8, 'Kiran Kumar', '9000000008', 'Dharwad'),
(9, 'Divya Gowda', '9000000009', 'Belagavi'),
(10, 'Ramesh Naik', '9000000010', 'Udupi');
select * from farmers;

-- insert data into farms
insert into farms values
(101, 1, 'Green Valley Farm', 'Mandya', 5.50),
(102, 2, 'Sunrise Farm', 'Mysuru', 8.00),
(103, 3, 'Hilltop Farm', 'Hassan', 6.25),
(104, 4, 'Golden Harvest Farm', 'Kolar', 4.00),
(105, 5, 'Riverbank Farm', 'Tumakuru', 7.50);
select * from farms;
INSERT INTO farms
(farm_id, farmer_id, farm_name, location, area_acres)
VALUES
(106, 6, 'Green Acres Farm', 'Bengaluru', 9.5),
(107, 7, 'Mountain View Farm', 'Chikkamagaluru', 6.8),
(108, 8, 'Sunshine Agriculture', 'Dharwad', 10.2),
(109, 9, 'Golden Fields Farm', 'Belagavi', 4.5),
(110, 10, 'Coastal Green Farm', 'Udupi', 7.2);


-- insert data into crops
insert into crops values
(201, 'Rice', 'Kharif', 35.00),
(202, 'Tomato', 'Winter', 28.00),
(203, 'Ragi', 'Kharif', 42.00),
(204, 'Maize', 'Summer', 25.00),
(205, 'Potato', 'Winter', 30.00);
INSERT INTO crops
(crop_id, crop_name, growing_season, market_price_per_kg)
VALUES
(206, 'Wheat', 'Winter', 32),
(207, 'Sugarcane', 'Summer', 38),
(208, 'Onion', 'Winter', 26),
(209, 'Groundnut', 'Kharif', 55),
(210, 'Millet', 'Summer', 40);
select * from crops;

-- insert data into harvests
insert into harvests values
(301, 101, 201, '2026-09-10', 1800.00),
(302, 101, 203, '2026-09-20', 900.00),
(303, 102, 202, '2026-10-05', 1200.00),
(304, 102, 205, '2026-10-12', 1500.00),
(305, 103, 204, '2026-08-25', 2000.00),
(306, 104, 202, '2026-10-15', 850.00),
(307, 105, 201, '2026-10-17', 2200.00);
INSERT INTO harvests
(harvest_id, farm_id, crop_id, harvest_date, quantity_kg)
VALUES
(308, 106, 206, '2026-10-20', 1600),
(309, 107, 207, '2026-10-21', 2500),
(310, 108, 208, '2026-10-22', 1100),
(311, 109, 209, '2026-10-23', 1800),
(312, 110, 210, '2026-10-24', 1400);

-- insert data into buyers
insert into buyers values
(401, 'Fresh Mart', '9100000001', 'Retailer'),
(402, 'City Supermarket', '9100000002', 'Supermarket'),
(403, 'Green Basket Stores', '9100000003', 'Retailer'),
(404, 'Sunrise Wholesale', '9100000004', 'Wholesaler'),
(405, 'Farm Fresh Distributors', '9100000005', 'Wholesaler');
INSERT INTO buyers
(buyer_id, buyer_name, phone, buyer_type)
VALUES
(406, 'Royal Fresh Market', '9100000006', 'Retailer'),
(407, 'National Food Supplies', '9100000007', 'Wholesaler'),
(408, 'Daily Needs Store', '9100000008', 'Retailer'),
(409, 'Agro Wholesale Center', '9100000009', 'Wholesaler'),
(410, 'Organic Basket', '9100000010', 'Retailer');

-- insert data into produce orders
insert into produce_orders values
(501, 401, '2026-10-18', 'Delivered'),
(502, 402, '2026-10-19', 'Pending'),
(503, 403, '2026-10-20', 'Delivered'),
(504, 404, '2026-10-21', 'Processing'),
(505, 401, '2026-10-22', 'Pending'),
(506, 405, '2026-10-23', 'Delivered');
INSERT INTO produce_orders
(order_id, buyer_id, order_date, order_status)
VALUES
(507, 406, '2026-10-24', 'Delivered'),
(508, 407, '2026-10-25', 'Pending'),
(509, 408, '2026-10-26', 'Processing'),
(510, 409, '2026-10-27', 'Delivered'),
(511, 410, '2026-10-28', 'Pending');

-- insert data into order details
insert into order_details values
(701, 501, 201, 200.00, 34.00),
(702, 501, 203, 100.00, 40.00),
(703, 502, 202, 300.00, 28.00),
(704, 502, 205, 150.00, 30.00),
(705, 503, 204, 400.00, 24.00),
(706, 504, 201, 500.00, 35.00),
(707, 504, 202, 200.00, 27.00),
(708, 505, 203, 250.00, 41.00),
(709, 506, 201, 600.00, 35.00);
INSERT INTO order_details
(order_detail_id, order_id, crop_id, quantity_kg, price_per_kg)
VALUES
(710, 507, 206, 300, 31),
(711, 508, 207, 500, 37),
(712, 509, 208, 250, 27),
(713, 510, 209, 400, 54),
(714, 511, 210, 350, 39);

-- insert data into pesticides
insert into pesticides values
(801, 101, 'Neem-Based Spray', 'Insecticide','Aphids', 10.00, 250.00, '2026-06-10'),
(802, 102, 'Copper Fungicide', 'Fungicide','Fungal Diseases', 8.00, 320.00, '2026-06-15'),
(803, 103, 'Bio Pest Control', 'Biopesticide','Caterpillars', 12.00, 180.00, '2026-07-01'),
(804, 104, 'Neem-Based Spray', 'Insecticide','Whiteflies', 6.00, 250.00, '2026-07-12'),
(805, 105, 'Copper Fungicide', 'Fungicide','Fungal Diseases', 9.00, 320.00, '2026-08-05');
INSERT INTO pesticides
(pesticide_id, farm_id, pesticide_name, pesticide_type,
 target_pest, quantity_litres, price_per_litre, purchase_date)
VALUES
(806, 106, 'Organic Neem Oil', 'Insecticide', 'Aphids', 8, 220, '2026-08-10'),
(807, 107, 'Sulphur Fungicide', 'Fungicide', 'Powdery Mildew', 10, 280, '2026-08-15'),
(808, 108, 'Bio Insect Control', 'Biopesticide', 'Caterpillars', 7, 190, '2026-09-01'),
(809, 109, 'Copper Shield', 'Fungicide', 'Leaf Spot', 9, 310, '2026-09-10'),
(810, 110, 'Neem Protect', 'Insecticide', 'Whiteflies', 6, 240, '2026-09-15');

-- insert data into equipment rentals
insert into equipment_rentals values
(901, 101, 'Tractor', '2026-10-01','2026-10-03', 3000.00, 'Returned'),
(902, 102, 'Rotavator', '2026-10-05','2026-10-06', 1500.00, 'Returned'),
(903, 103, 'Harvester', '2026-10-10',null, 5000.00, 'Rented'),
(904, 104, 'Tractor', '2026-10-15','2026-10-17', 3000.00, 'Returned'),
(905, 105, 'Seed Drill', '2026-10-20',null, 2000.00, 'Booked');
INSERT INTO equipment_rentals
(rental_id, farm_id, equipment_name, rental_date,
 return_date, rental_cost, rental_status)
VALUES
(906, 106, 'Tractor', '2026-10-20', '2026-10-22', 3200, 'Returned'),
(907, 107, 'Harvester', '2026-10-21', NULL, 4500, 'Rented'),
(908, 108, 'Rotavator', '2026-10-22', '2026-10-23', 1800, 'Returned'),
(909, 109, 'Seed Drill', '2026-10-24', NULL, 2200, 'Booked'),
(910, 110, 'Tractor', '2026-10-25', '2026-10-27', 3000, 'Returned');


-- show tables;

select * from farmers;
select * from farms;
select * from crops;
select * from harvests;
select * from buyers;
select * from produce_orders;
select * from order_details;
select * from pesticides;
select * from equipment_rentals;

-- select,distinct and aliases
-- 1. display all crop names and their market prices
select crop_name,market_price_per_kg from crops;
-- 2.display unique villages from the farmers table
select distinct village from farmers;
-- 3.display unique buyer types
select distinct buyer_type from buyers;
-- 4.display farm names and areas,using aliases farm and area
select farm_name as farm,area_acres as area from farms;
-- 5.display crop names and growing seasons with meaningful column aliases
select crop_name as crop,growing_season as season from crops;

-- Where Filtering 
-- 1 Display farmers who belong to Mandya.
select * from farmers;
select * from farmers where village = "Mandya";
-- 2 Display farms having an area greater than 5 acres.
select * from farms where area_acres > 5;
-- 3 Display crops with a market price greater than ₹30.
select * from crops where market_price_per_kg > 30;
-- 4 Display buyers whose type is Wholesaler.
select * from buyers where buyer_type = "wholesaler";
-- 5 Display orders having status Pending.
select * from produce_orders where order_status = 'Pending';
-- 6 Display harvests with quantities below 1000 kg.
select * from harvests where quantity_kg < 1000;
-- 7 Display equipment rentals costing more than ₹2000.
select * from equipment_rentals where rental_cost > 2000;

-- order by and limit
-- 1.display farmers in alphabetical order
select *from farmers order by farmer_name asc;
-- 2.Display crops from highest to lowest price
select *from crops order by market_price_per_kg desc;
-- 3.display the three largest farms
select *from farms order by area_acres desc limit 3;
-- 4.display the most recent five orders
select *from produce_orders order by order_date asc limit 5;
-- 5.display pesticides from highest to lowest price per litre
select pesticide_name,pesticide_type,target_pest,price_per_litre from pesticides order by price_per_litre desc;

--  Insert,update,delete
-- insert Statement
-- 1. Insert a new farmer into the farmers table.
insert into farmers (farmer_id, farmer_name, village) values (11, 'Rahul Kumar', 'Mysuru');
-- update statement
-- 2.Update the village of a particular farmer.
update Farmers set village = 'Bengaluru' where farmer_id = 1;
update farmers set email = 'farmer@0123';
update farmers
set email = case farmer_id
when 1 then 'ravi@gmail.com'
when 2 then 'lakshmi@gmail.com'
when 3 then 'suresh@gmail.com'
when 4 then 'anitha@gmail.com'
when 5 then 'manjunath@gmail.com'
when 6 then 'arjun@gmail.com'
when 7 then 'priya@gmail.com'
when 8 then 'kiran@gmail.com'
when 9 then 'divya@gmail.com'
when 10 then 'ramesh@gmail.com'
end;
-- delete statement
-- 3.Delete a particular pesticide record.
Delete from Pesticides where pesticide_id = 801;
 select * from pesticides;
 
-- alter table and Constraints
-- 1.Add an email column to the farmers table.
alter table farmers add email varchar(100);
select * from farmers;
-- 2. Modify the data type of a column.
alter table Farmers modify farmer_name varchar(150);
-- 3.Add a UNIQUE constraint to the email column.
alter table Farmers add constraint unique_email unique (email);
-- 4.Add a NOT NULL constraint to an appropriate column.
alter table Farmers modify farmer_name VARCHAR(150) not null;

-- aggregate functions
-- 1.Find the total number of farmers.alter
Select count(*) as total_farmers from farmers;
-- 2.Find the average farm area.
Select avg(area_acres) as average_farm_area from Farms;
-- 3.Find the maximum market price among crops.
select max(market_price_per_kg) as maximum_price from Crops;
-- 4.Find the minimum market price among crops.
select min(market_price_per_kg) as minimum_price from Crops;
-- 5.Calculate the total harvested quantity.
Select sum(quantity_kg) as total_harvested_quantity from Harvests;

-- Group by, Having
-- 1 display buyer types having more than one buyer.
select buyer_type, count(buyer_id) as total_buyers from buyers group by buyer_type having count(buyer_id) > 1;
-- 2 count the number of farmers in each village.
select village, count(*) as total_farmers from farmers group by village;
-- 3 display farms whose average harvest quantity is greater than 1000 kg.
select fa.farm_name, avg(h.quantity_kg) as avg_harvest from farms fa join harvests h on fa.farm_id = h.farm_id group by fa.farm_id, fa.farm_name having avg(h.quantity_kg) > 1000;
-- 4 display buyer types having more than one buyer
select buyer_type, count(*) as total_buyers from buyers group by buyer_type having count(*) > 1;


-- Joins
-- 1  Display each farmer with the names of their farms.
select * from farmers;
select * from farms;
select f.farmer_name,f.village,fa.farm_name from farmers as f join
farms as fa on f.farmer_id = fa.farmer_id;

-- 2 Display every farmer, including farmers without a farm.
select f.farmer_name,fa.farm_name  from farmers as f left join
farms as fa on f.farmer_id = fa.farmer_id;

-- 3 Display each harvest with its farm name and crop name.
select * from harvests;
select * from farms;
select * from crops;
select h.harvest_id,fa.farm_name,c.crop_name from farms as fa join harvests as h
on fa.farm_id = h.farm_id join crops as c on h.crop_id = c.crop_id; 

-- 4  Display each buyer with their order IDs and order statuses.
select p.order_id,b.buyer_name,p.order_status from buyers as b 
join produce_orders as p on b.buyer_id = p.buyer_id;

-- 5 Display every order item with its crop name, quantity, and price per kg.
select o.order_id,o.quantity_kg,o.price_per_kg,c.crop_name from order_details as o 
join crops as c on o.crop_id = c.crop_id order by order_id;

-- 6 Display farm names with their pesticide names and purchase dates.
select fa.farm_name,p.pesticide_name,p.purchase_date from farms as fa
join pesticides as p on fa.farm_id = p.farm_id; 

-- 7 Display farm names with their rented equipment and rental costs.
select fa.farm_name,e.equipment_name,e.rental_cost from farms as fa 
join equipment_rentals as e on fa.farm_id = e.farm_id;

-- 8 Display farmer names, farm names, crop names, and harvest quantities in one query.
select f.farmer_name,fa.farm_name,h.quantity_kg,c.crop_name from farmers as f
join farms as fa on f.farmer_id = fa.farmer_id 
join harvests as h on fa.farm_id = h.farm_id
join crops as c on h.crop_id = c.crop_id;

-- 9 Display buyer names, order IDs, crop names, and order item totals in one query.
select b.buyer_name,p.order_id,o.quantity_kg,o.price_per_kg,
o.quantity_kg*o.price_per_kg as order_item_total ,c.crop_name from buyers as b
join produce_orders as p on b.buyer_id = p.buyer_id 
join order_details as o on p.order_id = o.order_id
join crops as c on o.crop_id = c.crop_id;
select * from order_details;

-- 10 Use a RIGHT JOIN to display all farms and any matching harvest records.
select fa.farm_id,fa.farm_name,h.harvest_id,h.harvest_date,h.quantity_kg,h.crop_id
from harvests as h right join farms as fa on h.farm_id = fa.farm_id;

-- 11 Display farmer_name, farm_name, equipment, harvest_date, quantity_kg, crop_name
select f.farmer_name,fa.farm_name,c.crop_name,e.equipment_name,h.harvest_date,h.quantity_kg
from farmers as f join farms as fa on f.farmer_id = fa.farmer_id
join equipment_rentals as e on fa.farm_id = e.farm_id
join harvests as h on fa.farm_id = h.farm_id
join crops as c on h.crop_id = c.crop_id;

-- 12 Display farmer names, farm names, and farm locations for farms having an area greater than 5 acres. Sort by farm area in descending order.
select f.farmer_name, fa.farm_name, fa.location,fa.area_acres from farmers as f 
join farms as fa on f.farmer_id = fa.farmer_id where fa.area_acres > 5 order by fa.area_acres desc;

-- 13. Display buyer names, order IDs, and order statuses for orders whose status is Delivered. Sort by order date from newest to oldest.
select b.buyer_name, p.order_id, p.order_status from buyers as b 
join produce_orders as p
on b.buyer_id = p.buyer_id where order_status = "delivered" order by order_date desc;

-- 14. Display farm names, pesticide names, and purchase dates for pesticides purchased after July 1, 2026.
select fa.farm_name, p.pesticide_name, p.purchase_date from farms as fa 
join pesticides as p on fa.farm_id = p.farm_id where p.purchase_date > '2026-07-01';

-- 15 Display crop names, harvest quantities, and harvest dates for harvests where the quantity is greater than 1000 kg. Sort by quantity in descending order.
select c.crop_name, h.quantity_kg, h.harvest_date from crops as c 
join harvests as h on c.crop_id = h.crop_id where h.quantity_kg > 1000 order by quantity_kg desc;

-- 16. Display each farmer's name and the total number of farms owned by that farmer.
select f.farmer_id, f.farmer_name, count(fa.farm_id) as total_farms from farmers as f 
join farms as fa on f.farmer_id = fa.farmer_id group by fa.farmer_id,f.farmer_name;

-- 17. Display each buyer's name, total quantity ordered, and total order value.
select b.buyer_name,sum(o.quantity_kg) as total_quantity_ordered, 
sum(o.quantity_kg * o.price_per_kg) as total_order_value
from buyers as b join produce_orders as p on b.buyer_id = p.buyer_id
join order_details as o on p.order_id = o.order_id group by buyer_name;

-- 18. Display all farmers with their farm counts, including farmers who do not own any farms.
select f.farmer_name, count(fa.farm_id) as total_farms from farmers as f left join
farms as fa on f.farmer_id = fa.farmer_id group by f.farmer_name;

-- 19. display all crops and their matching harvest records, including crops that have never been harvested.
select * from harvests as h right join crops as c on c.crop_id = h.crop_id;

-- 20 Display all farmers and their farm names, including:
-- - Farmers who do not own any farms.
-- - Farms that do not have a matching farmer.
select f.farmer_name,fa.farm_name from farmers as f 
left join farms as fa on f.farmer_id = fa.farmer_id union all 
select f.farmer_name,fa.farm_name  from farmers as f 
right join farms as fa on f.farmer_id = fa.farmer_id;

-- 21 Display every possible combination of farmer names and crop names.
Select f.farmer_name,c.crop_name from farmers as f cross join  crops as c;

-- CASE Statements
-- 1. Display each farm name and classify its area as Small, Medium, or Large.
Select farm_name, area_acres,
CASE 
When area_acres < 5 Then 'Small'
When area_acres between 5 and 10 then 'Medium'
Else 'Large'
end as farm_category
from Farms;
-- 2.Display each order ID and classify its status as Completed or Not Completed.
Select order_id, order_status,
CASE
    When order_status = 'delivered' then 'Completed'
    else 'pending'
end as order_status
from produce_orders;
-- 3.Display each equipment rental and classify its rental cost as Budget or Expensive.
Select equipment_name, rental_cost,
CASE
    When rental_cost < 1000 then 'Budget'
    else 'Expensive'
End as rental_category
From Equipment_Rentals;

-- String Functions
-- 1.Display farmer names in uppercase.
Select upper(farmer_name) as uppercase_name from Farmers;
-- 2.Display buyer names in lowercase.
Select lower(buyer_name) as lowercase_name from Buyers;
-- 3.Find the length of each farmer's name.
Select farmer_name,length(farmer_name) as name_length from Farmers;
-- 4.Display the first three characters of every crop name.
Select crop_name,left(crop_name, 3) as first_three_characters from Crops;
-- 5.Combine farmer name and village into one column.
Select Concat(farmer_name, ' - ', village) as farmer_details from Farmers;

-- date functions
-- 1. Display the current date.
Select current_date();
-- 2.. Display the year of every harvest date.
Select harvest_date,year(harvest_date) as harvest_year from Harvests;
-- 3.Display the month of every order date.
Select order_date,month(order_date) as order_month from produce_orders;

-- Numeric functions
-- 1.Round every crop market price to the nearest integer.
Select crop_name, market_price_per_kg,round(market_price_per_kg) as rounded_price from Crops;
-- 2.Display the square of each farm's area.
Select farm_name, area_acres,power(area_acres, 2) as area_square from Farms;
-- 3.Calculate pesticide expenditure and round it to two decimal places.
Select price_per_litre,round(quantity_litres * price_per_litre, 2) as pesticide_expenditure from Pesticides;

-- Subqueries
-- 1.Display farms whose area is greater than the average farm area.
Select *from Farms where area_acres > (select avg(area_acres) from Farms);
-- 2.Display crops whose market price is greater than the average crop price.
Select *from Crops where market_price_per_kg > (select avg(market_price_per_kg) from Crops);
-- 3.Display farmers who own at least one farm.
Select *from Farmers where farmer_id in (Select farmer_id from Farms);
-- 4.Display farmers who do not own any farms.
Select *from farmers where farmer_id not in (select farmer_id from Farms where farmer_id is not null);

-- Window Functions
-- 1.Display each crop's total harvest quantity and its rank based on harvest quantity.
Select c.crop_id,c.crop_name,sum(h.quantity_kg) as total_harvest_quantity,rank() over(order by sum(h.quantity_kg) desc) as crop_rank from Crops c
join Harvests h on c.crop_id = h.crop_id group by c.crop_id, c.crop_name;
-- 2.Display harvest quantities along with the previous harvest quantity using LAG.
Select harvest_id,harvest_date,quantity_kg,lag(quantity_kg) over (order by harvest_date) as previous_harvest_quantity from Harvests;
-- 3.Display harvest quantities along with the next harvest quantity using LEAD.
Select harvest_id,harvest_date,quantity_kg,lead(quantity_kg) over (order by harvest_date) as next_harvest_quantity from Harvests;

-- AND, OR, NOT
-- 1. Display farms having an area greater than 5 acres and located in a specified location.
select * from farms where area_acres > 5 and location = "Bengaluru";
-- 2. Display crops whose market price is greater than ₹30 and growing season is Kharif.
select * from crops where market_price_per_kg > 30 and growing_season = "Kharif";
-- 3. Display buyers who are either Retailers or Wholesalers.
select * from buyers where buyer_type in ('Retailer','wholesaler');
-- 4. Display orders that are not Delivered.
select * from produce_orders where order_status not in ('delivered');
-- 5. Display harvests where quantity is greater than 1000 kg and crop ID is 201.
select * from harvests where quantity_kg > 1000 and crop_id = 201;

-- Between,in,Like,is NULL
-- 1 Display farms whose area is between 5 and 8 acres.
select farm_name, area_acres from farms where area_acres between 5 and 8;
-- 2 Display crops whose crop IDs are 201, 202, 203, 206 or 208.
select crop_id, crop_name, growing_season from crops where crop_id in (201, 202, 203, 206, 208);
-- 3 Display farmers whose names start with the letter 'a' and whose village contains the letter 'a'.
select farmer_name, village from farmers where farmer_name like 'a%' and village like '%a%';
-- 4 Display equipment names, farm IDs and rental statuses for equipment that has not yet been returned.
select equipment_name, farm_id, rental_status from equipment_rentals where return_date is null;
-- 5 Display farm names, locations and areas for farms whose area is between 5 and 10 acres, whose location is 
-- either Bengaluru, Dharwad or Udupi, and whose farm name contains the word 'farm'.
select farm_name, location, area_acres from farms
where area_acres between 5 and 10 and location in ('Bengaluru', 'Dharwad', 'Udupi')
and farm_name like '%farm%';

-- Stored Procedures
use agritrack;
-- 1 create a procedure to display all farmers
delimiter //
create procedure farmers_data()
begin
select * from farmers;
end //
delimiter ;
call farmers_data();

-- 2 create a procedure to display orders for a particular buyer id.
delimiter //
create procedure show_orders(in bid int)
begin
select * from produce_orders where buyer_id = bid;
end //
delimiter ;
call show_orders(401);

-- function
-- 1 create a function to count the total number of farmers.
delimiter //
create function count_farmers()
returns int
deterministic
begin
declare total int;
select count(*) into total from farmers;
return total;
end //
delimiter ;
select count_farmers();

-- 2 create a function to calculate the total number of crops in the crops table.
delimiter //
create function total_crops()
returns int
deterministic
begin
declare total int;
select count(*) into total from crops;
return total;
end //
delimiter ;
select total_crops();

-- Views
-- 1 create a view displaying farmer names and farm names.
create view farmer_farm as select f.farmer_name, fa.farm_name from farmers f 
join farms fa on f.farmer_id = fa.farmer_id;
select * from farmer_farm;
-- 2 create a view displaying crop names and their total harvest quantities.
create view crop_harvest_view as select c.crop_name, sum(h.quantity_kg) as total_harvest from crops c 
join harvests h on c.crop_id = h.crop_id group by c.crop_id, c.crop_name;
select * from crop_harvest_view;
-- 3 create a view displaying farm names and total pesticide expenditure.
create view farm_pesticide_view as select fa.farm_name, sum(p.quantity_litres * p.price_per_litre) as total_expenditure from farms fa 
join pesticides p on fa.farm_id = p.farm_id group by fa.farm_id, fa.farm_name;
select * from farm_pesticide_view;

-- indexes
-- 1 create an index on the farmer_name column.
create index idx_farmer_name on farmers(farmer_name);
show index  from farmers;
-- 2 create a composite index on farm_id and harvest_date in the harvests table.
create index idx_farm_harvest on harvests(farm_id, harvest_date);
show index from harvests;

-- Transactions
-- 1 insert a new farmer and commit the transaction.
start transaction;
insert into farmers (farmer_id, farmer_name, phone, village) values (12, 'sanjay kumar', '9000000011', 'belthangady');
commit;
-- 2 update a crop's market price and roll back the transaction.
start transaction;
update crops set market_price_per_kg = 50 where crop_id = 201;
rollback;
-- 3 update two crop prices, create a savepoint after the first update, and roll back the second update.
start transaction;
update crops set market_price_per_kg = 40 where crop_id = 201;
savepoint sp1;
update crops set market_price_per_kg = 60 where crop_id = 202;
rollback to sp1;
commit;
