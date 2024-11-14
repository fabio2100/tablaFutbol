DROP VIEW IF EXISTS vista_estadisticas;

CREATE VIEW vista_estadisticas AS
SELECT 
    nombre,
    (pg * 3 + pe) AS ptos,
    (pg + pe + pp) AS pj,
    pg,
    pe,
    pp,
    gf,
    gc,
    (gf - gc) AS dif
FROM 
    equipos
ORDER BY 
    ptos DESC, 
    dif DESC;
