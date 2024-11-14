CREATE OR REPLACE FUNCTION actualizar_estadisticas() RETURNS TRIGGER AS $$
BEGIN
    -- Actualizar estadísticas de goles
    UPDATE equipos
    SET gf = gf + NEW.golequipo1,
        gc = gc + NEW.golequipo2
    WHERE nombre = NEW.nombreequipo1;

    UPDATE equipos
    SET gf = gf + NEW.golequipo2,
        gc = gc + NEW.golequipo1
    WHERE nombre = NEW.nombreequipo2;

    -- Actualizar estadísticas de partidos ganados, empatados y perdidos
    IF (NEW.golequipo1 > NEW.golequipo2) THEN
        UPDATE equipos
        SET pg = pg + 1
        WHERE nombre = NEW.nombreequipo1;

        UPDATE equipos
        SET pp = pp + 1
        WHERE nombre = NEW.nombreequipo2;
    ELSIF (NEW.golequipo1 < NEW.golequipo2) THEN
        UPDATE equipos
        SET pg = pg + 1
        WHERE nombre = NEW.nombreequipo2;

        UPDATE equipos
        SET pp = pp + 1
        WHERE nombre = NEW.nombreequipo1;
    ELSE
        UPDATE equipos
        SET pe = pe + 1
        WHERE nombre = NEW.nombreequipo1;

        UPDATE equipos
        SET pe = pe + 1
        WHERE nombre = NEW.nombreequipo2;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
