create database ecommerce_db;

use ecommerce_db;

create table users (
    user_id int auto_increment primary key,
    name varchar(100) not null,
    email varchar(100) unique not null,
    password varchar(255) not null,
    phone varchar(15),
    address text,
    created_at timestamp default current_timestamp
);

create table products (
    product_id int auto_increment primary key,
    name varchar(100) not null,
    description text,
    price decimal(10,2) not null check (price >= 0),
    stock int default 0 check (stock >= 0),
    category_id int,
    created_at timestamp default current_timestamp
);

create table categories (
    category_id int auto_increment primary key,
    name varchar(50) not null,
    description text
);

create table orders (
    order_id int auto_increment primary key,
    user_id int not null,
    order_date timestamp default current_timestamp,
    status enum('pending', 'processing', 'shipped', 'delivered', 'cancelled') default 'pending',
    total decimal(10,2) not null,
    foreign key (user_id) references users(user_id)
);

create table order_items (
    order_item_id int auto_increment primary key,
    order_id int not null,
    product_id int not null,
    quantity int not null,
    price decimal(10, 2) not null,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

create table payments (
    payment_id int auto_increment primary key,
    order_id int not null,
    amount decimal(10, 2) not null,
    payment_date timestamp default current_timestamp,
    method enum('credit card', 'paypal', 'bank transfer') not null,
    status enum('pending', 'completed', 'failed') default 'pending',
    foreign key (order_id) references orders(order_id)
);

create table product_reviews (
    review_id int auto_increment primary key,
    product_id int not null,
    user_id int not null,
    rating int check(rating between 1 and 5),
    comment text,
    review_date timestamp default current_timestamp,
    foreign key (product_id) references products(product_id),
    foreign key (user_id) references users(user_id)
);

create table cart (
    cart_id int auto_increment primary key,
    user_id int not null,
    created_at timestamp default current_timestamp,
    foreign key (user_id) references users(user_id)
);

create table cart_items (
    cart_item_id int auto_increment primary key,
    cart_id int not null,
    product_id int not null,
    quantity int not null,
    foreign key (cart_id) references cart(cart_id),
    foreign key (product_id) references products(product_id)
);

-- insert values

insert into categories (name, description) values
('electronics', 'gadgets and electronic devices including smartphones, tvs, and laptops.'),
('clothing', 'apparel for men, women, and children including shirts, jackets, and shoes.'),
('books', 'printed and digital books across various genres and topics.'),
('home appliances', 'appliances and gadgets for household use, like blenders and microwaves.'),
('beauty', 'personal care and beauty products including skincare and cosmetics.'),
('fitness', 'fitness and exercise equipment like yoga mats, dumbbells, and resistance bands.');

insert into products (name, description, price, stock, category_id) values
('wireless earbuds', 'bluetooth 5.0 wireless earbuds with noise cancellation.', 29.99, 150, 1),
('smartphone', 'latest model with 6.5" screen and 128gb storage.', 699.99, 45, 1),
('laptop', 'lightweight laptop with 15.6" display and 8gb ram.', 899.99, 25, 1),
('4k tv', '55" 4k ultra hd smart tv with hdr.', 499.99, 30, 1),
('smartwatch', 'waterproof smartwatch with heart rate monitor.', 199.99, 75, 1),
('denim jacket', 'classic blue denim jacket, unisex style.', 59.99, 200, 2),
('graphic t-shirt', 'cotton t-shirt with printed design.', 19.99, 300, 2),
('running shoes', 'breathable and lightweight running shoes.', 89.99, 120, 2),
('leather belt', 'genuine leather belt in black and brown.', 24.99, 100, 2),
('sweater', 'warm wool sweater in assorted colors.', 39.99, 180, 2),
('cookbook', 'easy recipes for every day cooking.', 14.99, 200, 3),
('science fiction novel', 'an epic space adventure novel.', 9.99, 100, 3),
('children''s story book', 'illustrated story book for children.', 12.99, 250, 3),
('business guide', 'a guide on starting and managing a small business.', 29.99, 70, 3),
('self-help book', 'tips for personal growth and improvement.', 17.99, 150, 3),
('blender', 'high-speed blender for smoothies and more.', 79.99, 60, 4),
('microwave oven', '900w microwave with digital controls.', 149.99, 40, 4),
('vacuum cleaner', 'cordless vacuum cleaner with powerful suction.', 199.99, 30, 4),
('air purifier', 'hepa air purifier for cleaner indoor air.', 129.99, 80, 4),
('coffee maker', '12-cup coffee maker with programmable timer.', 49.99, 90, 4),
('moisturizer', 'hydrating face moisturizer for all skin types.', 19.99, 150, 5),
('shampoo', 'natural shampoo for all hair types.', 8.99, 200, 5),
('lipstick', 'long-lasting matte lipstick in multiple shades.', 12.99, 80, 5),
('sunscreen', 'spf 50 sunscreen for daily protection.', 15.99, 120, 5),
('face wash', 'gentle foaming face wash.', 9.99, 140, 5),
('yoga mat', 'eco-friendly yoga mat with non-slip surface.', 24.99, 150, 6),
('dumbbell set', 'adjustable dumbbell set for strength training.', 79.99, 100, 6),
('resistance bands', 'set of resistance bands for workouts.', 14.99, 200, 6),
('treadmill', 'electric treadmill with multiple speed options.', 599.99, 20, 6),
('water bottle', 'stainless steel insulated water bottle.', 15.99, 250, 6);

insert into users (name, email, password, phone, address) values
('alice johnson', 'alice.johnson@example.com', 'password_hash_1', '123-456-7890', '123 maple street, springfield, il'),
('bob smith', 'bob.smith@example.com', 'password_hash_2', '234-567-8901', '456 oak avenue, greenfield, ca'),
('cathy brown', 'cathy.brown@example.com', 'password_hash_3', '345-678-9012', '789 pine road, rivertown, tx'),
('david wilson', 'david.wilson@example.com', 'password_hash_4', '456-789-0123', '321 cedar blvd, lakeview, ny'),
('eva adams', 'eva.adams@example.com', 'password_hash_5', '567-890-1234', '654 birch lane, mountville, az'),
('frank taylor', 'frank.taylor@example.com', 'password_hash_6', '678-901-2345', '987 walnut drive, bayside, fl'),
('grace lee', 'grace.lee@example.com', 'password_hash_7', '789-012-3456', '258 elm street, sunfield, oh'),
('henry martinez', 'henry.martinez@example.com', 'password_hash_8', '890-123-4567', '369 cherry court, westtown, ga'),
('ivy garcia', 'ivy.garcia@example.com', 'password_hash_9', '901-234-5678', '147 aspen ave, northwood, ma'),
('jack white', 'jack.white@example.com', 'password_hash_10', '012-345-6789', '963 maple circle, eastvale, co'),
('karen hall', 'karen.hall@example.com', 'password_hash_11', '123-456-7890', '789 willow way, brookfield, or'),
('leo clark', 'leo.clark@example.com', 'password_hash_12', '234-567-8901', '456 juniper blvd, riverdale, nj'),
('mia lewis', 'mia.lewis@example.com', 'password_hash_13', '345-678-9012', '123 redwood street, fairview, wa'),
('nina robinson', 'nina.robinson@example.com', 'password_hash_14', '456-789-0123', '654 poplar ave, hillside, ut'),
('oscar wright', 'oscar.wright@example.com', 'password_hash_15', '567-890-1234', '321 magnolia lane, seaview, nv'),
('paul walker', 'paul.walker@example.com', 'password_hash_16', '678-901-2345', '987 beech rd, midvale, mt'),
('quinn young', 'quinn.young@example.com', 'password_hash_17', '789-012-3456', '258 palm blvd, clearfield, ne'),
('rachel king', 'rachel.king@example.com', 'password_hash_18', '890-123-4567', '369 fir lane, pleasantville, ky'),
('sam scott', 'sam.scott@example.com', 'password_hash_19', '901-234-5678', '147 dogwood drive, brightville, sd'),
('tina green', 'tina.green@example.com', 'password_hash_20', '012-345-6789', '963 hickory circle, sunnydale, id');

insert into product_reviews (user_id, product_id, rating, comment) values
(1, 2, 5, 'fantastic smartphone with great features and battery life.'),
(3, 1, 4, 'good quality earbuds, but battery life could be better.'),
(5, 3, 5, 'perfect laptop for work and personal use. highly recommend it!'),
(2, 4, 3, 'decent tv but had issues with the remote control.'),
(4, 6, 4, 'stylish denim jacket, fits well and feels durable.'),
(7, 7, 5, 'great t-shirt with a nice design. comfortable and affordable.'),
(6, 10, 4, 'warm and cozy sweater, perfect for the winter season.'),
(8, 12, 5, 'amazing science fiction novel. couldn''t put it down!'),
(9, 18, 3, 'vacuum cleaner works well, but battery doesn''t last long.'),
(10, 25, 5, 'effective sunscreen, no greasy feeling and lasts all day.'),
(11, 2, 4, 'solid phone, but the camera quality could be improved'),
(12, 5, 5, 'smartwatch is amazing! easy to use and has a lot of features.'),
(13, 8, 3, 'good running shoes, but a bit tight around the toes.'),
(14, 9, 5, 'high-quality leather belt. goes well with most outfits.'),
(15, 14, 2, 'the book was not as interesting as expected, found it repetitive.'),
(16, 16, 4, 'blender is powerful, great for smoothies, but a bit noisy.'),
(17, 17, 5, 'microwave works perfectly and heats up quickly.'),
(18, 20, 4, 'nice coffee maker, easy to clean but takes a while to brew.'),
(19, 23, 5, 'great lipstick, long-lasting and smooth application.'),
(20, 26, 3, 'water bottle keeps drinks cool, but it’s a bit bulky.');

insert into orders (user_id, status, total) values
(1, 'delivered', 249.98),
(2, 'shipped', 89.99),
(3, 'pending', 159.98),
(4, 'cancelled', 59.99),
(5, 'delivered', 399.99);

insert into order_items (order_id, product_id, quantity, price) values
(1, 2, 1, 249.98),
(2, 7, 1, 89.99),
(3, 4, 1, 159.98),
(4, 6, 1, 59.99),
(5, 3, 1, 399.99),
(1, 1, 1, 249.98),
(2, 8, 1, 89.99),
(3, 10, 1, 159.98),
(4, 9, 1, 59.99),
(5, 5, 1, 399.99);

insert into cart (user_id) values (1), (2), (3), (4), (5);

insert into cart_items (cart_id, product_id, quantity) values
(1, 2, 2), (1, 4, 1), (2, 7, 1), (3, 6, 3), (4, 1, 1), (4, 3, 2),
(5, 8, 1), (5, 10, 1), (2, 5, 1), (3, 9, 2);


-- list all users
select * from users; 

-- list all products
select * from products; 

-- list all orders with user names
select o.order_id, u.name, o.order_date, o.status, o.total
from orders o
join users u on o.user_id = u.user_id;

-- list all items in a specific order

select oi.order_id, p.name, oi.quantity, oi.price
from order_items oi
join products p on oi.product_id = p.product_id
where oi.order_id = 1;


-- total number of users
select count(*) as total_users from users; 

-- total stock value of each product
select name, price * stock as stock_value from products; 

-- get products in a specific category
select p.name, p.price
 from products p
 join categories c on p.category_id = c.category_id
 where c.name = 'electronics';

-- list all products with average rating
select p.name, avg(pr.rating) as average_rating
 from products p 
 join product_reviews pr on p.product_id = pr.product_id 
 group by p.name; 

-- list users who have written more than 1 review
select u.name 
from users u 
join product_reviews pr on  pr.user_id= u.user_id
group by u.name 
having count(pr.review_id) > 1;



 -- show all products with their category name
select p.name as product_name ,c.name  as category_name
from products p 
join categories c on c.category_id=p.category_id;


-- total orders by each user
select u.name, count(o.order_id) as total_orders
 from users u 
 join orders o on u.user_id = o.user_id
 group by u.name; 



-- top 5 best-selling products

select p.name, sum(oi.quantity) as total_sold
 from order_items oi 
 join products p on oi.product_id = p.product_id 
 group by p.name 
 order by total_sold 
 desc limit 5; 

-- users who made orders more than once
select u.name, count(o.order_id) as total_orders 
from users u 
join orders o on u.user_id = o.user_id 
group by u.name
 having count(o.order_id) > 1; 
  
  -- find all users who have placed at least one order
 select distinct u.user_id, u.name, u.email,o.order_id
from users u
join orders o on u.user_id = o.user_id;

select * from users;

-- total revenue generated
select sum(total) as total_revenue 
from orders 
where status = 'delivered'; 

-- most active reviewers

select u.name, count(pr.review_id) as review_count 
from users u 
join product_reviews pr on u.user_id = pr.user_id 
group by u.name 
order by review_count desc; 

-- orders with payment status
select o.order_id, u.name, p.status as payment_status 
from orders o 
join users u on o.user_id = u.user_id 
join payments p on o.order_id = p.order_id; 

-- find users who have items in their cart but haven’t placed any order
select u.name ,u.user_id  from users u 
where u.user_id in(select user_id from cart) and u.user_id not in (select user_id from orders);

-- . list all orders with total item quantity in each order
select o.order_id,u.name ,sum(oi.quantity) from orders o
join users u on o.user_id = u.user_id
join order_items oi on o.order_id = oi.order_id
group by o.order_id, u.name;
-- procedures & triggers

-- procedure: get all orders by user id

delimiter //
 create procedure get_orders_by_user(in uid int)
 begin
 select o.order_id, o.order_date, o.total, o.status
 from orders o
 where o.user_id = uid; 
 end //
 delimiter ; 
 
-- trigger: update stock after new order item

delimiter //
 create trigger reduce_stock_after_order 
 after insert on order_items 
 for each row 
 begin
 update products set stock = stock - new.quantity 
 where product_id = new.product_id; 
 end //
 delimiter ; 

 
