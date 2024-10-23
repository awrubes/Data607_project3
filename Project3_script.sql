DROP PROCEDURE IF EXISTS LoadBirthRateData;
DROP PROCEDURE IF EXISTS LoadFertilityRateData;

DROP TABLE IF EXISTS birth_rate;
DROP TABLE IF EXISTS death_rate;
DROP TABLE IF EXISTS gdp;
DROP TABLE IF EXISTS population;
DROP TABLE IF EXISTS urbanization;
DROP TABLE IF EXISTS fertility_rate; 
DROP TABLE IF EXISTS countries;

-- Create the countries table
CREATE TABLE countries (
    country_id INT NOT NULL AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL,
    PRIMARY KEY(country_id)
);

-- Insert the country names into the countries table
INSERT INTO countries (country_name)
VALUES 
    ('angola'), 
    ('bangladesh'), 
    ('benin'), 
    ('china'), 
    ('egypt'), 
    ('italy'), 
    ('japan'), 
    ('niger'), 
    ('south korea'), 
    ('united states');

DELIMITER $$

-- Stored procedure to process birth rate data for any country
CREATE PROCEDURE LoadBirthRateData(IN country_name VARCHAR(100))
BEGIN
    -- Step 1: Insert data from temp_birth_rate into the birth_rate table
    INSERT INTO birth_rate (country_id, country_name, year, birth_rate_value, annual_change)
    SELECT c.country_id, 
           country_name, 
           STR_TO_DATE(t.year, '%m/%d/%Y'), 
           t.birth_rate_value, 
           t.annual_change
    FROM temp_birth_rate t
    JOIN countries c ON c.country_name = country_name;

    -- Step 2: Clean up the temporary table
    TRUNCATE TABLE temp_birth_rate;
END$$

DELIMITER ;

-- Create the birth_rate table if it doesn't exist
DROP TABLE IF EXISTS birth_rate;

CREATE TABLE birth_rate (
    country_id INT,
    country_name VARCHAR(100) NOT NULL,
    year DATE,
    birth_rate_value DECIMAL(5,3),
    annual_change DECIMAL(5,3) NULL,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

DROP TEMPORARY TABLE IF EXISTS temp_birth_rate; 

CREATE TEMPORARY TABLE temp_birth_rate (
    year VARCHAR(10),
    birth_rate_value DECIMAL(5,3),
    annual_change DECIMAL(5,3) NULL
);

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/birth_rate/angola_birth_rate.csv'
INTO TABLE temp_birth_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, birth_rate_value, annual_change);


CALL LoadBirthRateData('angola');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/birth_rate/bangladesh_birth_rate.csv'
INTO TABLE temp_birth_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, birth_rate_value, annual_change);


CALL LoadBirthRateData('bangladesh');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/birth_rate/benin_birth_rate.csv'
INTO TABLE temp_birth_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, birth_rate_value, annual_change);


CALL LoadBirthRateData('benin');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/birth_rate/china_birth_rate.csv'
INTO TABLE temp_birth_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, birth_rate_value, annual_change);


CALL LoadBirthRateData('china');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/birth_rate/egypt_birth_rate.csv'
INTO TABLE temp_birth_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, birth_rate_value, annual_change);


CALL LoadBirthRateData('egypt');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/birth_rate/italy_birth_rate.csv'
INTO TABLE temp_birth_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, birth_rate_value, annual_change);


CALL LoadBirthRateData('italy');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/birth_rate/japan_birth_rate.csv'
INTO TABLE temp_birth_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, birth_rate_value, annual_change);


CALL LoadBirthRateData('japan');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/birth_rate/niger_birth_rate.csv'
INTO TABLE temp_birth_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, birth_rate_value, annual_change);


CALL LoadBirthRateData('niger');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/birth_rate/south-korea_birth_rate.csv'
INTO TABLE temp_birth_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, birth_rate_value, annual_change);


CALL LoadBirthRateData('south korea');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/birth_rate/united-states_birth_rate.csv'
INTO TABLE temp_birth_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, birth_rate_value, annual_change);


CALL LoadBirthRateData('united states');


DELIMITER $$

-- Stored procedure to process fertility rate data for any country
CREATE PROCEDURE LoadFertilityRateData(IN country_name VARCHAR(100))
BEGIN
    -- Step 1: Insert data from temp_fertility_rate into the fertility_rate table
    INSERT INTO fertility_rate (country_id, country_name, year, fertility_rate_value, annual_change)
    SELECT c.country_id, 
           country_name, 
           STR_TO_DATE(t.year, '%Y-%m-%d'), 
           t.fertility_rate_value, 
           t.annual_change
    FROM temp_fertility_rate t
    JOIN countries c ON c.country_name = country_name;

    -- Step 2: Clean up the temporary table
    TRUNCATE TABLE temp_fertility_rate;
END$$

DELIMITER ;

-- Create the fertility_rate table if it doesn't exist
DROP TABLE IF EXISTS fertility_rate;

CREATE TABLE fertility_rate (
    country_id INT,
    country_name VARCHAR(100) NOT NULL,
    year DATE,
    fertility_rate_value DECIMAL(5,3),
    annual_change DECIMAL(5,3) NULL,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

-- Create the temporary table
DROP TEMPORARY TABLE IF EXISTS temp_fertility_rate;

CREATE TEMPORARY TABLE temp_fertility_rate (
    year VARCHAR(10),
    fertility_rate_value DECIMAL(5,3),
    annual_change DECIMAL(5,3) NULL
);

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/fertility_replacement_rate/angola_fertility_rate.csv'
INTO TABLE temp_fertility_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, fertility_rate_value, annual_change);


CALL LoadFertilityRateData('angola');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/fertility_replacement_rate/bangladesh_fertility_rate.csv'
INTO TABLE temp_fertility_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, fertility_rate_value, annual_change);

CALL LoadFertilityRateData('bangladesh');


LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/fertility_replacement_rate/benin_fertility_rate.csv'
INTO TABLE temp_fertility_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, fertility_rate_value, annual_change);

CALL LoadFertilityRateData('benin');


LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/fertility_replacement_rate/china_fertility_rate.csv'
INTO TABLE temp_fertility_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, fertility_rate_value, annual_change);

CALL LoadFertilityRateData('china');


LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/fertility_replacement_rate/egypt_fertility_rate.csv'
INTO TABLE temp_fertility_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, fertility_rate_value, annual_change);

CALL LoadFertilityRateData('egypt');


LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/fertility_replacement_rate/italy_fertility_rate.csv'
INTO TABLE temp_fertility_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, fertility_rate_value, annual_change);

CALL LoadFertilityRateData('italy');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/fertility_replacement_rate/japan_fertility_rate.csv'
INTO TABLE temp_fertility_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, fertility_rate_value, annual_change);

CALL LoadFertilityRateData('japan');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/fertility_replacement_rate/niger_fertility_rate.csv'
INTO TABLE temp_fertility_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, fertility_rate_value, annual_change);

CALL LoadFertilityRateData('niger');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/fertility_replacement_rate/south-korea_fertility_rate.csv'
INTO TABLE temp_fertility_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, fertility_rate_value, annual_change);

CALL LoadFertilityRateData('south korea');

LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/fertility_replacement_rate/united-states_fertility_rate.csv'
INTO TABLE temp_fertility_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, fertility_rate_value, annual_change);

CALL LoadFertilityRateData('united states');


DROP PROCEDURE IF EXISTS LoadDeathRateData;

DELIMITER $$

-- Stored procedure to process death rate data for any country
CREATE PROCEDURE LoadDeathRateData(IN country_name VARCHAR(100))
BEGIN
    -- Insert data from temp_death_rate into the death_rate table
    INSERT INTO death_rate (country_id, country_name, year, death_rate_value, annual_change)
    SELECT c.country_id, 
           country_name, 
           STR_TO_DATE(t.year, '%Y-%m-%d'), 
           t.death_rate_value, 
           t.annual_change
    FROM temp_death_rate t
    JOIN countries c ON c.country_name = country_name;

    -- Clean up the temporary table
    TRUNCATE TABLE temp_death_rate;
END$$

DELIMITER ;

-- Drop the death_rate table if it exists
DROP TABLE IF EXISTS death_rate;

-- Create the death_rate table
CREATE TABLE death_rate (
    country_id INT,
    country_name VARCHAR(100) NOT NULL,
    year DATE,
    death_rate_value DECIMAL(5,3),
    annual_change DECIMAL(5,3) NULL,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

-- Drop the temp_death_rate table if it exists
DROP TEMPORARY TABLE IF EXISTS temp_death_rate;

-- Create the temp_death_rate table
CREATE TEMPORARY TABLE temp_death_rate (
    year VARCHAR(10),
    death_rate_value DECIMAL(5,3),
    annual_change DECIMAL(5,3) NULL
);

-- Load data for Angola
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/death_rate/angola_death_rate.csv'
INTO TABLE temp_death_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, death_rate_value, annual_change);

-- Call the procedure to insert Angola's data
CALL LoadDeathRateData('angola');

-- Load data for Bangladesh
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/death_rate/bangladesh_death_rate.csv'
INTO TABLE temp_death_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, death_rate_value, annual_change);

-- Call the procedure to insert Bangladesh's data
CALL LoadDeathRateData('bangladesh');

-- Load data for Benin
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/death_rate/benin_death_rate.csv'
INTO TABLE temp_death_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, death_rate_value, annual_change);

-- Call the procedure to insert Benin's data
CALL LoadDeathRateData('benin');

-- Load data for China
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/death_rate/china_death_rate.csv'
INTO TABLE temp_death_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, death_rate_value, annual_change);

-- Call the procedure to insert China's data
CALL LoadDeathRateData('china');

-- Load data for Egypt
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/death_rate/egypt_death_rate.csv'
INTO TABLE temp_death_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, death_rate_value, annual_change);

-- Call the procedure to insert Egypt's data
CALL LoadDeathRateData('egypt');

-- Load data for Italy
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/death_rate/italy_death_rate.csv'
INTO TABLE temp_death_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, death_rate_value, annual_change);

-- Call the procedure to insert Italy's data
CALL LoadDeathRateData('italy');

-- Load data for Japan
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/death_rate/japan_death_rate.csv'
INTO TABLE temp_death_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, death_rate_value, annual_change);

-- Call the procedure to insert Japan's data
CALL LoadDeathRateData('japan');

-- Load data for Niger
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/death_rate/niger_death_rate.csv'
INTO TABLE temp_death_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, death_rate_value, annual_change);

-- Call the procedure to insert Niger's data
CALL LoadDeathRateData('niger');

-- Load data for South Korea
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/death_rate/south-korea_death_rate.csv'
INTO TABLE temp_death_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, death_rate_value, annual_change);

-- Call the procedure to insert South Korea's data
CALL LoadDeathRateData('south korea');

-- Load data for United States
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/death_rate/united-states_death_rate.csv'
INTO TABLE temp_death_rate
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, death_rate_value, annual_change);

-- Call the procedure to insert United States' data
CALL LoadDeathRateData('united states');


DROP PROCEDURE IF EXISTS LoadGDPData;

DELIMITER $$

-- Stored procedure to process GDP data for any country
CREATE PROCEDURE LoadGDPData(IN country_name VARCHAR(100))
BEGIN
    -- Insert data from temp_gdp into the gdp table
    INSERT INTO gdp (country_id, country_name, year, gdp_value, per_capita, annual_change)
    SELECT c.country_id, 
           country_name, 
           STR_TO_DATE(t.year, '%Y-%m-%d'), 
           t.gdp_value, 
           t.per_capita,
           t.annual_change
    FROM temp_gdp t
    JOIN countries c ON c.country_name = country_name;

    -- Clean up the temporary table
    TRUNCATE TABLE temp_gdp;
END$$

DELIMITER ;

-- Drop the gdp table if it exists
DROP TABLE IF EXISTS gdp;

-- Create the gdp table
CREATE TABLE gdp (
    country_id INT,
    country_name VARCHAR(100) NOT NULL,
    year DATE,
    gdp_value DECIMAL(15,5) NULL,
    per_capita DECIMAL(15,5) NULL,
    annual_change DECIMAL(10,4) NULL,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

-- Drop the temp_gdp table if it exists
DROP TEMPORARY TABLE IF EXISTS temp_gdp;

-- Create the temp_gdp table
CREATE TEMPORARY TABLE temp_gdp (
    year VARCHAR(10),
    gdp_value VARCHAR(255) NULL,        -- Store as string initially
    per_capita VARCHAR(255) NULL,       -- Store as string initially
    annual_change DECIMAL(6,4) NULL
);

-- Load data for Angola
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/gdp/angola-gdp-gross-domestic-product.csv'
INTO TABLE temp_gdp
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, gdp_value, per_capita, annual_change);

-- Modify columns to proper data types
ALTER TABLE temp_gdp
MODIFY COLUMN gdp_value DECIMAL(15,5),
MODIFY COLUMN per_capita DECIMAL(15,5);

-- Call the procedure to insert Angola's data
CALL LoadGDPData('angola');

-- Load data for Bangladesh
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/gdp/bangladesh-gdp-gross-domestic-product.csv'
INTO TABLE temp_gdp
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, gdp_value, per_capita, annual_change);

ALTER TABLE temp_gdp
MODIFY COLUMN gdp_value DECIMAL(15,5),
MODIFY COLUMN per_capita DECIMAL(15,5);

CALL LoadGDPData('bangladesh');

-- Load data for Benin
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/gdp/benin-gdp-gross-domestic-product.csv'
INTO TABLE temp_gdp
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, gdp_value, per_capita, annual_change);

ALTER TABLE temp_gdp
MODIFY COLUMN gdp_value DECIMAL(15,5),
MODIFY COLUMN per_capita DECIMAL(15,5);

CALL LoadGDPData('benin');

-- Load data for China
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/gdp/china-gdp-gross-domestic-product.csv'
INTO TABLE temp_gdp
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, gdp_value, per_capita, annual_change);

ALTER TABLE temp_gdp
MODIFY COLUMN gdp_value DECIMAL(15,5),
MODIFY COLUMN per_capita DECIMAL(15,5);

CALL LoadGDPData('china');

-- Load data for Egypt
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/gdp/egypt-gdp-gross-domestic-product.csv'
INTO TABLE temp_gdp
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, gdp_value, per_capita, annual_change);

ALTER TABLE temp_gdp
MODIFY COLUMN gdp_value DECIMAL(15,5),
MODIFY COLUMN per_capita DECIMAL(15,5);

CALL LoadGDPData('egypt');

-- Load data for Italy
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/gdp/italy-gdp-gross-domestic-product.csv'
INTO TABLE temp_gdp
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, gdp_value, per_capita, annual_change);

ALTER TABLE temp_gdp
MODIFY COLUMN gdp_value DECIMAL(15,5),
MODIFY COLUMN per_capita DECIMAL(15,5);

CALL LoadGDPData('italy');

-- Load data for Japan
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/gdp/japan-gdp-gross-domestic-product.csv'
INTO TABLE temp_gdp
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, gdp_value, per_capita, annual_change);

ALTER TABLE temp_gdp
MODIFY COLUMN gdp_value DECIMAL(15,5),
MODIFY COLUMN per_capita DECIMAL(15,5);

CALL LoadGDPData('japan');

-- Load data for Niger
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/gdp/niger-gdp-gross-domestic-product.csv'
INTO TABLE temp_gdp
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, gdp_value, per_capita, annual_change);

ALTER TABLE temp_gdp
MODIFY COLUMN gdp_value DECIMAL(15,5),
MODIFY COLUMN per_capita DECIMAL(15,5);

CALL LoadGDPData('niger');

-- Load data for South Korea
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/gdp/south-korea-gdp-gross-domestic-product.csv'
INTO TABLE temp_gdp
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, gdp_value, per_capita, annual_change);

ALTER TABLE temp_gdp
MODIFY COLUMN gdp_value DECIMAL(15,5),
MODIFY COLUMN per_capita DECIMAL(15,5);

CALL LoadGDPData('south korea');

-- Load data for United States
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/gdp/united-states-gdp-gross-domestic-product.csv'
INTO TABLE temp_gdp
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, gdp_value, per_capita, annual_change);

ALTER TABLE temp_gdp
MODIFY COLUMN gdp_value DECIMAL(15,5),
MODIFY COLUMN per_capita DECIMAL(15,5);

CALL LoadGDPData('united states');


DROP PROCEDURE IF EXISTS LoadPopulationData;

DELIMITER $$

-- Stored procedure to process population data for any country
CREATE PROCEDURE LoadPopulationData(IN country_name VARCHAR(100))
BEGIN
    -- Insert data from temp_population into the population table
    INSERT INTO population (country_id, country_name, year, population_value, annual_change)
    SELECT c.country_id, 
           country_name, 
           STR_TO_DATE(t.year, '%Y-%m-%d'), 
           t.population_value, 
           t.annual_change
    FROM temp_population t
    JOIN countries c ON c.country_name = country_name;

    -- Clean up the temporary table
    TRUNCATE TABLE temp_population;
END$$

DELIMITER ;

-- Drop the population table if it exists
DROP TABLE IF EXISTS population;

-- Create the population table
CREATE TABLE population (
    country_id INT,
    country_name VARCHAR(100) NOT NULL,
    year DATE,
    population_value DECIMAL(15,5) NULL,
    annual_change DECIMAL(10,4) NULL,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

-- Drop the temp_population table if it exists
DROP TEMPORARY TABLE IF EXISTS temp_population;

-- Create the temp_population table
CREATE TEMPORARY TABLE temp_population (
    year VARCHAR(10),
    population_value VARCHAR(255) NULL,
    annual_change DECIMAL(10,4) NULL
);


-- Load data for Angola
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/population/angola-population-2024-10-12.csv'
INTO TABLE temp_population
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, population_value, annual_change);

-- Modify columns to proper data types
ALTER TABLE temp_population
MODIFY COLUMN population_value DECIMAL(15,5);

-- Call the procedure to insert Angola's data
CALL LoadPopulationData('angola');

-- Load data for Bangladesh
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/population/bangladesh-population-2024-10-12.csv'
INTO TABLE temp_population
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, population_value, annual_change);

ALTER TABLE temp_population
MODIFY COLUMN population_value DECIMAL(15,5);

CALL LoadPopulationData('bangladesh');

-- Load data for Benin
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/population/benin-population-2024-10-12.csv'
INTO TABLE temp_population
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, population_value, annual_change);

ALTER TABLE temp_population
MODIFY COLUMN population_value DECIMAL(15,5);

CALL LoadPopulationData('benin');

-- Load data for China
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/population/china-population-2024-10-12.csv'
INTO TABLE temp_population
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, population_value, annual_change);

ALTER TABLE temp_population
MODIFY COLUMN population_value DECIMAL(15,5);

CALL LoadPopulationData('china');

-- Load data for Egypt
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/population/egypt-population-2024-10-12.csv'
INTO TABLE temp_population
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, population_value, annual_change);

ALTER TABLE temp_population
MODIFY COLUMN population_value DECIMAL(15,5);

CALL LoadPopulationData('egypt');

-- Load data for Italy
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/population/italy-population-2024-10-12.csv'
INTO TABLE temp_population
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, population_value, annual_change);

ALTER TABLE temp_population
MODIFY COLUMN population_value DECIMAL(15,5);

CALL LoadPopulationData('italy');

-- Load data for Japan
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/population/japan-population-2024-10-12.csv'
INTO TABLE temp_population
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, population_value, annual_change);

ALTER TABLE temp_population
MODIFY COLUMN population_value DECIMAL(15,5);

CALL LoadPopulationData('japan');

-- Load data for Niger
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/population/niger-population-2024-10-12.csv'
INTO TABLE temp_population
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, population_value, annual_change);

ALTER TABLE temp_population
MODIFY COLUMN population_value DECIMAL(15,5);

CALL LoadPopulationData('niger');

-- Load data for South Korea
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/population/south-korea-population-2024-10-12.csv'
INTO TABLE temp_population
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, population_value, annual_change);

ALTER TABLE temp_population
MODIFY COLUMN population_value DECIMAL(15,5);

CALL LoadPopulationData('south korea');

-- Load data for United States
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/population/united-states-population-2024-10-12.csv'
INTO TABLE temp_population
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, population_value, annual_change);

ALTER TABLE temp_population
MODIFY COLUMN population_value DECIMAL(15,5);

CALL LoadPopulationData('united states');

DROP PROCEDURE IF EXISTS LoadUrbanizationData;

DELIMITER $$

-- Stored procedure to process urbanization data for any country
CREATE PROCEDURE LoadUrbanizationData(IN country_name VARCHAR(100))
BEGIN
    -- Insert data from temp_urbanization into the urbanization table
    INSERT INTO urbanization (country_id, country_name, year, urban_population_value, urban_population_percent, annual_change)
    SELECT c.country_id, 
           country_name, 
           STR_TO_DATE(t.year, '%Y-%m-%d'), 
           t.urban_population_value, 
           t.urban_population_percent,
           t.annual_change
    FROM temp_urbanization t
    JOIN countries c ON c.country_name = country_name;

    -- Clean up the temporary table
    TRUNCATE TABLE temp_urbanization;
END$$

DELIMITER ;


-- Drop the urbanization table if it exists
DROP TABLE IF EXISTS urbanization;

-- Create the urbanization table
CREATE TABLE urbanization (
    country_id INT,
    country_name VARCHAR(100) NOT NULL,
    year DATE,
    urban_population_value DECIMAL(15,5) NULL,
    urban_population_percent DECIMAL(5,2) NULL,
    annual_change DECIMAL(10,4) NULL,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

-- Drop the temp_urbanization table if it exists
DROP TEMPORARY TABLE IF EXISTS temp_urbanization;

-- Create the temp_urbanization table
CREATE TEMPORARY TABLE temp_urbanization (
    year VARCHAR(10),
    urban_population_value VARCHAR(255) NULL,
    urban_population_percent DECIMAL(5,2) NULL,
    annual_change DECIMAL(10,4) NULL
);


-- Load data for Italy
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/urbanization/italy-urban-population.csv'
INTO TABLE temp_urbanization
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, urban_population_value, urban_population_percent, annual_change);

ALTER TABLE temp_urbanization
MODIFY COLUMN urban_population_value DECIMAL(15,5);

CALL LoadUrbanizationData('italy');

-- Load data for Japan
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/urbanization/japan-urban-population.csv'
INTO TABLE temp_urbanization
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, urban_population_value, urban_population_percent, annual_change);

ALTER TABLE temp_urbanization
MODIFY COLUMN urban_population_value DECIMAL(15,5);

CALL LoadUrbanizationData('japan');

-- Load data for Niger
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/urbanization/niger-urban-population.csv'
INTO TABLE temp_urbanization
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, urban_population_value, urban_population_percent, annual_change);

ALTER TABLE temp_urbanization
MODIFY COLUMN urban_population_value DECIMAL(15,5);

CALL LoadUrbanizationData('niger');

-- Load data for South Korea
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/urbanization/south-korea-urban-population.csv'
INTO TABLE temp_urbanization
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, urban_population_value, urban_population_percent, annual_change);

ALTER TABLE temp_urbanization
MODIFY COLUMN urban_population_value DECIMAL(15,5);

CALL LoadUrbanizationData('south korea');

-- Load data for United States
LOAD DATA LOCAL INFILE '/Users/alliewrubel/Documents/GitHub/Data607_project3/data/urbanization/united-states-urban-population.csv'
INTO TABLE temp_urbanization
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(year, urban_population_value, urban_population_percent, annual_change);

ALTER TABLE temp_urbanization
MODIFY COLUMN urban_population_value DECIMAL(15,5);

CALL LoadUrbanizationData('united states');






