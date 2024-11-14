CREATE TRIGGER trg_actualizar_estadisticas_al_actualizar
BEFORE UPDATE ON partidos
FOR EACH ROW
EXECUTE FUNCTION actualizar_estadisticas_al_actualizar();
