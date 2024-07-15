-------------------administration------------------
CREATE ROLE read_only_role;
CREATE USER user_readonly WITH PASSWORD 'readonly_password';
GRANT read_only_role TO user_readonly;
GRANT USAGE ON SCHEMA public TO read_only_role;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_only_role;

-----
CREATE ROLE read_write_role;
CREATE USER user_readwrite WITH PASSWORD 'readwrite_password';
GRANT read_write_role TO user_readwrite;
GRANT USAGE ON SCHEMA public TO read_write_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO read_write_role;