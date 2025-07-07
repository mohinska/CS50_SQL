-- Creating new users
INSERT INTO users(first_name, last_name, username, birthday, bio)
VALUES
    ('Anna', 'Melnyk', 'anna.melnyk', '1995-04-12', 'Lover of hikes and mountain sunrises.'),
    ('Max', 'Petrenko', 'maxp', '1988-11-30', 'Cat dad, coffee addict, occasional photographer.'),
    ('Olena', 'Ivanova', 'olena_i', '2000-07-05', 'Software engineering student & bookworm.'),
    ('Dmytro', 'Shevchenko', 'dmytro_s', '1992-01-26', 'Travel enthusiast exploring cityscapes.');

-- Adding post
INSERT INTO posts (user_id, content, date_created)
VALUES
    (1, 'Just finished a 10‑mile hike today—feeling energized and grateful for nature', '2025-10-06 09:15:00'),
    (2, 'My coffee routine is on point ☕ New drip method, new morning vibes!', '2025-10-05 08:05:00'),
    (3, 'Dug into a Python project this weekend—built a web scraper to gather CS50 materials!', '2025-10-04 14:22:00'),
    (4, 'City photography walk in downtown—captured some amazing street murals 🎨 #citylife', '2025-10-07 17:45:00'),
    (1, 'Morning yoga by the lake—perfect start to the week. Namaste!', '2025-10-07 06:30:00'),
    (2, 'Adopted a stray kitten today named Luna—falling in love already 🐾', '2025-10-03 12:00:00');

-- Commenting on post
INSERT INTO comments (post_id, user_id, comment)
VALUES
    (1, 2, 'Amazing view! Where did you go? 🌄'),
    (1, 3, 'Wow, you’re glowing in this photo!'),
    (2, 1, 'Love that coffee vibe! ☕'),
    (3, 4, 'So inspiring! I need to build my own scraper 😄'),
    (4, 1, 'Slaying with that street art capture! 🎨'),
    (4, 2, 'This deserves its own gallery show!'),
    (5, 3, 'Namaste! That yoga by the lake looks magical ✨'),
    (6, 4, 'Luna is adorable! Congrats on the new kitty 🐱'),
    (6, 1, 'She’s such a cutie—can’t wait for more photos!');

-- Adding followers
INSERT INTO followers (user_id, follower_id)
VALUES
    (1, 2),  -- Max follows Anna
    (1, 3),  -- Olena follows Anna
    (2, 1),  -- Anna follows Max
    (3, 1),  -- Anna follows Olena
    (4, 2);  -- Max follows Dmytro

-- Adding tags for posts
INSERT INTO tags (post_id, tag)
VALUES
    (1, 'hiking'),
    (1, 'nature'),
    (2, 'wellness'),
    (2, 'morning'),
    (3, 'python'),
    (3, 'programming'),
    (4, 'photography'),
    (4, 'citylife'),
    (4, 'streetart'),
    (5, 'yoga'),
    (5, 'wellness'),
    (6, 'pets'),
    (6, 'cats'),
    (6, 'adoption');
    
-- Editing post
UPDATE posts
SET content = 'Just completed an 11-mile hike — feeling stronger and more grateful for the outdoors!',
    date_created = '2025-10-06 10:00:00'
WHERE id = 1;

UPDATE posts
SET content = 'Explored downtown again — captured stunning murals and vibrant street art! #urbanexplorer',
    date_created = '2025-10-07 18:00:00'
WHERE id = 4;

-- Deleting post
DELETE FROM posts
WHERE id = 3;

-- Generate feed for user
CREATE VIEW IF NOT EXISTS feed AS
SELECT content
FROM posts
WHERE user_id IN (
    SELECT user_id
    FROM followers
    WHERE follower_id = (
        SELECT id
        FROM users
        WHERE username = 'anna.melnyk'
    )
)
ORDER BY date_created;

SELECT * FROM feed;

-- Get info about user
SELECT *
FROM users
WHERE username = 'anna.melnyk';

-- Find posts created by user
SELECT content, date_created
FROM posts
WHERE user_id = (
    SELECT id
    FROM users
    WHERE first_name = 'Anna'
    AND last_name = 'Melnyk'
)
ORDER BY date_created;

-- Get trending tags
SELECT tag, COUNT(tag) AS mentions
FROM tags
JOIN posts ON posts.id = tags.post_id
WHERE date_created >= datetime('now', '-7 days')
GROUP BY tag
ORDER BY COUNT(tag) DESC
LIMIT 5;

-- Find author of post
SELECT username
FROM users
WHERE id IN (
    SELECT user_id
    FROM posts
    WHERE id = 2
);

-- Look up comments to the post
SELECT comment
FROM comments
WHERE post_id = 2;

-- Get posts by certain tag
SELECT content
FROM posts
WHERE id IN (
    SELECT post_id
    FROM tags
    WHERE tag = 'hiking'
);

-- Get 10 most popular users
SELECT username, SUM(like_count) + SUM(comment_count) AS score
FROM users
JOIN posts ON users.id = posts.user_id
GROUP BY users.id
ORDER BY score DESC
LIMIT 10;
