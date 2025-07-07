-- Users: user profiles
CREATE TABLE users (
    id INTEGER,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    username TEXT UNIQUE NOT NULL,
    birthday DATE NOT NULL,
    bio TEXT,
    date_joined DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    private INTEGER NOT NULL CHECK(private IN (0, 1)) DEFAULT 0,
    followers_count INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY(id)
);

-- Posts: content created by users
CREATE TABLE posts (
    id INTEGER,
    content TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    location TEXT,
    like_count INTEGER NOT NULL DEFAULT 0,
    comment_count INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Comments: replies to posts
CREATE TABLE comments (
    id INTEGER,
    user_id INTEGER NOT NULL,
    post_id INTEGER NOT NULL,
    comment TEXT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- Likes: reactions to posts
CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    post_id INTEGER NOT NULL,
    PRIMARY KEY(user_id, post_id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- Followers: relationships between users
CREATE TABLE followers (
    user_id INTEGER NOT NULL,
    follower_id INTEGER NOT NULL CHECK(follower_id <> user_id),
    PRIMARY KEY(user_id, follower_id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(follower_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Tags: topics or hashtags associated with posts
CREATE TABLE tags (
    id INTEGER,
    post_id INTEGER NOT NULL,
    tag TEXT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- Increment and decrement like count on post
CREATE TRIGGER increment_like_count
AFTER INSERT ON likes
FOR EACH ROW
BEGIN
    UPDATE posts
    SET like_count = like_count + 1
    WHERE id = NEW.post_id;
END;

CREATE TRIGGER decrement_like_count
AFTER DELETE ON likes
FOR EACH ROW
BEGIN
    UPDATE posts
    SET like_count = like_count - 1
    WHERE id = OLD.post_id;
END;

-- Increment and decrement comment count on post
CREATE TRIGGER increment_comment_count
AFTER INSERT ON comments
FOR EACH ROW
BEGIN
    UPDATE posts
    SET comment_count = comment_count + 1
    WHERE id = NEW.post_id;
END;

CREATE TRIGGER decrement_comment_count
AFTER DELETE ON comments
FOR EACH ROW
BEGIN
    UPDATE posts
    SET comment_count = comment_count - 1
    WHERE id = OLD.post_id;
END;

-- Increment and decrement followers count of user
CREATE TRIGGER increment_followers_count
AFTER INSERT ON followers
FOR EACH ROW
BEGIN
    UPDATE users
    SET followers_count = followers_count + 1
    WHERE id = NEW.user_id;
END;

CREATE TRIGGER decrement_followers_count
AFTER DELETE ON followers
FOR EACH ROW
BEGIN
    UPDATE users
    SET followers_count = followers_count - 1
    WHERE id = OLD.user_id;
END;

-- Indexes to speed common searches
CREATE INDEX IF NOT EXISTS user_name_search ON users(first_name, last_name);
CREATE INDEX IF NOT EXISTS user_username_search ON users(username);
CREATE INDEX IF NOT EXISTS post_content_search ON posts(content);
CREATE INDEX IF NOT EXISTS posts_user_search ON posts(user_id);
CREATE INDEX IF NOT EXISTS comments_post_search ON comments(post_id);
CREATE INDEX IF NOT EXISTS tags_post_search ON tags(post_id);
