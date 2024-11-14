CREATE TABLE equipos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) UNIQUE NOT NULL,
    pg INT DEFAULT 0,
    pe INT DEFAULT 0,
    pp INT DEFAULT 0,
    gf INT DEFAULT 0,
    gc INT DEFAULT 0
);

CREATE TABLE partidos (
    id SERIAL PRIMARY KEY,
    nombreequipo1 VARCHAR(255) NOT NULL REFERENCES equipos(nombre),
    golequipo1 INT NOT NULL,
    nombreequipo2 VARCHAR(255) NOT NULL REFERENCES equipos(nombre),
    golequipo2 INT NOT NULL
);
