USE laboration1;

/*
-- Uppgift 1
CREATE TABLE IF NOT EXISTS successful_mission AS
    SELECT *
    FROM moon_mission
    WHERE outcome = 'Successful';

-- Uppgift 2
ALTER TABLE successful_mission
    MODIFY mission_id int PRIMARY KEY AUTO_INCREMENT;



-- Uppgift 3
UPDATE moon_mission
    SET operator = REPLACE(operator, ' ', '');

UPDATE successful_mission
    SET operator = REPLACE(operator, ' ', '');

-- Uppgift 4
DELETE FROM successful_mission
    WHERE launch_date >= '2010-01-01';


-- Uppgift 5
UPDATE account
    SET name = CONCAT(first_name, ' ', last_name)
    WHERE first_name IS NOT NULL AND last_name IS NOT NULL;

ALTER TABLE account
    ADD COLUMN gender VARCHAR(10);

UPDATE account
    SET gender = IF(SUBSTRING(ssn, 10, 1) % 2 = 0, 'female', 'male')
    WHERE ssn IS NOT NULL;

-- Uppgift 6
DELETE FROM account
    WHERE gender = 'female'
    AND SUBSTRING(ssn, 1, 2) < 70;


-- Uppgift 7
SELECT 'male'                             AS gender,
       AVG(YEAR(CURDATE()) -
           YEAR(STR_TO_DATE(CONCAT('19', SUBSTR(ssn, 1, 2), '-', SUBSTR(ssn, 3, 2), '-', SUBSTR(ssn, 5, 2)),
                            '%Y-%m-%d'))) AS average_age
FROM account
WHERE SUBSTR(ssn, LENGTH(ssn) - 1, 1) % 2 = 1
UNION
SELECT 'female'                           AS gender,
       AVG(YEAR(CURDATE()) -
           YEAR(STR_TO_DATE(CONCAT('19', SUBSTR(ssn, 1, 2), '-', SUBSTR(ssn, 3, 2), '-', SUBSTR(ssn, 5, 2)),
                            '%Y-%m-%d'))) AS average_age
FROM account
WHERE SUBSTR(ssn, LENGTH(ssn) - 1, 1) % 2 = 0;
*/
SELECT * FROM account;




