use Mascotas_bd;
CREATE TABLE tb_pet(
    id int AUTO_INCREMENT primary key,
    code varchar(3) not null,
    name varchar(50) not null,
    born_year int not null,
    color varchar(20) not null,    
    healthStatus varchar(15) not null
    );
CREATE TABLE tb_cat(
	id_cat int AUTO_INCREMENT PRIMARY KEY,
    breed varchar(30) not null,
    id_pet int not null,
    foreign key (id_pet) references tb_pet(id)
);
CREATE TABLE tb_dog(
	id_dog int AUTO_INCREMENT PRIMARY KEY,
    breed varchar(30) not null,
    pedigree boolean NOT null default 0,
    id_pet int not null,
    foreign key (id_pet) references tb_pet(id)
);

/* insercion de 10 resgistros a la tabla tb_pet*/
INSERT INTO tb_pet(
code,
name,
born_year,
color,
healthStatus
) VALUES
('001', 'Max', 2018, 'Marrón', 'Saludable'),
('002', 'Bella', 2019, 'Blanco', 'Vacunado'),
('003', 'Charlie', 2017, 'Negro', 'Enfermo'),
('004', 'Lucy', 2020, 'Gris', 'Saludable'),
('005', 'Luna', 2016, 'Anaranjado', 'Vacunado'),
('006', 'Leo', 2015, 'Atigrado', 'Saludable'),
('007', 'Milo', 2018, 'Carey', 'Enfermo'),
('008', 'Sophie', 2019, 'Canela', 'Saludable'),
('009', 'Oreo', 2014, 'Manchado', 'Vacunado'),
('010', 'Simba', 2021, 'Rayado', 'Saludable');

/* insercion de 10 registros a la tabla tb_cat*/
INSERT INTO tb_cat(
breed,
id_pet
)VALUES
('Siamese', 1),
('Persa', 2),
('Maine Coon', 3),
('British Shorthair', 4),
('Bengala', 5),
('Sphynx', 6),
('Ragdoll', 7),
('Abisinio', 8),
('Scottish Fold', 9),
('Angora', 10);

/* insercion de 10 registros a la tabla tb_dog*/
INSERT INTO tb_dog(
breed,
pedigree,
id_pet
)VALUES
('Labrador Retriever', 1, 1),
('Golden Retriever', 1, 2),
('Bulldog', 0, 3),
('German Shepherd', 1, 4),
('Beagle', 0, 5),
('Poodle', 1, 6),
('Boxer', 1, 7),
('Siberian Husky', 1, 8),
('Dachshund', 0, 9),
('Chihuahua', 0, 10);

/* algunas consultas con where */
SELECT * FROM tb_pet where name = 'Luna';
SELECT * FROM tb_pet where born_year = '2019';
SELECT * FROM tb_pet where code = '003';

/* Muestra infomacion completa en una sola tabla de tb_pet,tb_dog y tb_cat*/
SELECT 
P.*,
D.*,
C.*
FROM tb_pet P
INNER JOIN tb_dog D ON P.id = D.id_pet
INNER JOIN tb_cat C ON P.id = C.id_pet;
