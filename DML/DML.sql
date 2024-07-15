INSERT INTO  music.users (user_name, contact_info)
VALUES 
    ('coolcat123',' coolcat123@example.com'),
    ('happyhippo', 'happyhippo@example.com'),
    ('lazyturtle', 'lazyturtle@example.com'),
    ('smartpenguin', 'smartpenguin@example.com'),
    ('funnybunny', 'funnybunny@example.com'),
    ('bravebear', 'bravebear@example.com'),
    ('sneakyfox', 'sneakyfox@example.com'),
    ('tinyant', 'tinyant@example.com'),
    ('cleverowl', 'cleverowl@example.com'),
    ('fastcheetah', 'fastcheetah@example.com');

INSERT INTO music.compositions (title, genre, save_file_format)
VALUES 
    ('Symphony No. 1', 'Classical', 'MP3'),
    ('Jazz in Paris', 'Jazz', 'WAV'),
    ('Rock Anthem', 'Rock', 'FLAC'),
    ('Electro Beat', 'Electronic', 'AAC'),
    ('Hip Hop Vibes', 'Hip Hop', 'OGG'),
    ('Country Roads', 'Country', 'MP3'),
    ('Pop Hit', 'Pop', 'WAV'),
    ('Blues for You', 'Blues', 'FLAC'),
    ('Reggae Rhythms', 'Reggae', 'AAC'),
    ('Metal Fury', 'Metal', 'OGG'),
    ('Indie Dreams', 'Indie', 'MP3'),
    ('Folk Stories', 'Folk', 'WAV'),
    ('Latin Groove', 'Latin', 'FLAC'),
    ('Soulful Tunes', 'Soul', 'AAC'),
    ('Punk Rock', 'Punk', 'OGG'),
    ('Classical Serenity', 'Classical', 'MP3'),
    ('Jazz Nights', 'Jazz', 'WAV'),
    ('Hard Rock', 'Rock', 'FLAC'),
    ('Techno Waves', 'Electronic', 'AAC'),
    ('R&B Flavors', 'R&B', 'OGG');

INSERT INTO music.tags (tag_name)
VALUES
    ('Relaxing'),
    ('Energetic'),
    ('Instrumental'),
    ('Vocal'),
    ('Live'),
    ('Studio'),
    ('Acoustic'),
    ('Electronic'),
    ('Upbeat'),
    ('Mellow'),
    ('Dance'),
    ('Ambient'),
    ('Cover'),
    ('Remix'),
    ('Original');
INSERT INTO music.composition_tags (composition_id, tag_id)
VALUES
(1, 1), 
(2, 3), 
(3, 9), 
(4, 8),
(5, 11), 
(6, 4), 
(7, 15), 
(8, 3),
(9, 14), 
(10, 2), 
(11, 4), 
(12, 10),
(13, 11), 
(14, 2), 
(15, 11);

INSERT INTO music.visibility(visibility_type)
VALUES
    ('public'),
    ('registered_user'),
    ('selected_user');

INSERT INTO music.authors(composition_id, user_id)
VALUES
(1,3),
(2,5),
(3,5),
(4,4),
(5,3),
(6,5),
(7,4),
(8,7),
(9,3),
(10,3),
(11,3),
(12,4),
(13,7),
(14,5),
(15,4);

-- композиції з composition_id від 1 до 7 будуть доступні всім авторам з типом доступу selected_user, 
-- а композиції з composition_id від 8 до 15 будуть доступні всім користувачам з доступом public.

INSERT INTO music.composition_visibility (composition_id, user_id, visibility_id)
SELECT c.composition_id, a.user_id, v.visibility_id
FROM music.compositions c
JOIN music.authors a ON c.composition_id = a.composition_id
JOIN music.visibility v ON v.visibility_type = 'selected_user'
WHERE c.composition_id BETWEEN 1 AND 7;

INSERT INTO music.composition_visibility (composition_id, user_id, visibility_id)
SELECT c.composition_id, u.user_id, v.visibility_id
FROM music.compositions c
CROSS JOIN music.users u
JOIN music.visibility v ON v.visibility_type = 'public'
WHERE c.composition_id BETWEEN 8 AND 15;

INSERT INTO music.supporting_materials (user_id, material_type, content)
VALUES 
(3, 'text', 'Lyrics of Symphony No. 1'),
(4, 'music', 'https://example.com/music/jazz_in_paris.mp3'),
(5, 'graphic_logos', 'https://example.com/images/rock_anthem_cover.jpg'),
(7, 'text', 'Blues for You'),
(3, 'music', 'https://example.com/music/hip_hop_vibes_instrumental.mp3'),
(4, 'graphic_logos', 'https://example.com/images/bluesy_morning_poster.jpg'),
(5, 'text', 'Lyrics of Soulful Nights'),
(7, 'music', 'https://example.com/music/country_roads_demo.mp3'),
(3, 'graphic_logos', 'https://example.com/images/indie_anthem_banner.jpg'),
(4, 'text', 'Chords for Pop Hit');

INSERT INTO music.composition_supporting_materials (composition_id, material_id)
VALUES 
(1, 1),
(12, 2),
(3, 3),
(8, 4),
(5, 5),
(7, 6),
(8, 7),
(8, 8),
(11, 9),
(7, 10);

INSERT INTO music.comments (composition_id, user_id, comment_text, parent_comment_id)
VALUES 
(1, 3, 'Amazing symphony!', NULL),
(2, 4, 'Loved the jazz vibes!', NULL),
(3, 5, 'Rock anthem of the year!', NULL),
(1, 7, 'Could not agree more!', 1), 
(4, 3, 'The beats are electrifying!', NULL);