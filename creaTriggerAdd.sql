CREATE TRIGGER trg_actualizar_estadisticas
AFTER INSERT ON partidos
FOR EACH ROW
EXECUTE FUNCTION actualizar_estadisticas();
