CREATE TABLE Usuarios (
    id INT PRIMARY KEY,
    nombre VARCHAR(255),
    apellidos VARCHAR(255),
    celular VARCHAR(15)
);
--______________________________________________________________________
CREATE TABLE InformacionContacto (
    id INT PRIMARY KEY,
    usuario_id INT,
    pais VARCHAR(50),
    estado VARCHAR(50),
    nacionalidad VARCHAR(50),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);
--______________________________________________________________________
CREATE TABLE Roles (
    id INT PRIMARY KEY,
    nombre_rol VARCHAR(50)
);
--______________________________________________________________________
INSERT INTO Roles (id, nombre_rol) VALUES
(1, 'Estudiante'),
(2, 'Ingeniero'),
(3, 'Trabajador'),
(4, 'Cliente');
--______________________________________________________________________
CREATE TABLE TiposAnimales (
    id INT PRIMARY KEY,
    nombre_tipo VARCHAR(50)
);
--______________________________________________________________________
INSERT INTO TiposAnimales (id, nombre_tipo) VALUES
(1, 'Perro'),
(2, 'Gato'),
(3, 'Pez'),
(4, 'Ave');
--______________________________________________________________________
CREATE TABLE RazasAnimales (
    id INT PRIMARY KEY,
    tipo_animal_id INT,
    nombre_raza VARCHAR(50),
    FOREIGN KEY (tipo_animal_id) REFERENCES TiposAnimales(id)
);

-- Razas de perros
INSERT INTO RazasAnimales (id, tipo_animal_id, nombre_raza) VALUES
(1, 1, 'Labrador'),
(2, 1, 'Bulldog'),
(3, 1, 'Poodle');

-- Razas de gatos
INSERT INTO RazasAnimales (id, tipo_animal_id, nombre_raza) VALUES
(4, 2, 'Siamese'),
(5, 2, 'Persian'),
(6, 2, 'Maine Coon');

-- Razas de peces
INSERT INTO RazasAnimales (id, tipo_animal_id, nombre_raza) VALUES
(7, 3, 'Goldfish'),
(8, 3, 'Betta'),
(9, 3, 'Guppy');

-- Razas de aves
INSERT INTO RazasAnimales (id, tipo_animal_id, nombre_raza) VALUES
(10, 4, 'Canario'),
(11, 4, 'Periquito'),
(12, 4, 'Cacatúa');
--______________________________________________________________________

CREATE TABLE EstadoSaludCuidado (
    id INT PRIMARY KEY,
    estado_salud VARCHAR(50),
    cuidado VARCHAR(255)
);

INSERT INTO EstadoSaludCuidado (id, estado_salud, cuidado) VALUES
(1, 'Sano', 'Cuidado estándar'),
(2, 'Enfermo', 'Cuidados especiales');

--______________________________________________________________________


-- Insertar datos de usuarios--_________________________________________
INSERT INTO Usuarios (id, nombre, apellidos, celular, rol_id) VALUES
(1, 'Juan', 'Pérez', '123456789', 1),
(2, 'María', 'López', '987654321', 2),
(3, 'Carlos', 'Gómez', '555555555', 3);

-- Insertar datos de mascotas--______________________________________________________________________
INSERT INTO Animales (id, nombre, tipo, raza, usuario_id) VALUES
(1, 'Firulais', 'Perro', 'Labrador', 1),
(2, 'Mittens', 'Gato', 'Siamés', 2),
(3, 'Nemo', 'Pez', 'Goldfish', 3);

-- Insertar datos de estado de mascotas--______________________________________________________________________
INSERT INTO CuidadoAnimales (id, animal_id, enfermo, cuidado) VALUES
(1, 1, FALSE, 'Vacunación al día'),
(2, 2, TRUE, 'Medicación diaria'),
(3, 3, FALSE, 'Alimentación regular');

--______________________________________________________________________

CREATE TABLE Animales (
    id INT PRIMARY KEY,
    usuario_id INT,
    tipo_animal_id INT,
    raza_animal_id INT,
    estado_salud_id INT,
    nombre_animal VARCHAR(50),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (tipo_animal_id) REFERENCES TiposAnimales(id),
    FOREIGN KEY (raza_animal_id) REFERENCES RazasAnimales(id),
    FOREIGN KEY (estado_salud_id) REFERENCES EstadoSaludCuidado(id)
);

-- Asignar animales a usuarios --______________________________________________________________________
INSERT INTO Animales (usuario_id, tipo_animal_id, raza_animal_id, estado_salud_id, nombre_animal) VALUES
(X, 1, 1, 1, 'Max'),
(X, 2, 5, 2, 'Whiskers'),
(X, 3, 7, 1, 'Bubbles');

--______________________________________________________________________
-- Obtener información de usuarios, mascotas y su estado
SELECT
    u.apellidos AS Apellidos,
    u.celular AS Celular,
    a.nombre AS Mascota,
    ca.enfermo AS 'Mascota Enferma',
    ic.nacionalidad AS Nacionalidad,
    r.nombre_rol AS Rol
FROM Usuarios u
JOIN Animales a ON u.id = a.usuario_id
JOIN CuidadoAnimales ca ON a.id = ca.animal_id
JOIN InformacionContacto ic ON u.id = ic.usuario_id
JOIN Roles r ON u.rol_id = r.id;
