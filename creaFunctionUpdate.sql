CREATE OR REPLACE FUNCTION actualizar_estadisticas_al_actualizar() RETURNS TRIGGER AS $$
BEGIN
    -- Revertir las estadísticas previas
    -- Restar goles
    UPDATE equipos
    SET gf = gf - OLD.golequipo1,
        gc = gc - OLD.golequipo2
    WHERE nombre = OLD.nombreequipo1;

    UPDATE equipos
    SET gf = gf - OLD.golequipo2,
        gc = gc - OLD.golequipo1
    WHERE nombre = OLD.nombreequipo2;

    -- Restar partidos ganados, empatados y perdidos
    IF (OLD.golequipo1 > OLD.golequipo2) THEN
        UPDATE equipos
        SET pg = pg - 1
        WHERE nombre = OLD.nombreequipo1;

        UPDATE equipos
        SET pp = pp - 1
        WHERE nombre = OLD.nombreequipo2;
    ELSIF (OLD.golequipo1 < OLD.golequipo2) THEN
        UPDATE equipos
        SET pg = pg - 1
        WHERE nombre = OLD.nombreequipo2;

        UPDATE equipos
        SET pp = pp - 1
        WHERE nombre = OLD.nombreequipo1;
    ELSE
        UPDATE equipos
        SET pe = pe - 1
        WHERE nombre = OLD.nombreequipo1;

        UPDATE equipos
        SET pe = pe - 1
        WHERE nombre = OLD.nombreequipo2;
    END IF;

    -- Aplicar las nuevas estadísticas
    -- Sumar goles
    UPDATE equipos
    SET gf = gf + NEW.golequipo1,
        gc = gc + NEW.golequipo2
    WHERE nombre = NEW.nombreequipo1;

    UPDATE equipos
    SET gf = gf + NEW.golequipo2,
        gc = gc + NEW.golequipo1
    WHERE nombre = NEW.nombreequipo2;

    -- Sumar partidos ganados, empatados y perdidos
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
