CREATE DATABASE board2;
USE board2;
CREATE TABLE author_post(
	id INT PRIMARY KEY AUTO_INCREMENT,
	author_id INT not null,
	post_id INT not null,
	FOREIGN KEY (author_id) REFERENCES author(id),
	FOREIGN KEY (post_id) REFERENCES post(id)
);
CREATE TABLE author(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(255),
    email varchar(255) unique,
    pw varchar(255),
    created_time datetime default current_timestamp
);
CREATE TABLE post(
	id INT PRIMARY KEY AUTO_INCREMENT,
    title varchar(255) not null,
    contents varchar(255),
    created_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_time datetime default current_timestamp
);
CREATE TABLE author_address(
	id int primary key auto_increment,
    city varchar(255),
    street varchar(255),
    author_id int not null unique,
    foreign key (author_id) references author(id) on delete cascade
);
