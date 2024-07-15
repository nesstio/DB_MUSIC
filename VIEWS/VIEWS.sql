-----------------------------------------vievs---------------------------
--HORIZONTAL VIEW
CREATE VIEW music.horizontal_view AS 
SELECT * 
FROM music.compositions
WHERE save_file_format LIKE 'MP3';

--VERTICAL VIEW
CREATE VIEW music.vertical_view AS 
SELECT title, genre
FROM music.compositions

--MIXED VIEW
CREATE VIEW music.mixed_view AS 
SELECT title, genre, save_file_format
FROM music.compositions
WHERE save_file_format NOT LIKE 'MP3';

--WITH JOIN
CREATE VIEW music.compositions_with_authors AS 
SELECT 
    c.title,
    c.genre,
    u.user_name AS author_name
FROM 
    music.compositions c
JOIN 
    music.authors a ON c.composition_id = a.composition_id
JOIN 
    music.users u ON a.user_id = u.user_id;

--WITH SUBQUERY
CREATE VIEW music.compositions_with_comment_count AS 
SELECT 
    c.title,
    (SELECT COUNT(*) 
     FROM music.comments com 
     WHERE com.composition_id = c.composition_id) AS comment_count
FROM 
    music.compositions c;

--WITH UNION
CREATE VIEW music.jazz_and_rock_compositions AS
SELECT 
    composition_id,
    title,
    genre,
    save_file_format
FROM 
    music.compositions
WHERE 
    genre = 'Jazz'
UNION
SELECT 
    composition_id,
    title,
    genre,
    save_file_format
FROM 
    music.compositions
WHERE 
    genre = 'Rock';
    
--View on the select from another view
CREATE VIEW music.titles_with_comment_count AS
SELECT 
    title,
    comment_count
FROM 
    music.compositions_with_comment_count;

--View with check option
CREATE VIEW music.jazz_compositions_view AS
SELECT 
    composition_id,
    title,
    genre,
    save_file_format
FROM 
    music.compositions
WHERE 
    genre = 'Jazz'
WITH CHECK OPTION;

