---------------------------------Functions & Stored Procedures-------------------
--Функція для обчислення кількості коментарів до композиції
CREATE OR REPLACE FUNCTION music.get_comment_count(p_composition_id BIGINT)
RETURNS INTEGER AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM music.comments WHERE composition_id = p_composition_id);
END;
$$ LANGUAGE plpgsql;
--
SELECT music.get_comment_count(1) AS comment_count;

--Функція для отримання повного імені користувача
CREATE OR REPLACE FUNCTION music.get_full_name(p_user_id BIGINT)
RETURNS TEXT AS $$
BEGIN
    RETURN (SELECT user_name FROM music.users WHERE user_id = p_user_id);
END;
$$ LANGUAGE plpgsql;
--
SELECT music.get_full_name(1) AS full_name;

--Перевірка наявності користувача
CREATE OR REPLACE FUNCTION music.user_exists(p_user_id BIGINT)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (SELECT 1 FROM music.users WHERE user_id = p_user_id);
END;
$$ LANGUAGE plpgsql;
--
SELECT music.user_exists(1) AS user_exists;



-------------Створення збережених процедур із оператором UPDATE 

--Оновлення жанру композиції
CREATE OR REPLACE PROCEDURE music.update_composition_genre (
    p_composition_id BIGINT,
    p_new_genre VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE music.compositions
    SET genre = p_new_genre
    WHERE composition_id = p_composition_id;
END;
$$;


CALL music.update_composition_genre(1, 'ClassiacalGenre');

--Оновлення тексту коментаря
CREATE OR REPLACE PROCEDURE music.update_comment_text (
    p_comment_id BIGINT,
    p_new_comment_text VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE music.comments
    SET comment_text = p_new_comment_text
    WHERE comment_id = p_comment_id;
END;
$$;

CALL music.update_comment_text(1, 'This is the updated comment text.');

-----------Створення збережених процедур із оператором INSERT----------
--Процедура для додавання нової композиції
CREATE OR REPLACE PROCEDURE music.insert_composition (
    p_title VARCHAR,
    p_genre VARCHAR,
    p_save_file_format VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO music.compositions (title, genre, save_file_format)
    VALUES (p_title, p_genre, p_save_file_format);
END;
$$;

CALL music.insert_composition('New Symphony', 'Classical', 'MP3');

--Процедура для додавання нового коментаря
CREATE OR REPLACE PROCEDURE music.insert_comment (
    p_composition_id BIGINT,
    p_user_id BIGINT,
    p_comment_text VARCHAR,
    p_parent_comment_id BIGINT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO music.comments (composition_id, user_id, comment_text, parent_comment_id)
    VALUES (p_composition_id, p_user_id, p_comment_text, p_parent_comment_id);
END;
$$;

CALL music.insert_comment(1, 2, 'This is a new comment.', NULL);