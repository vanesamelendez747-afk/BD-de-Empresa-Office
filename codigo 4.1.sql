-- ===========================================
-- CREAR BASE DE DATOS
-- ===========================================

DROP DATABASE IF EXISTS Empresa;
CREATE DATABASE Empresa;
USE Empresa;

-- ===========================================
-- TABLA DEPARTAMENTO
-- ===========================================

CREATE TABLE Departamento (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre_departamento VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL
);

-- ===========================================
-- TABLA PUESTO
-- ===========================================

CREATE TABLE Puesto (
    id_puesto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_puesto VARCHAR(100) NOT NULL,
    salario_base DECIMAL(10,2) NOT NULL
);

-- ===========================================
-- TABLA EMPLEADO
-- ===========================================

CREATE TABLE Empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100) UNIQUE,
    fecha_contratacion DATE,
    id_departamento INT NOT NULL,
    id_puesto INT NOT NULL,

    CONSTRAINT fk_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES Departamento(id_departamento),

    CONSTRAINT fk_puesto
        FOREIGN KEY (id_puesto)
        REFERENCES Puesto(id_puesto)
);

-- ===========================================
-- INSERTAR DEPARTAMENTOS
-- ===========================================

INSERT INTO Departamento (nombre_departamento, ubicacion) VALUES
('Recursos Humanos','Edificio A'),
('Finanzas','Edificio B'),
('Sistemas','Edificio C'),
('Ventas','Edificio D'),
('Marketing','Edificio E'),
('Producción','Edificio F'),
('Compras','Edificio G'),
('Calidad','Edificio H'),
('Logística','Edificio I'),
('Dirección General','Edificio J');

-- ===========================================
-- INSERTAR PUESTOS
-- ===========================================

INSERT INTO Puesto (nombre_puesto, salario_base) VALUES
('Gerente',35000.00),
('Supervisor',22000.00),
('Auxiliar',12000.00),
('Analista',18000.00),
('Programador',25000.00),
('Contador',23000.00),
('Diseñador',19000.00),
('Recepcionista',11000.00);

-- ===========================================
-- INSERTAR 300 EMPLEADOS
-- ===========================================

DELIMITER $$

CREATE PROCEDURE insertar_empleados()
BEGIN

    DECLARE i INT DEFAULT 1;

    WHILE i <= 300 DO

        INSERT INTO Empleado
        (
            nombre,
            apellido,
            correo,
            fecha_contratacion,
            id_departamento,
            id_puesto
        )

        VALUES
        (
            CONCAT('Empleado', i),
            CONCAT('Apellido', i),
            CONCAT('empleado', i, '@empresa.com'),
            DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND()*730) DAY),
            FLOOR(1 + RAND()*10),
            FLOOR(1 + RAND()*8)
        );

        SET i = i + 1;

    END WHILE;

END$$

DELIMITER ;

CALL insertar_empleados();

DROP PROCEDURE insertar_empleados;

-- ===========================================
-- CONSULTAS
-- ===========================================

SELECT * FROM Departamento;
SELECT * FROM Puesto;
SELECT * FROM Empleado;

SELECT COUNT(*) AS Total_Departamentos FROM Departamento;
SELECT COUNT(*) AS Total_Puestos FROM Puesto;
SELECT COUNT(*) AS Total_Empleados FROM Empleado;