USE laboration1;

-- Uppgift 1
CREATE TABLE IF NOT EXISTS successful_mission AS
    SELECT *
    FROM moon_mission
    WHERE outcome = 'Successful';

-- Uppgift 2
START TRANSACTION;
ALTER TABLE successful_mission
    MODIFY mission_id int PRIMARY KEY AUTO_INCREMENT;
COMMIT;

-- Uppgift 3
START TRANSACTION;
UPDATE moon_mission
    SET operator = REPLACE(operator, ' ', '');
COMMIT;

START TRANSACTION;
UPDATE successful_mission
    SET operator = REPLACE(operator, ' ', '');
COMMIT;

-- Uppgift 4
START TRANSACTION;
DELETE FROM successful_mission
    WHERE launch_date >= '2010-01-01';
COMMIT;

-- Uppgift 5
START TRANSACTION;
UPDATE account
    SET name = CONCAT(first_name, ' ', last_name)
    WHERE first_name IS NOT NULL AND last_name IS NOT NULL;
COMMIT;

START TRANSACTION;
ALTER TABLE account
    ADD COLUMN gender VARCHAR(10);
COMMIT;

START TRANSACTION;
UPDATE account
    SET gender = IF(SUBSTRING(ssn, 10, 1) % 2 = 0, 'female', 'male')
    WHERE ssn IS NOT NULL;
COMMIT;

-- Uppgift 6
START TRANSACTION;
DELETE FROM account
    WHERE gender = 'female'
    AND SUBSTRING(ssn, 1, 2) < 70;
COMMIT;

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