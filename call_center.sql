-- -----------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------- Collecting our data -----------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------

-- first off, before importing our data we should create a database to load our data into it
-- or just load our table into an existing database.

CREATE DATABASE project;

-- We want to work on our databse.
USE project;

-- Create a table that will contain the csv file we want to import.
CREATE TABLE calls( ID CHAR(50),
					customer_name CHAR(50),
                    sentiment CHAR(50),
                    csat_score INT,
                    call_timestamp CHAR(50),
                    reason CHAR(50),
                    city CHAR(50),
                    state CHAR(50),
                    channel CHAR(50),
                    response_time CHAR(50),
                    call_duration_minutes INT,
                    call_center CHAR(50) );
                    
		
-- Here we used table data import wizard and loaded our data in. Let's check how it looks.

SELECT * FROM calls;

-- -----------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------- Cleaning our data -------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------

-- The call_timestamp is a string, so we need to convert it to a date.

SET SQL_SAFE_UPDATES = 0;

UPDATE calls SET call_timestamp = str_to_date(call_timestamp, "%m/%d/%Y");

UPDATE calls SET csat_score = NULL WHERE csat_score = 0;

SET SQL_SAFE_UPDATES = 1;

-- -----------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------- Exploring our data ------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------

-- lets see the shape pf our data, i.e, the number of columns and rows

SELECT COUNT(*) AS num_of_rows FROM calls;

SELECT COUNT(*) AS num_of_cols
FROM information_schema.columns
WHERE table_name = 'calls';

-- Checking the distinct values of some columns

SELECT DISTINCT sentiment FROM calls;
SELECT DISTINCT reason FROM calls;
SELECT DISTINCT channel FROM calls;
SELECT DISTINCT response_time FROM calls;
SELECT DISTINCT call_center FROM calls;

-- The count and precentage from total of each of the distinct values we got
SELECT sentiment,
       COUNT(*) AS count, 
       ROUND((COUNT(*)/ (SELECT COUNT(*) FROM calls))* 100,1) AS pct
FROM calls
GROUP BY 1
ORDER BY 3 DESC      ;

SELECT reason,
       COUNT(*) AS count,
       ROUND((COUNT(*) / (SELECT COUNT(*) FROM calls)) * 100, 1) AS pct
FROM calls
GROUP BY reason
ORDER BY pct DESC ;

SELECT channel,
	   COUNT(*) AS count,
       ROUND((COUNT(*) / (SELECT COUNT(*) FROM calls ))*100,1) AS pct
FROM calls
GROUP BY channel
ORDER BY pct DESC;

SELECT response_time,
       COUNT(*) AS count,
       ROUND(( COUNT(*) / (SELECT COUNT(*) FROM calls)) * 100,1) AS pct
FROM calls
GROUP BY 1
ORDER BY 3 DESC ;

SELECT call_center,
       COUNT(*) AS count,
       ROUND((COUNT(*) / (SELECT COUNT(*) FROM calls)) * 100,1) AS pct
FROM calls
GROUP BY 1
ORDER BY 3 DESC;

SELECT state,
       COUNT(*) FROM calls
GROUP BY 1
ORDER BY 2 DESC;

--- Aggregations

SELECT MIN(csat_score) AS min_csat_score,
       MAX(csat_score) AS max_csat_score,
       ROUND(AVG(csat_score),1) AS avg_csat_score
FROM calls
WHERE csat_score <> 0;

SELECT MIN(call_timestamp) AS earliest_date,
       MAX(call_timestamp) AS latest_date
FROM calls;

SELECT MIN(call_duration_minutes) AS min_duration,
       MAX(call_duration_minutes) AS max_duration,
       AVG(call_duration_minutes) AS avg_duration
FROM calls ;

SELECT call_center,
       response_time,
	   COUNT(*) AS counts
FROM calls
GROUP BY 1,2
ORDER BY 3 DESC ;

SELECT call_center,
       AVG(call_duration_minutes) AS avg_duration
FROM calls
GROUP BY 1
ORDER BY 2 DESC ;

SELECT channel,
       AVG(call_duration_minutes) AS avg_duration
FROM calls
GROUP BY 1
ORDER BY 2  ;

SELECT state,
       COUNT(*) AS count
FROM calls
GROUP BY 1
ORDER BY 2  ;

SELECT state,
        reason,
       COUNT(*) AS count
FROM calls
GROUP BY 1, 2
ORDER BY 1,2,3  desc  ;

SELECT state,
       sentiment,
       COUNT(*) AS count
FROM calls
GROUP BY 1,2
ORDER BY 1, 3 DESC   ;

SELECT state,
       AVG(csat_score) AS avg_score
FROM calls
WHERE csat_score <> 0
GROUP BY 1
ORDER  BY 1 DESC   ;

SELECT sentiment,
       AVG(call_duration_minutes) AS avg_duration_minutes 
FROM calls
GROUP BY 1
ORDER BY 2 DESC   ;






