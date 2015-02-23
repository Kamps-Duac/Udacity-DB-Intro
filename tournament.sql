-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP TABLE IF EXISTS match CASCADE;
DROP TABLE IF EXISTS player CASCADE;

CREATE TABLE player ( 
	id SERIAL, 
	name TEXT,
	created_by text DEFAULT current_user,
	created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE match ( 
	id SERIAL, 
	winner_id integer,
	loser_id integer,
	created_by text DEFAULT current_user,
	created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE VIEW standings AS
	SELECT
		p.id as id,
		p.name as name,
		(SELECT count(*) FROM match m
			WHERE p.id = m.winner_id) as wins,
		(SELECT count(*) FROM match m
			WHERE p.id = m.winner_id OR 
			p.id = m.loser_id) as matches
	FROM player p
	ORDER BY wins DESC;




