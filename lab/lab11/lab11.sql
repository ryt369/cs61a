CREATE table newest AS
  SELECT t.title ,t.year
  FROM titles AS t
  ORDER BY t.year DESC
  LIMIT 10;

CREATE table dog_movies AS 
  SELECT t.title , p.character
  FROM titles AS t
  JOIN principals AS P
  ON p.tconst=t.tconst
  WHERE p.character LIKE '%dog%';

CREATE table leads AS 
  SELECT n.name, COUNT(*) AS lead_roles
  FROM names AS n
  JOIN principals AS p
  ON n.nconst=p.nconst
  WHERE p.ordering=1
  GROUP BY n.name
  HAVING COUNT(*)>10;





CREATE TABLE long_movies AS
  SELECT
    CAST((year / 10) * 10 AS TEXT) || 's' AS decade,
    COUNT(*) AS count
  FROM titles
  WHERE runtime > 180
  GROUP BY decade;
