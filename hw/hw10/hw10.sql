CREATE TABLE parents (parent TEXT, child TEXT);

INSERT INTO parents VALUES
  ('ace', 'bella'),
  ('ace', 'charlie'),
  ('daisy', 'hank'),
  ('finn', 'ace'),
  ('finn', 'daisy'),
  ('finn', 'ginger'),
  ('ellie', 'finn');

CREATE TABLE dogs (name TEXT, fur TEXT, height INTEGER);

INSERT INTO dogs VALUES
  ('ace',     'long',  26),
  ('bella',   'short', 52),
  ('charlie', 'long',  47),
  ('daisy',   'long',  46),
  ('ellie',   'short', 35),
  ('finn',    'curly', 32),
  ('ginger',  'short', 28),
  ('hank',    'curly', 31);

CREATE TABLE sizes (size TEXT, min INTEGER, max INTEGER);

INSERT INTO sizes VALUES
  ('toy',      24, 28),
  ('mini',     28, 35),
  ('medium',   35, 45),
  ('standard', 45, 60);


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT p.child FROM parents AS p
         JOIN  dogs AS d
           ON p.parent=d.name
          ORDER BY d.height DESC;



-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name, s.size FROM dogs AS d 
  JOIN  sizes AS s
  ON  s.min<d.height
  AND  d.height<=s.max
  ORDER BY d.name;
         


-- [Optional] Filling out this helper table is recommended
CREATE TABLE siblings AS 
  SELECT p.child AS  sib1,
         pa.child AS sib2
  FROM parents AS p
  JOIN parents AS pa
  ON p.child < pa.child     --只保留<使得不会出现a，b  b，a的重复，且默认按照字母顺序来
  AND p.parent=pa.parent;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT 'The two siblings, ' ||
    si.sib1 || ' and ' || si.sib2 ||
    ', have the same size: ' || s1.size
  FROM siblings AS si
  JOIN size_of_dogs AS s1 ON s1.name=si.sib1
  JOIN size_of_dogs AS s2 ON s2.name=si.sib2
  where s1.size=s2.size;

-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT
    fur,
    MAX(height) - MIN(height) AS height_range
  FROM dogs
  GROUP BY fur
  HAVING
    MIN(height) >= 0.7 * AVG(height)
    AND
    MAX(height) <= 1.3 * AVG(height);


