CREATE OR REPLACE FUNCTION actualizar_estadisticas_al_eliminar() RETURNS TRIGGER AS $$
BEGIN
    -- Actualizar estadísticas de goles
    UPDATE equipos
    SET gf = gf - OLD.golequipo1,
        gc = gc - OLD.golequipo2
    WHERE nombre = OLD.nombreequipo1;

    UPDATE equipos
    SET gf = gf - OLD.golequipo2,
        gc = gc - OLD.golequipo1
    WHERE nombre = OLD.nombreequipo2;

    -- Actualizar estadísticas de partidos ganados, empatados y perdidos
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

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
