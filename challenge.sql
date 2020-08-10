CREATE DATABASE twitterexample;

/* create users table.*/
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  email TEXT UNIQUE NOT NULL,
	username TEXT UNIQUE NOT NULL,
	hashed_password TEXT NOT NULL
)

/* create tweets table */
CREATE TABLE tweets (
  id SERIAL PRIMARY KEY,
  text TEXT,
	publication_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	poster_id INT NOT NULL,
	FOREIGN KEY (poster_id) REFERENCES users (id) ON DELETE CASCADE
)

CREATE INDEX tweet_date_indexes
ON tweets (publication_date);

/* create follows table */
CREATE TABLE follows (
	id SERIAL,
	follower_id INT,
	following_id INT,
	FOREIGN KEY (follower_id) REFERENCES users (id) ON DELETE CASCADE,
	FOREIGN KEY (following_id) REFERENCES users (id) ON DELETE CASCADE
)

/* get tweets by followers where username = mark */
SELECT DISTINCT tweets.id, tweets.text, tweets.publication_date, users.username, users.first_name
FROM (SELECT id, text, publication_date, poster_id FROM tweets ORDER BY publication_date DESC LIMIT 30) AS tweets
JOIN users ON users.id = tweets.poster_id
WHERE poster_id
IN (SELECT following_id FROM follows WHERE follower_id
IN (SELECT id FROM users WHERE username = "Mark"))
