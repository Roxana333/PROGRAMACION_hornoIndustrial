CREATE DATABASE  HornoIndustrialDB;
#DROP DATABASE HornoIndustrialDB
USE HornoIndustrialDB;

# tabla informacion de hornos
create table Hornos ( 
id_horno int auto_increment primary key,
modelo varchar(50) not null ,
capacidad int not null, #capacidad de horno
id_estado integer references Estados(id_estado) on delete cascade,
temperatura_objetivo decimal (5,2) not null , # temperatura objetivo
limite_seguridad decimal ( 5,2) not null  #limite de seguridad e temperatura
); 

#tabla para registrar temperatura con timpo 
create table Produccion ( 
id_prod int auto_increment primary key,
id_horno integer references Hornos(id_horno) on delete cascade,
descripcion decimal(5,2) not null , #temperatura actual
fecha_inicio timestamp default current_timestamp,
fecha_fin timestamp default current_timestamp  # fecha y hora de registro
#foreign key (id_horno) references Hornos #on delete cascade
);

#tabla para registrar etsdo de horno
create table Estados ( 
id_estado int auto_increment primary key,
estado varchar (50) not null, # estado del horno ( calentar , descongelar , en falla )
fecha_registro timestamp default current_timestamp #fecha y hora registro de estado
 #foreign key (id_horno) references Hornos on delete cascade
);

# tabla para registro de segurida
create table seguridad (
id_seguridad int auto_increment primary key,
id_horno integer references Hornos(id_horno) on delete cascade,
topo_seguridad varchar (100) not null, #tipo de seguridad falla , sobrecalentamiento
descripcion text, #descripcion de seguridad
fecha_seguridad timestamp default current_timestamp #fecha y hora
#foreign key (id_horno) references Hornos on delete cascade
);

# hornos
insert into Hornos(modelo,capacidad,id_estado,temperatura_objetivo,limite_seguridad)
values
('Horno Atma t20' , 100 ,1,200 ,250);
insert into Hornos(modelo,capacidad,id_estado,temperatura_objetivo,limite_seguridad)
values
('Horno Atma t30' , 200 ,1,200 ,250);
insert into Hornos(modelo,capacidad,id_estado,temperatura_objetivo,limite_seguridad)
values
('Horno Atma tl50' , 100 ,1,200 ,250);
insert into Hornos(modelo,capacidad,id_estado,temperatura_objetivo,limite_seguridad)
values
('Horno industrial ZR' , 800 ,1,200 ,250);
insert into Hornos(modelo,capacidad,id_estado,temperatura_objetivo,limite_seguridad)
values
('Horno industrial XR' , 900 ,1,200 ,250);

# registro de temperaturas
insert into Temperaturas (id_horno , temperatura)
values
(1, 190), (1, 200), (1, 210);
insert into Temperaturas (id_horno , temperatura)
values
(2, 230), ( 2, 230);
insert into Temperaturas (id_horno , temperatura)
values
(3, 240), (3, 250), (3, 260);

#registrod de estado de horno
insert into Estados (id_estado,estado,fecha_registro)
values 
(1, 'APAGADO',sysdate());
insert into Estados (id_estado,estado,fecha_registro)
values 
(2, 'ENCENDIDO - ESTABLE',sysdate()); 
insert into Estados (id_estado,estado,fecha_registro)
values 
(3, 'ENCENDIDO - SOBRECALENTADO',sysdate());


# Lista de todos los hornos
SELECT id_horno, modelo, temperatura_objetivo, limite_seguridad
FROM Hornos;

# Lista de todos los hornos marca Atma

SELECT id_horno, modelo, temperatura_objetivo, limite_seguridad
FROM hornos h
WHERE UPPER(h.modelo) LIKE '%ATMA%'

#Lista de todos los hornos que estan en estado apagado
SELECT id_horno, modelo, temperatura_objetivo, limite_seguridad
FROM hornos h
WHERE h.id_estado IN (SELECT e.id_estado
			          FROM estados e
                      where  lower(e.estado) = 'apagado')


#lista de horno con capacidad mayor a 500 m3
SELECT *
FROM hornoindustrialdb.hornos h
WHERE h.capacidad > 500;

#Lista de produccion que tengan hornos en estado encendido
SELECT p.*
FROM produccion p
JOIN hornos h ON p.id_horno = h.id_horno
JOIN estados e ON e.id_estado = h.id_estado
WHERE e.id_estado = 2
	AND p.fecha_fin IS NULL;

 
 

