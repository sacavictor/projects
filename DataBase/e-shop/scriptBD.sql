
create table PRODUS(
    MODEL int not null,
    FABRICANT varchar(30),
    CATEGORIE varchar(30),
    PRET decimal(10, 2)
);

create table PC(
    MODEL int not null,
    VITEZA decimal(10, 2),
    RAM int,
    HD int
);

create table laptop(
    MODEL int not null,
    VITEZA decimal(10, 2),
    RAM int,
    HD int,
    ECRAN decimal(10, 2)
);

create table Imprimanta(
    MODEL int not null,
    CULOARE char(1),
    TIP varchar(6)
);


alter table PRODUS add primary key (MODEL);


alter table PC add primary key (MODEL);
alter table PC add foreign key (MODEL) references PRODUS(MODEL);


alter table laptop add primary key(MODEL);
alter table laptop add foreign key (MODEL) references PRODUS(MODEL);

alter table Imprimanta add primary key(MODEL);
alter table Imprimanta add foreign key(MODEL) references PRODUS(MODEL);

alter table PRODUS add MONEDA varchar(3);

alter table PRODUS add constraint CAT_VALUES
check (categorie in ('PC', 'LAPTOP', 'IMPRIMANTA'));
alter table IMPRIMANTA add constraint cul_values
check (culoare in ('D', 'N'));
alter table IMPRIMANTA add constraint tip_values
check (tip in ('Ace', 'Jet', 'Laser'));

alter table PRODUS add constraint price_range check (pret between 10 and 3000);
ALTER TABLE PC ADD CONSTRAINT speed_and_hd_limit
CHECK ((VITEZA > 1.8 AND HD > 500) OR (VITEZA <= 1.8));


INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (1, 'Asus', 'PC', 2000, 'RON');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (2, 'Fabricant2', 'LAPTOP', 200, 'EUR');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (3, 'HP', 'IMPRIMANTA', 150, 'EUR');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (4, 'Lenovo', 'PC', 2080, 'RON');
 
INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (5, 'Fabricant5', 'LAPTOP', 250, 'EUR');
 
INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (6, 'HP', 'IMPRIMANTA', 1210, 'RON');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (7, 'HP', 'PC', 2790, 'RON');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (8, 'Fabricant8', 'LAPTOP', 300, 'EUR');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (9, 'Samsung', 'IMPRIMANTA', 170, 'EUR');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (10, 'HP', 'PC', 220, 'EUR');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (11, 'Fabricant11', 'LAPTOP', 400, 'EUR');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (12, 'Canon', 'IMPRIMANTA', 1180, 'RON');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (13, 'Asus', 'PC', 2500, 'EUR');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (14, 'Fabricant14', 'LAPTOP', 2999, 'RON');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (15, 'Epson', 'IMPRIMANTA', 200, 'EUR');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (16, 'Dell', 'PC', 1800, 'RON');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (17, 'Fabricant17', 'LAPTOP', 500, 'EUR');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (18, 'Fabricant18', 'IMPRIMANTA', 2220, 'RON');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (19, 'Lenovo', 'PC', 2000, 'RON');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (20, 'Fabricant20', 'LAPTOP', 700, 'EUR');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (21, 'Epson', 'IMPRIMANTA', 2180, 'RON');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (22, 'Epson', 'IMPRIMANTA', 1110, 'RON');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA) 
VALUES (23, 'Samsung', 'IMPRIMANTA', 100, 'EUR');

insert into produs (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA)
VALUES (123, 'Canon', 'IMPRIMANTA', 1210, 'RON');

insert into produs (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA)
VALUES (24, 'HP', 'IMPRIMANTA', 1210, 'RON');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA)
VALUES (25, 'Epson', 'IMPRIMANTA', 1210, 'RON');

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA)
VALUES (26, 'SAMSUNG', 'IMPRIMANTA', 1210, 'RON');

INSERT INTO Produs (model, fabricant, categorie, pret)
VALUES (28, 'IBM', 'PC', 1200);

INSERT INTO Produs (model, fabricant, categorie, pret)
VALUES (29, 'IBM', 'LAPTOP', 1500);

INSERT INTO Produs (model, fabricant, categorie, pret)
VALUES (30, 'IBM', 'IMPRIMANTA', 300);

INSERT INTO PRODUS (MODEL, FABRICANT, CATEGORIE, PRET, MONEDA)
VALUES (1234, 'HP', 'LAPTOP', 999, 'RON');

insert into produs (model, fabricant, categorie, pret, MONEDA)
values (33, 'Fabricant33', 'LAPTOP', 250, 'EUR');

insert into produs (model, fabricant, categorie, pret, MONEDA)
values (34, 'Fabricant34', 'LAPTOP', 3000, 'RON');

insert into produs (model, fabricant, categorie, pret, MONEDA)
values (35, 'Canon', 'IMPRIMANTA', 99, 'EUR');

insert into produs (model, fabricant, categorie, pret, MONEDA)
values (36, 'IBM', 'IMPRIMANTA', 75, 'EUR');


INSERT INTO PC (MODEL, VITEZA, RAM, HD) 
VALUES (1, 2.0, 8, 1000);

INSERT INTO PC (MODEL, VITEZA, RAM, HD) 
VALUES (4, 2.8, 16, 1000);

INSERT INTO PC (MODEL, VITEZA, RAM, HD) 
VALUES (7, 2.4, 8, 750);

INSERT INTO PC (MODEL, VITEZA, RAM, HD) 
VALUES (10, 1.6, 4, 256);

INSERT INTO PC (MODEL, VITEZA, RAM, HD) 
VALUES (13, 2.5, 16, 1024);

INSERT INTO PC (MODEL, VITEZA, RAM, HD) 
VALUES (16, 2.7, 16, 750);

INSERT INTO PC (model, viteza, ram, hd)
VALUES (28, 2.5, 8, 900);


INSERT INTO laptop (MODEL, VITEZA, RAM, HD, ECRAN) 
VALUES (2, 2.8, 16, 1024, 17.3);

INSERT INTO laptop (MODEL, VITEZA, RAM, HD, ECRAN) 
VALUES (5, 2.4, 8, 600, 5.6);

INSERT INTO laptop (MODEL, VITEZA, RAM, HD, ECRAN) 
VALUES (8, 2.9, 8, 1000, 15);

INSERT INTO laptop (MODEL, VITEZA, RAM, HD, ECRAN) 
VALUES (11, 2.0, 8, 1000, 5.6);

INSERT INTO laptop (MODEL, VITEZA, RAM, HD, ECRAN) 
VALUES (14, 3.0, 32, 2048, 15.6);

INSERT INTO laptop (MODEL, VITEZA, RAM, HD, ECRAN) 
VALUES (17, 1.6, 4, 256, 5.6);

INSERT INTO laptop (MODEL, VITEZA, RAM, HD, ECRAN) 
VALUES (20, 2.8, 32, 1024, 17);

INSERT INTO Laptop (model, viteza, ram, hd, ecran)
VALUES (29, 2.8, 16, 1000, 15.6);

INSERT INTO LAPTOP (MODEL, VITEZA, RAM, HD, ECRAN)
VALUES (1234, 2.5, 4, 500, 5.6);


INSERT INTO Imprimanta (MODEL, CULOARE, TIP) 
VALUES (3, 'D', 'Jet');

INSERT INTO Imprimanta (MODEL, CULOARE, TIP) 
VALUES (6, 'N', 'Laser');

INSERT INTO Imprimanta (MODEL, CULOARE, TIP) 
VALUES (9, 'D', 'Ace');

INSERT INTO Imprimanta (MODEL, CULOARE, TIP) VALUES (15, 'D', 'Laser');

INSERT INTO Imprimanta (MODEL, CULOARE, TIP) VALUES (12, 'N', 'Laser');

INSERT INTO Imprimanta (MODEL, CULOARE, TIP) 
VALUES (18, 'N', 'Jet');

INSERT INTO IMPRIMANTA (MODEL, CULOARE, TIP)
VALUES (21, 'D', 'Laser');

INSERT INTO IMPRIMANTA (MODEL, CULOARE, TIP)
VALUES (22, 'D', 'Laser');

INSERT INTO IMPRIMANTA (MODEL, CULOARE, TIP)
VALUES (23, 'D', 'Laser');

INSERT INTO IMPRIMANTA (MODEL, CULOARE, TIP)
VALUES (123, 'D', 'Laser');

INSERT INTO IMPRIMANTA (MODEL, CULOARE, TIP)
VALUES (24, 'N', 'Laser');

INSERT INTO IMPRIMANTA (MODEL, CULOARE, TIP)
VALUES (25, 'D', 'Jet');

INSERT INTO IMPRIMANTA (MODEL, CULOARE, TIP)
VALUES (26, 'D', 'Ace');

INSERT INTO Imprimanta (model, culoare, tip)
VALUES (30, 'D', 'Laser');

