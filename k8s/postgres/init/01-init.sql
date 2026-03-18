-- 추가 DB 생성
CREATE DATABASE user_db;
CREATE DATABASE board_db;
CREATE DATABASE point_db;

-- 서비스 계정 생성
CREATE USER user_service WITH PASSWORD 'user_pw';
CREATE USER board_service WITH PASSWORD 'board_pw';
CREATE USER point_service WITH PASSWORD 'point_pw';

-- 권한 부여
GRANT ALL PRIVILEGES ON DATABASE user_db TO user_service;
GRANT ALL PRIVILEGES ON DATABASE board_db TO board_service;
GRANT ALL PRIVILEGES ON DATABASE point_db TO point_service;