CREATE EXTERNAL TABLE IF NOT EXISTS title_ext (
    title_id STRING,
    actors_num INT
)
COMMENT 'title'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS SEQUENCEFILE
location '/user/damian_j_cybulski/titles';

CREATE EXTERNAL TABLE IF NOT EXISTS title_basics_ext (
    tconst STRING,
    titleType STRING,
    primaryTitle STRING,
    originalTitle STRING,
    isAdult INT,
    startYear INT,
    endYear INT,
    runtimeMinutes INT,
    genres STRING
)
COMMENT 'title_basics'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
location '/user/damian_j_cybulski/title_basics';

CREATE EXTERNAL TABLE IF NOT EXISTS result (
    genre STRING,
    movies INT,
    actors INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.JsonSerDe' 
STORED AS TEXTFILE
location '/user/damian_j_cybulski/output6';

INSERT INTO TABLE result 
select 
    a.genre as genre, 
    count(a.genre) as movies, 
    sum(b.actors_num) as actors 
from (
    select 
        genre, 
        a.tconst as title_id 
    from title_basics_ext a lateral view explode(split(a.genres, ",")) title_basics_ext as genre 
    where a.titleType = "movie") a
inner join title_ext b on a.title_id = b.title_id 
group by a.genre 
order by actors desc 
limit 3;