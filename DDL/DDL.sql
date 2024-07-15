CREATE TABLE music.users (
    user_id BIGINT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_name VARCHAR(50) UNIQUE,
    contact_info VARCHAR(100) UNIQUE,
    CHECK (contact_info LIKE '%@%') 
);
--------------------
CREATE TABLE music.compositions (
    composition_id BIGINT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(50),
    genre VARCHAR(50),
    save_file_format VARCHAR(50),
    CHECK (save_file_format IN ('MP3', 'WAV', 'FLAC', 'AAC', 'OGG'))
);
--------------------
CREATE TABLE music.authors (
    composition_id BIGINT,
    user_id BIGINT,
    PRIMARY KEY (composition_id, user_id),
    FOREIGN KEY (composition_id) REFERENCES music.compositions(composition_id),
    FOREIGN KEY (user_id) REFERENCES music.users(user_id)
);
--------------------
CREATE TABLE music.visibility (
    visibility_id BIGINT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    visibility_type VARCHAR(50),
    CHECK (visibility_type IN ('public', 'registered_user', 'selected_user'))
);
--------------------
CREATE TABLE music.composition_visibility (
    composition_id BIGINT,
    user_id BIGINT,
    visibility_id BIGINT,
    PRIMARY KEY (composition_id, user_id, visibility_id),
    FOREIGN KEY (composition_id) REFERENCES music.compositions(composition_id),
    FOREIGN KEY (user_id) REFERENCES music.users(user_id),
    FOREIGN KEY (visibility_id) REFERENCES music.visibility(visibility_id)
);
--------------------
CREATE TABLE music.supporting_materials (
    material_id BIGINT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT,
    material_type VARCHAR(50),
    content VARCHAR(500),
    FOREIGN KEY (user_id) REFERENCES music.users(user_id),
    CHECK (material_type IN ('text', 'music', 'graphic_logos'))
);
--------------------
CREATE TABLE music.composition_supporting_materials (
    composition_id BIGINT,
    material_id BIGINT,
    PRIMARY KEY (composition_id, material_id),
    FOREIGN KEY (composition_id) REFERENCES music.compositions(composition_id),
    FOREIGN KEY (material_id) REFERENCES music.supporting_materials(material_id)
);
--------------------
CREATE TABLE music.comments (
    comment_id BIGINT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    composition_id BIGINT,
    user_id BIGINT,
    comment_text VARCHAR(500),
    parent_comment_id BIGINT,
    FOREIGN KEY (composition_id) REFERENCES music.compositions(composition_id),
    FOREIGN KEY (user_id) REFERENCES music.users(user_id),
    FOREIGN KEY (parent_comment_id) REFERENCES music.comments(comment_id)
);
--------------------
CREATE TABLE music.tags (
    tag_id BIGINT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    tag_name VARCHAR(50)
);
--------------------
CREATE TABLE music.composition_tags (
    composition_id BIGINT,
    tag_id BIGINT,
    PRIMARY KEY (composition_id, tag_id),
    FOREIGN KEY (composition_id) REFERENCES music.compositions(composition_id),
    FOREIGN KEY (tag_id) REFERENCES music.tags(tag_id)
);