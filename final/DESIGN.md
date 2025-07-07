# Design Document

By Maryna Ohinska

Video overview [here](https://youtu.be/gfHJiDbNW6A)

---

## Scope

This database models a simple social networking platform focused on user-generated content and interactions. The core entities and features supported include:

- **Users**: profiles containing basic personal info, bio, privacy settings, and follower counts.
- **Posts**: content created by users, including text, location, timestamps, and engagement counts (likes and comments).
- **Comments**: replies to posts made by users.
- **Likes**: reactions from users to posts, tracked uniquely per user-post pair.
- **Tags**: topical hashtags or keywords associated with posts.

Additional functionality includes automatic updating of counts on posts (likes, comments) and users (followers) via database triggers to maintain data consistency.

---

## Functional Requirements

The database supports the following operations:

- CRUD operations on users, posts, comments, likes, followers, and tags.
- Tracking post engagement via like counts and comment counts, kept up to date automatically.
- Maintaining follower counts on user profiles.
- Supporting many-to-many relationships: users can follow multiple users; posts can have multiple tags; users can like multiple posts.
- Enforcing referential integrity with cascading deletes, so removing a user also deletes their posts, comments, likes, followers, and tags accordingly.

---

## Representation

## Entity Relationship Diagram

![diagram](diagram.png)

### Tables and Columns

#### Users

- `id` (INTEGER, PRIMARY KEY): Unique identifier.
- `first_name` (TEXT, NOT NULL)
- `last_name` (TEXT, NOT NULL)
- `username` (TEXT, UNIQUE, NOT NULL): Unique user handle.
- `birthday` (DATE, NOT NULL)
- `bio` (TEXT): Optional user biography.
- `date_joined` (DATETIME, NOT NULL, DEFAULT CURRENT_TIMESTAMP)
- `private` (INTEGER, NOT NULL, CHECK 0 or 1, DEFAULT 0): Privacy setting.
- `followers_count` (INTEGER, NOT NULL, DEFAULT 0): Number of followers.

#### Posts

- `id` (INTEGER, PRIMARY KEY)
- `content` (TEXT, NOT NULL): Post text content.
- `user_id` (INTEGER, NOT NULL, FOREIGN KEY → users.id ON DELETE CASCADE)
- `date_created` (DATETIME, NOT NULL, DEFAULT CURRENT_TIMESTAMP)
- `location` (TEXT): Optional location data.
- `like_count` (INTEGER, NOT NULL, DEFAULT 0)
- `comment_count` (INTEGER, NOT NULL, DEFAULT 0)

#### Comments

- `id` (INTEGER, PRIMARY KEY)
- `user_id` (INTEGER, NOT NULL, FOREIGN KEY → users.id ON DELETE CASCADE)
- `post_id` (INTEGER, NOT NULL, FOREIGN KEY → posts.id ON DELETE CASCADE)
- `comment` (TEXT, NOT NULL)

#### Likes

- `user_id` (INTEGER, NOT NULL, FOREIGN KEY → users.id ON DELETE CASCADE)
- `post_id` (INTEGER, NOT NULL, FOREIGN KEY → posts.id ON DELETE CASCADE)
- PRIMARY KEY(user_id, post_id)

#### Followers

- `user_id` (INTEGER, NOT NULL, FOREIGN KEY → users.id ON DELETE CASCADE)
- `follower_id` (INTEGER, NOT NULL, FOREIGN KEY → users.id ON DELETE CASCADE, CHECK follower_id <> user_id)
- PRIMARY KEY(user_id, follower_id)

#### Tags

- `id` (INTEGER, PRIMARY KEY)
- `post_id` (INTEGER, NOT NULL, FOREIGN KEY → posts.id ON DELETE CASCADE)
- `tag` (TEXT, NOT NULL)

---

## Relationships

- A user can create many posts; each post belongs to exactly one user.
- A post can have many comments; each comment is made by one user on one post.
- Users can like many posts; each like references one user and one post uniquely.
- Users can follow many other users (except themselves).
- Posts can have many tags to describe topics or keywords.

---

## Triggers and Data Integrity

The following triggers maintain count columns automatically to keep denormalized engagement data accurate:

- `increment_like_count` / `decrement_like_count` — update `posts.like_count` on insert/delete of likes.
- `increment_comment_count` / `decrement_comment_count` — update `posts.comment_count` on insert/delete of comments.
- `increment_followers_count` / `decrement_followers_count` — update `users.followers_count` on insert/delete of followers.

This ensures data consistency without requiring application-level logic.

---

## Indexes

To optimize common queries, the following indexes are created:

- On `users(first_name, last_name)` — to search users by name.
- On `users(username)` — to lookup users by username.
- On `posts(content)` — to enable searching posts by text.
- On `posts(user_id)` — to find posts by user.
- On `comments(post_id)` — to find comments on a post.
- On `tags(post_id)` — to find tags for a post.

---

## Limitations

- No support for post media (images, videos).
- No support for private messaging or group interactions.
- Scalability may be limited by denormalized counts and triggers in very large datasets.
- User roles, or content moderation could be added.
