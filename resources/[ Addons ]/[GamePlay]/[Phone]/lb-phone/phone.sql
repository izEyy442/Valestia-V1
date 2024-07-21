-- phone_number is the identifier used for phones in twitter etc
CREATE TABLE IF NOT EXISTS `phone_phones` (
    `id` VARCHAR(100) NOT NULL, -- if metadata - unique id for the phone; if not - player identifier
    `owner` VARCHAR(100) NOT NULL, -- the player identifier of the first person who used the phone, used for lookup app etc
    `phone_number` VARCHAR(15) NOT NULL,
    `name` VARCHAR(50),

    `pin` VARCHAR(4) DEFAULT NULL,
    `face_id` VARCHAR(100) DEFAULT NULL, -- the identifier of the face that is used for the phone
    
    `settings` LONGTEXT, -- json encoded settings
    `is_setup` BOOLEAN DEFAULT FALSE,
    `assigned` BOOLEAN DEFAULT FALSE, -- if the phone is assigned to a phone item (metadata)
    `battery` INT NOT NULL DEFAULT 100, -- battery percentage

    PRIMARY KEY (`id`),
    UNIQUE KEY (`phone_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_last_phone` (
    `identifier` VARCHAR(100) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`identifier`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_photos` (
    `phone_number` VARCHAR(15) NOT NULL,

    `link` VARCHAR(200) NOT NULL,
    `is_video` BOOLEAN DEFAULT FALSE,
    `size` FLOAT NOT NULL DEFAULT 0,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`phone_number`, `link`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_notes` (
    `id` VARCHAR(10) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    `title` VARCHAR(50) NOT NULL,
    `content` LONGTEXT, -- limit maybe?
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_notifications` (
    `id` VARCHAR(10) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    `app` VARCHAR(50) NOT NULL,

    `title` VARCHAR(50) DEFAULT NULL,
    `content` VARCHAR(500) DEFAULT NULL,
    `thumbnail` VARCHAR(250) DEFAULT NULL,
    `avatar` VARCHAR(250) DEFAULT NULL,
    `show_avatar` BOOLEAN DEFAULT FALSE,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- TWITTER
CREATE TABLE IF NOT EXISTS `phone_twitter_hashtags` (
    `hashtag` VARCHAR(50) NOT NULL,
    `amount` INT NOT NULL DEFAULT 0,
    `last_used` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`hashtag`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_accounts` (
    `display_name` VARCHAR(30) NOT NULL,

    `username` VARCHAR(20) NOT NULL,
    `password` VARCHAR(100) NOT NULL,

    `phone_number` VARCHAR(15) NOT NULL,
    `bio` VARCHAR(100) DEFAULT NULL,
    `profile_image` VARCHAR(200) DEFAULT NULL,
    `profile_header` VARCHAR(200) DEFAULT NULL,

    `pinned_tweet` VARCHAR(50) DEFAULT NULL,

    `verified` BOOLEAN DEFAULT FALSE,
    `follower_count` INT(11) NOT NULL DEFAULT 0,
    `following_count` INT(11) NOT NULL DEFAULT 0,

    `private` BOOLEAN DEFAULT FALSE,

    `date_joined` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`username`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_loggedin` (
    `phone_number` VARCHAR(15) NOT NULL,
    `username` VARCHAR(20) NOT NULL,

    PRIMARY KEY (`phone_number`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_follows` (
    `followed` VARCHAR(20) NOT NULL,
    `follower` VARCHAR(20) NOT NULL,
    `notifications` BOOLEAN NOT NULL DEFAULT FALSE, -- if the follower gets notifications from the followed

    PRIMARY KEY (`followed`, `follower`),
    FOREIGN KEY (`followed`) REFERENCES `phone_twitter_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`follower`) REFERENCES `phone_twitter_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_follow_requests` (
    `requester` VARCHAR(20) NOT NULL,
    `requestee` VARCHAR(20) NOT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`requester`, `requestee`),
    FOREIGN KEY (`requester`) REFERENCES `phone_twitter_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`requestee`) REFERENCES `phone_twitter_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_tweets` (
    `id` VARCHAR(10) NOT NULL,
    `username` VARCHAR(20) NOT NULL, -- the person who tweeted, matches to `username` in phone_twitter_accounts

    `content` VARCHAR(280),
    `attachments` TEXT, -- json array of attachments

    `reply_to` VARCHAR(50) DEFAULT NULL, -- the tweet / reply this tweet / reply was a reply to
    
    `like_count` INT(11) DEFAULT 0,
    `reply_count` INT(11) DEFAULT 0,
    `retweet_count` INT(11) DEFAULT 0,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_likes` (
    `tweet_id` VARCHAR(50) NOT NULL,
    `username` VARCHAR(20) NOT NULL, -- the person who liked the tweet / reply, matches to `username` in phone_twitter_accounts

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`tweet_id`, `username`),
    FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
    -- no foreign key on tweet_id as it should still show in the feed, even if the tweet is deleted
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_retweets` (
    `tweet_id` VARCHAR(50) NOT NULL,
    `username` VARCHAR(20) NOT NULL, -- the person who retweeted the tweet / reply, matches to `username` in phone_twitter_accounts

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`tweet_id`, `username`),
    FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
    -- no foreign key on tweet_id as it should still show in the feed, even if the tweet is deleted
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_promoted` (
    `tweet_id` VARCHAR(50) NOT NULL,
    `promotions` INT(11) NOT NULL DEFAULT 0, -- how how many times this tweet should be promoted
    `views` INT(11) NOT NULL DEFAULT 0, -- how many times this tweet has been promoted

    PRIMARY KEY (`tweet_id`),
    FOREIGN KEY (`tweet_id`) REFERENCES `phone_twitter_tweets`(`id`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_messages` (
    `id` VARCHAR(10) NOT NULL,

    `sender` VARCHAR(20) NOT NULL, -- the person who sent the message, matches to `username` in phone_twitter_accounts
    `recipient` VARCHAR(20) NOT NULL, -- the person who received the message, matches to `username` in phone_twitter_accounts

    `content` VARCHAR(1000),
    `attachments` TEXT, -- json array of attachments

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`sender`) REFERENCES `phone_twitter_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`recipient`) REFERENCES `phone_twitter_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
 
CREATE TABLE IF NOT EXISTS `phone_twitter_notifications` (
    `id` VARCHAR(10) NOT NULL,
    `username` VARCHAR(20) NOT NULL, -- the person who received the notification, matches to `username` in phone_twitter_accounts
    `from` VARCHAR(20) NOT NULL, -- the person who sent the notification, matches to `username` in phone_twitter_accounts

    `type` VARCHAR(20) NOT NULL, -- like, retweet, reply, follow 
    `tweet_id` VARCHAR(50) DEFAULT NULL, -- the tweet / reply this notification is about

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`from`) REFERENCES `phone_twitter_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- PHONE
CREATE TABLE IF NOT EXISTS `phone_phone_contacts` (
    `contact_phone_number` VARCHAR(15) NOT NULL, -- the phone number of the contact
    `firstname` VARCHAR(50) NOT NULL DEFAULT "",
    `lastname` VARCHAR(50) NOT NULL DEFAULT "",
    `profile_image` VARCHAR(200) DEFAULT NULL,
    `email` VARCHAR(50) DEFAULT NULL,
    `address` VARCHAR(50) DEFAULT NULL,
    `favourite` BOOLEAN DEFAULT FALSE,
    `phone_number` VARCHAR(15) NOT NULL, -- the phone number of the person who added the contact

    PRIMARY KEY (`contact_phone_number`, `phone_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_phone_calls` (
    `id` VARCHAR(10) NOT NULL,
    
    `caller` VARCHAR(15) NOT NULL, -- the phone number of the person who called
    `callee` VARCHAR(15) NOT NULL, -- the phone number of the person who was called

    `duration` INT(11) NOT NULL DEFAULT 0,
    `answered` BOOLEAN DEFAULT FALSE, -- whether the call was answered or not
    
    `hide_caller_id` BOOLEAN DEFAULT FALSE, -- whether the caller's phone number was hidden or not

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_phone_blocked_numbers` (
    `phone_number` VARCHAR(15) NOT NULL, -- the phone number of the person who blocked the number
    `blocked_number` VARCHAR(15) NOT NULL, -- the phone number that was blocked
    
    PRIMARY KEY (`phone_number`, `blocked_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_phone_voicemail` (
    `id` VARCHAR(10) NOT NULL,

    `caller` VARCHAR(15) NOT NULL,
    `callee` VARCHAR(15) NOT NULL,
    
    `url` VARCHAR(200) NOT NULL,
    `duration` INT NOT NULL,
    `hide_caller_id` BOOLEAN DEFAULT FALSE,
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- INSTAGRAM
CREATE TABLE IF NOT EXISTS `phone_instagram_accounts` (
    `display_name` VARCHAR(30) NOT NUll,
    
    `username` VARCHAR(20) NOT NULL,
    `password` VARCHAR(100) NOT NULL,

    `profile_image` VARCHAR(200) DEFAULT NULL,
    `bio` VARCHAR(100) DEFAULT NULL,

    `post_count` INT(11) NOT NULL DEFAULT 0,
    `story_count` INT(11) NOT NULL DEFAULT 0,
    `follower_count` INT(11) NOT NULL DEFAULT 0,
    `following_count` INT(11) NOT NULL DEFAULT 0,

    `phone_number` VARCHAR(15) NOT NULL,

    `private` BOOLEAN DEFAULT FALSE,

    `verified` BOOLEAN DEFAULT FALSE,
    `date_joined` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`username`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_loggedin` (
    `phone_number` VARCHAR(15) NOT NULL,
    `username` VARCHAR(20) NOT NULL,
    
    PRIMARY KEY (`phone_number`),
    FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_follows` (
    `followed` VARCHAR(20) NOT NULL, -- the person followed, matches to `username` in phone_instagram_accounts
    `follower` VARCHAR(20) NOT NULL, -- the person following, matches to `username` in phone_instagram_accounts

    PRIMARY KEY (`followed`, `follower`),
    FOREIGN KEY (`followed`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`follower`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_posts` (
    `id` VARCHAR(10) NOT NULL,

    `media` TEXT, -- json array of attached media
    `caption` VARCHAR(500) NOT NULL DEFAULT "",
    `location` VARCHAR(50) DEFAULT NULL,

    `like_count` INT(11) NOT NULL DEFAULT 0,
    `comment_count` INT(11) NOT NULL DEFAULT 0,

    `username` VARCHAR(20) NOT NULL, -- the person who posted, matches to `username` in phone_instagram_accounts

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 

    PRIMARY KEY (`id`),
    FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_comments` (
    `id` VARCHAR(10) NOT NULL,
    `post_id` VARCHAR(50) NOT NULL, -- the post this comment was made on, matches to `id` in phone_instagram_posts

    `username` VARCHAR(20) NOT NULL, -- the person who commented, matches to `username` in phone_instagram_accounts
    `comment` VARCHAR(500) NOT NULL DEFAULT "",
    `like_count` INT(11) NOT NULL DEFAULT 0,
    
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`post_id`) REFERENCES `phone_instagram_posts`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_likes` (
    `id` VARCHAR(10) NOT NULL, -- the post / comment this like was on, matches to `id` in phone_instagram_posts / phone_instagram_comments
    `username` VARCHAR(20) NOT NULL, -- the person who liked, matches to `username` in phone_instagram_accounts
    `is_comment` BOOLEAN NOT NULL DEFAULT FALSE, -- whether this like was on a comment or a post
    
    PRIMARY KEY (`id`, `username`),
    FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_messages` (
    `id` VARCHAR(10) NOT NULL,

    `sender` VARCHAR(20) NOT NULL, -- the person who sent the message, matches to `username` in phone_instagram_accounts
    `recipient` VARCHAR(20) NOT NULL, -- the person who received the message, matches to `username` in phone_instagram_accounts

    `content` VARCHAR(1000),
    `attachments` TEXT, -- json array of attachments

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`sender`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`recipient`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_notifications` (
    `id` VARCHAR(10) NOT NULL,
    `username` VARCHAR(20) NOT NULL, 
    `from` VARCHAR(20) NOT NULL, 

    `type` VARCHAR(20) NOT NULL, -- like, comment, follow 
    `post_id` VARCHAR(50) DEFAULT NULL, -- the post / comment this notification is about

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`from`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_stories` (
    `id` VARCHAR(10) NOT NULL,
    `username` VARCHAR(20) NOT NULL, 
    `image` VARCHAR(200) NOT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_stories_views` (
    `story_id` VARCHAR(50) NOT NULL,
    `viewer` VARCHAR(20) NOT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`story_id`, `viewer`),
    FOREIGN KEY (`story_id`) REFERENCES `phone_instagram_stories`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`viewer`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_follow_requests` (
    `requester` VARCHAR(20) NOT NULL,
    `requestee` VARCHAR(20) NOT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`requester`, `requestee`),
    FOREIGN KEY (`requester`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`requestee`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CLOCK
CREATE TABLE IF NOT EXISTS `phone_clock_alarms` (
    `id` VARCHAR(10) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    `hours` INT(2) NOT NULL DEFAULT 0,
    `minutes` INT(2) NOT NULL DEFAULT 0,

    `label` VARCHAR(50) DEFAULT NULL,
    `enabled` BOOLEAN DEFAULT TRUE,

    PRIMARY KEY (`id`, `phone_number`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- TINDER
CREATE TABLE IF NOT EXISTS `phone_tinder_accounts` (
    `name` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    `photos` TEXT, -- json array of photos
    `bio` VARCHAR(500) DEFAULT NULL,
    `dob` DATE NOT NULL,

    `is_male` BOOLEAN NOT NULL,
    `interested_men` BOOLEAN NOT NULL,
    `interested_women` BOOLEAN NOT NULL,

    PRIMARY KEY (`phone_number`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tinder_swipes` (
    `swiper` VARCHAR(15) NOT NULL, -- the phone number of the person who swiped
    `swipee` VARCHAR(15) NOT NULL, -- the phone number of the person who was swiped on
    
    `liked` BOOLEAN NOT NULL DEFAULT FALSE, -- whether the swiper liked the swipee or not

    PRIMARY KEY (`swiper`, `swipee`),
    FOREIGN KEY (`swiper`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`swipee`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tinder_matches` (
    `phone_number_1` VARCHAR(15) NOT NULL,
    `phone_number_2` VARCHAR(15) NOT NULL,

    `latest_message` VARCHAR(1000) DEFAULT NULL, -- the latest message sent between the two people
    `latest_message_timestamp` TIMESTAMP, -- the timestamp of the latest message sent between the two people

    PRIMARY KEY (`phone_number_1`, `phone_number_2`),
    FOREIGN KEY (`phone_number_1`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`phone_number_2`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tinder_messages` (
    `id` VARCHAR(10) NOT NULL, -- the message id
    
    `sender` VARCHAR(15) NOT NULL, -- the phone number of the person who sent the message
    `recipient` VARCHAR(15) NOT NULL, -- the phone number of the person who received the message

    `content` VARCHAR(1000),
    `attachments` TEXT, -- json array of attachments

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`sender`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`recipient`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- IMESSAGE
CREATE TABLE IF NOT EXISTS `phone_message_channels` (
    `channel_id` VARCHAR(50) NOT NULL,
    `is_group` BOOLEAN NOT NULL DEFAULT FALSE,
    `name` VARCHAR(50) DEFAULT NULL,
    `last_message` VARCHAR(50) NOT NULL DEFAULT "",
    `last_message_timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`channel_id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_message_members` (
    `channel_id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    `is_owner` BOOLEAN NOT NULL DEFAULT FALSE,
    `deleted` BOOLEAN NOT NULL DEFAULT FALSE, -- if the member has deleted the channel
    `unread` INT NOT NULL DEFAULT 0,

    PRIMARY KEY (`channel_id`, `phone_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_message_messages` (
    `id` VARCHAR(10) NOT NULL,
    `channel_id` VARCHAR(50) NOT NULL,
    `sender` VARCHAR(15) NOT NULL,
    `content` VARCHAR(1000),
    `attachments` TEXT, -- json array of attachments
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- DARKCHAT
CREATE TABLE IF NOT EXISTS `phone_darkchat_accounts` (
    `phone_number` VARCHAR(15) NOT NULL,
    `username` VARCHAR(20) NOT NULL,

    PRIMARY KEY (`username`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_darkchat_channels` (
    `name` VARCHAR(50) NOT NULL,
    `last_message` VARCHAR(50) NOT NULL DEFAULT "",
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`name`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_darkchat_members` (
    `channel_name` VARCHAR(50) NOT NULL,
    `username` VARCHAR(20) NOT NULL,

    PRIMARY KEY (`channel_name`, `username`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_darkchat_messages` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `channel` VARCHAR(50) NOT NULL,
    `sender` VARCHAR(20) NOT NULL,
    `content` VARCHAR(1000),
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- WALLET
CREATE TABLE IF NOT EXISTS `phone_wallet_transactions` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `phone_number` VARCHAR(15) NOT NULL,
    
    `amount` INT(11) NOT NULL,
    `company` VARCHAR(50) NOT NULL,
    `logo` VARCHAR(200) DEFAULT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- YELLOW PAGES
CREATE TABLE IF NOT EXISTS `phone_yellow_pages_posts` (
    `id` VARCHAR(10) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    `title` VARCHAR(50) NOT NULL,
    `description` VARCHAR(1000) NOT NULL,

    `attachment` VARCHAR(500) DEFAULT NULL,
    `price` INT(11) DEFAULT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- BACKUPS
CREATE TABLE IF NOT EXISTS `phone_backups` (
    `identifier` VARCHAR(100) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    PRIMARY KEY (`identifier`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- MARKETPLACE
CREATE TABLE IF NOT EXISTS `phone_marketplace_posts` (
    `id` VARCHAR(10) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    `title` VARCHAR(50) NOT NULL,
    `description` VARCHAR(1000) NOT NULL,
    `attachments` TEXT, -- json array of attachments
    `price` INT(11) NOT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- MUSIC
CREATE TABLE IF NOT EXISTS `phone_music_playlists` (
    `id` VARCHAR(10) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    `name` VARCHAR(50) NOT NULL,
    `cover` VARCHAR(500) DEFAULT NULL,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_music_saved_playlists` (
    `playlist_id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    PRIMARY KEY (`playlist_id`, `phone_number`),
    FOREIGN KEY (`playlist_id`) REFERENCES `phone_music_playlists`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_music_songs` (
    `song_id` VARCHAR(100) NOT NULL,
    `playlist_id` VARCHAR(50) NOT NULL,

    PRIMARY KEY (`song_id`, `playlist_id`),
    FOREIGN KEY (`playlist_id`) REFERENCES `phone_music_playlists`(`id`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- MAIL
CREATE TABLE IF NOT EXISTS `phone_mail_accounts` (
    `address` VARCHAR(100) NOT NULL,
    `password` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`address`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_mail_loggedin` (
    `address` VARCHAR(100) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    PRIMARY KEY (`phone_number`),
    FOREIGN KEY (`address`) REFERENCES `phone_mail_accounts`(`address`) ON DELETE CASCADE,
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_mail_messages` (
    `id` VARCHAR(10) NOT NULL,

    `recipient` VARCHAR(100) NOT NULL,
    `sender` VARCHAR(100) NOT NULL,

    `subject` VARCHAR(100) NOT NULL,
    `content` TEXT NOT NULL,
    `attachments` LONGTEXT, -- json array of attachments
    `actions` LONGTEXT, -- json array of actions

    `read` BOOLEAN NOT NULL DEFAULT FALSE,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- COMPANIES APP
CREATE TABLE IF NOT EXISTS `phone_services_channels` (
    `id` VARCHAR(10) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    `company` VARCHAR(50) NOT NULL,

    `last_message` VARCHAR(100) DEFAULT NULL,
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_services_messages` (
    `id` VARCHAR(10) NOT NULL,
    `channel_id` VARCHAR(50) NOT NULL,

    `sender` VARCHAR(15) NOT NULL,
    `message` VARCHAR(1000) NOT NULL,

    `x_pos` INT(11) DEFAULT NULL,
    `y_pos` INT(11) DEFAULT NULL,
    
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`channel_id`) REFERENCES `phone_services_channels`(`id`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- MAPS
CREATE TABLE IF NOT EXISTS `phone_maps_locations` (
    `id` VARCHAR(10) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    `name` VARCHAR(50) NOT NULL,

    `x_pos` FLOAT NOT NULL,
    `y_pos` FLOAT NOT NULL,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CRYPTO
CREATE TABLE IF NOT EXISTS `phone_crypto` (
    `identifier` VARCHAR(100) NOT NULL, -- player identifier
    `coin` VARCHAR(15) NOT NULL, -- coin, for example "bitcoin"
    `amount` DOUBLE NOT NULL DEFAULT 0, -- amount of coins
    `invested` INT(11) NOT NULL DEFAULT 0, -- amount of $$$ invested

    PRIMARY KEY (`identifier`, `coin`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- ACCOUNT SWITCHER
CREATE TABLE IF NOT EXISTS `phone_logged_in_accounts` (
    `phone_number` VARCHAR(15) NOT NULL,
    `app` VARCHAR(50) NOT NULL,
    `username` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`phone_number`, `app`, `username`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- TIKTOK
CREATE TABLE IF NOT EXISTS `phone_tiktok_accounts` (
    `name` VARCHAR(30) NOT NULL,
    `bio` VARCHAR(100) DEFAULT NULL,
    `avatar` VARCHAR(200) DEFAULT NULL,

    `username` VARCHAR(20) NOT NULL,
    `password` VARCHAR(100) NOT NULL,

    `verified` BOOLEAN DEFAULT FALSE,

    `follower_count` INT(11) NOT NULL DEFAULT 0,
    `following_count` INT(11) NOT NULL DEFAULT 0,
    `like_count` INT(11) NOT NULL DEFAULT 0,
    `video_count` INT(11) NOT NULL DEFAULT 0,

    `twitter` VARCHAR(20) DEFAULT NULL,
    `instagram` VARCHAR(20) DEFAULT NULL,

    `show_likes` BOOLEAN DEFAULT TRUE,

    `phone_number` VARCHAR(15) NOT NULL,
    `date_joined` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`username`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_loggedin` (
    `username` VARCHAR(20) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    PRIMARY KEY (`phone_number`),
    FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_follows` (
    `followed` VARCHAR(20) NOT NULL,
    `follower` VARCHAR(20) NOT NULL,

    PRIMARY KEY (`followed`, `follower`),
    FOREIGN KEY (`followed`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`follower`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_videos` (
    `id` VARCHAR(10) NOT NULL,

    `username` VARCHAR(20) NOT NULL,

    `src` VARCHAR(200) NOT NULL,
    `caption` VARCHAR(100) DEFAULT NULL,
    `metadata` LONGTEXT, -- json array of metadata
    `music` TEXT DEFAULT NULL,

    `likes` INT(11) NOT NULL DEFAULT 0,
    `comments` INT(11) NOT NULL DEFAULT 0,
    `views` INT(11) NOT NULL DEFAULT 0,
    `saves` INT(11) NOT NULL DEFAULT 0,

    `pinned_comment` VARCHAR(10) DEFAULT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_likes` (
    `username` VARCHAR(20) NOT NULL,
    `video_id` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`username`, `video_id`),
    FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_views` (
    `username` VARCHAR(20) NOT NULL,
    `video_id` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`username`, `video_id`),
    FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_saves` (
    `username` VARCHAR(20) NOT NULL,
    `video_id` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`username`, `video_id`),
    FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_comments` (
    `id` VARCHAR(10) NOT NULL,
    `reply_to` VARCHAR(10) DEFAULT NULL,
    `video_id` VARCHAR(10) NOT NULL,

    `username` VARCHAR(20) NOT NULL,
    `comment` VARCHAR(550) NOT NULL,

    `likes` INT(11) NOT NULL DEFAULT 0,
    `replies` INT(11) NOT NULL DEFAULT 0,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`reply_to`) REFERENCES `phone_tiktok_comments`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_comments_likes` (
    `username` VARCHAR(20) NOT NULL,
    `comment_id` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`username`, `comment_id`),
    FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`comment_id`) REFERENCES `phone_tiktok_comments`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_channels` (
    `id` VARCHAR(10) NOT NULL,

    `last_message` VARCHAR(50) NOT NULL,

    `member_1` VARCHAR(20) NOT NULL,
    `member_2` VARCHAR(20) NOT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    UNIQUE KEY (`member_1`, `member_2`),
    FOREIGN KEY (`member_1`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`member_2`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_messages` (
    `id` VARCHAR(10) NOT NULL,
    `channel_id` VARCHAR(10) NOT NULL,
    `sender` VARCHAR(20) NOT NULL,

    `content` VARCHAR(500) NOT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`channel_id`) REFERENCES `phone_tiktok_channels`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`sender`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_pinned_videos` (
    `username` VARCHAR(20) NOT NULL,
    `video_id` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`username`, `video_id`),
    FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_notifications` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(20) NOT NULL,
    
    `from` VARCHAR(20) NOT NULL,
    `type` VARCHAR(20) NOT NULL, -- like, comment, follow, save, reply or like_comment
    `video_id` VARCHAR(10) DEFAULT NULL,
    `comment_id` VARCHAR(10) DEFAULT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`from`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`comment_id`) REFERENCES `phone_tiktok_comments`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tiktok_unread_messages` (
    `username` VARCHAR(20) NOT NULL,
    `channel_id` VARCHAR(10) NOT NULL,
    `amount` INT(11) NOT NULL DEFAULT 0,

    PRIMARY KEY (`username`, `channel_id`),
    FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`channel_id`) REFERENCES `phone_tiktok_channels`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- VOICE MEMOS
CREATE TABLE IF NOT EXISTS `phone_voice_memos_recordings` (
    `id` VARCHAR(10) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    
    `file_name` VARCHAR(50) NOT NULL,
    `file_url` VARCHAR(100) NOT NULL,
    `file_length` INT(11) NOT NULL,
    
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`phone_number`) REFERENCES `phone_phones`(`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DELIMITER //

-- Instagram triggers
-- Triggers for post counts
CREATE TRIGGER IF NOT EXISTS phone_instagram_increment_post_count
AFTER INSERT ON phone_instagram_posts
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_accounts
    SET post_count = post_count + 1
    WHERE username = NEW.username;
END;

CREATE TRIGGER IF NOT EXISTS phone_instagram_decrement_post_count
AFTER DELETE ON phone_instagram_posts
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_accounts
    SET post_count = post_count - 1
    WHERE username = OLD.username;
END;

-- Trigger for story counts
CREATE TRIGGER IF NOT EXISTS phone_instagram_increment_story_count
AFTER INSERT ON phone_instagram_stories
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_accounts
    SET story_count = story_count + 1
    WHERE username = NEW.username;
END;

CREATE TRIGGER IF NOT EXISTS phone_instagram_decrement_story_count
AFTER DELETE ON phone_instagram_stories
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_accounts
    SET story_count = story_count - 1
    WHERE username = OLD.username;
END;

-- Trigger for comment counts
CREATE TRIGGER IF NOT EXISTS phone_instagram_increment_comment_count
AFTER INSERT ON phone_instagram_comments
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_posts
    SET comment_count = comment_count + 1
    WHERE id = NEW.post_id;
END;

CREATE TRIGGER IF NOT EXISTS phone_instagram_decrement_comment_count
AFTER DELETE ON phone_instagram_comments
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_posts
    SET comment_count = comment_count - 1
    WHERE id = OLD.post_id;
END;

-- Trigger for like counts
CREATE TRIGGER IF NOT EXISTS phone_instagram_increment_like_count
AFTER INSERT ON phone_instagram_likes
FOR EACH ROW
BEGIN
    IF NEW.is_comment = 0 THEN
        UPDATE phone_instagram_posts
        SET like_count = like_count + 1
        WHERE id = NEW.id;
    ELSE
        UPDATE phone_instagram_comments
        SET like_count = like_count + 1
        WHERE id = NEW.id;
    END IF;
END;

CREATE TRIGGER IF NOT EXISTS phone_instagram_decrement_like_count
AFTER DELETE ON phone_instagram_likes
FOR EACH ROW
BEGIN
    IF OLD.is_comment = 0 THEN
        UPDATE phone_instagram_posts
        SET like_count = like_count - 1
        WHERE id = OLD.id;
    ELSE
        UPDATE phone_instagram_comments
        SET like_count = like_count - 1
        WHERE id = OLD.id;
    END IF;
END;

-- Triggers for follower counts
CREATE TRIGGER IF NOT EXISTS phone_instagram_update_counts_after_follow
AFTER INSERT ON phone_instagram_follows
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_accounts
    SET follower_count = follower_count + 1
    WHERE username = NEW.followed;

    UPDATE phone_instagram_accounts
    SET following_count = following_count + 1
    WHERE username = NEW.follower;
END;

CREATE TRIGGER IF NOT EXISTS phone_instagram_update_counts_after_unfollow
AFTER DELETE ON phone_instagram_follows
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_accounts
    SET follower_count = follower_count - 1
    WHERE username = OLD.followed;

    UPDATE phone_instagram_accounts
    SET following_count = following_count - 1
    WHERE username = OLD.follower;
END;

-- Triggers for phone_twitter_follows
CREATE TRIGGER IF NOT EXISTS phone_twitter_update_counts_after_follow
AFTER INSERT ON phone_twitter_follows
FOR EACH ROW
BEGIN
    -- Increment the follower_count for the followed user
    UPDATE phone_twitter_accounts
    SET follower_count = follower_count + 1
    WHERE username = NEW.followed;

    -- Increment the following_count for the follower user
    UPDATE phone_twitter_accounts
    SET following_count = following_count + 1
    WHERE username = NEW.follower;
END;

CREATE TRIGGER IF NOT EXISTS phone_twitter_update_counts_after_unfollow
AFTER DELETE ON phone_twitter_follows
FOR EACH ROW
BEGIN
    -- Decrement the follower_count for the followed user
    UPDATE phone_twitter_accounts
    SET follower_count = follower_count - 1
    WHERE username = OLD.followed;

    -- Decrement the following_count for the follower user
    UPDATE phone_twitter_accounts
    SET following_count = following_count - 1
    WHERE username = OLD.follower;
END;

CREATE TRIGGER IF NOT EXISTS phone_twitter_update_like_count_after_like
AFTER INSERT ON phone_twitter_likes
FOR EACH ROW
BEGIN
    UPDATE phone_twitter_tweets
    SET like_count = like_count + 1
    WHERE id = NEW.tweet_id;
END;

CREATE TRIGGER IF NOT EXISTS phone_twitter_update_like_count_after_unlike
AFTER DELETE ON phone_twitter_likes
FOR EACH ROW
BEGIN
    UPDATE phone_twitter_tweets
    SET like_count = like_count - 1
    WHERE id = OLD.tweet_id;
END;

CREATE TRIGGER IF NOT EXISTS phone_twitter_update_retweet_count_after_retweet
AFTER INSERT ON phone_twitter_retweets
FOR EACH ROW
BEGIN
    UPDATE phone_twitter_tweets
    SET retweet_count = retweet_count + 1
    WHERE id = NEW.tweet_id;
END;

CREATE TRIGGER IF NOT EXISTS phone_twitter_update_retweet_count_after_unretweet
AFTER DELETE ON phone_twitter_retweets
FOR EACH ROW
BEGIN
    UPDATE phone_twitter_tweets
    SET retweet_count = retweet_count - 1
    WHERE id = OLD.tweet_id;
END;

-- Triggers for phone_tiktok_follows
-- Increment phone_tiktok_accounts.follower_count and phone_tiktok_accounts.following_count after inserting a new row into phone_tiktok_follows
CREATE TRIGGER IF NOT EXISTS phone_tiktok_update_counts_after_follow
AFTER INSERT ON phone_tiktok_follows
FOR EACH ROW
BEGIN
    -- Increment the follower_count for the followed user
    UPDATE phone_tiktok_accounts
    SET follower_count = follower_count + 1
    WHERE username = NEW.followed;

    -- Increment the following_count for the follower user
    UPDATE phone_tiktok_accounts
    SET following_count = following_count + 1
    WHERE username = NEW.follower;
END;

-- Decrement phone_tiktok_accounts.follower_count and phone_tiktok_accounts.following_count after deleting a row from phone_tiktok_follows
CREATE TRIGGER IF NOT EXISTS phone_tiktok_update_counts_after_unfollow
AFTER DELETE ON phone_tiktok_follows
FOR EACH ROW
BEGIN
    -- Decrement the follower_count for the followed user
    UPDATE phone_tiktok_accounts
    SET follower_count = follower_count - 1
    WHERE username = OLD.followed;

    -- Decrement the following_count for the follower user
    UPDATE phone_tiktok_accounts
    SET following_count = following_count - 1
    WHERE username = OLD.follower;
END;

-- Trigger for phone_tiktok_videos
-- Trigger to increment phone_tiktok_accounts.video_count after inserting a new row into phone_tiktok_videos
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_video_count
AFTER INSERT ON phone_tiktok_videos
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_accounts
    SET video_count = video_count + 1
    WHERE username = NEW.username;
END;

-- Trigger for phone_tiktok_likes
-- Trigger to increment phone_tiktok_videos.likes after inserting a new row into phone_tiktok_likes
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_video_likes
AFTER INSERT ON phone_tiktok_likes
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_videos
    SET likes = likes + 1
    WHERE id = NEW.video_id;
END;

-- Trigger to decrement phone_tiktok_videos.likes after deleting a row from phone_tiktok_likes
CREATE TRIGGER IF NOT EXISTS phone_tiktok_decrement_video_likes
AFTER DELETE ON phone_tiktok_likes
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_videos
    SET likes = likes - 1
    WHERE id = OLD.video_id;
END;

-- Trigger to increment phone_tiktok_accounts.like_count for the user after a new like is inserted into phone_tiktok_likes
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_account_likes
AFTER INSERT ON phone_tiktok_likes
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_accounts
    JOIN phone_tiktok_videos ON phone_tiktok_videos.username = phone_tiktok_accounts.username
    SET phone_tiktok_accounts.like_count = phone_tiktok_accounts.like_count + 1
    WHERE phone_tiktok_videos.id = NEW.video_id;
END;

-- Trigger to decrement phone_tiktok_accounts.like_count for the user after a like is removed from phone_tiktok_likes
CREATE TRIGGER IF NOT EXISTS phone_tiktok_decrement_account_likes
AFTER DELETE ON phone_tiktok_likes
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_accounts
    JOIN phone_tiktok_videos ON phone_tiktok_videos.username = phone_tiktok_accounts.username
    SET phone_tiktok_accounts.like_count = phone_tiktok_accounts.like_count - 1
    WHERE phone_tiktok_videos.id = OLD.video_id;
END;

-- Triggers for phone_tiktok_views
-- Trigger to increment phone_tiktok_videos.views when a new view is inserted into phone_tiktok_views
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_video_views
AFTER INSERT ON phone_tiktok_views
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_videos
    SET views = views + 1
    WHERE id = NEW.video_id;
END;

-- Triggers for phone_tiktok_saves
-- Increment saves after inserting a new row into phone_tiktok_saves
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_video_saves
AFTER INSERT ON phone_tiktok_saves
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_videos
    SET saves = saves + 1
    WHERE id = NEW.video_id;
END;

-- Decrement saves after deleting a row from phone_tiktok_saves
CREATE TRIGGER IF NOT EXISTS phone_tiktok_decrement_video_saves
AFTER DELETE ON phone_tiktok_saves
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_videos
    SET saves = saves - 1
    WHERE id = OLD.video_id;
END;

-- Triggers for phone_tiktok_comments
-- Increment phone_tiktok_videos.comments after inserting a new row into phone_tiktok_comments
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_video_comments
AFTER INSERT ON phone_tiktok_comments
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_videos
    SET comments = comments + 1
    WHERE id = NEW.video_id;
END;

-- Decrement phone_tiktok_videos.comments after deleting a row from phone_tiktok_comments
CREATE TRIGGER IF NOT EXISTS phone_tiktok_decrement_video_comments
BEFORE DELETE ON phone_tiktok_comments
FOR EACH ROW
BEGIN
    DECLARE v_replies_count INT;

    -- Count the replies for the comment
    SELECT COUNT(*) INTO v_replies_count
    FROM phone_tiktok_comments
    WHERE reply_to = OLD.id;

    -- Update the video's comments count
    UPDATE phone_tiktok_videos
    SET comments = comments - (1 + v_replies_count)
    WHERE id = OLD.video_id;
END;

-- Triggers for phone_tiktok_comments_likes
-- Increment phone_tiktok_comments.likes after inserting a new row into phone_tiktok_comments_likes
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_comment_likes
AFTER INSERT ON phone_tiktok_comments_likes
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_comments
    SET likes = likes + 1
    WHERE id = NEW.comment_id;
END;

-- Decrement phone_tiktok_comments.likes after deleting a row from phone_tiktok_comments_likes
CREATE TRIGGER IF NOT EXISTS phone_tiktok_decrement_comment_likes
AFTER DELETE ON phone_tiktok_comments_likes
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_comments
    SET likes = likes - 1
    WHERE id = OLD.comment_id;
END;

-- Triggers for phone_tiktok_messages
-- Trigger to update phone_tiktok_channels.last_message after a new message is inserted into phone_tiktok_messages
CREATE TRIGGER IF NOT EXISTS phone_tiktok_update_last_message
AFTER INSERT ON phone_tiktok_messages
FOR EACH ROW
BEGIN
    DECLARE modified_content TEXT CHARACTER SET utf8mb4;
    
    IF NEW.content LIKE '<!SHARED-VIDEO-URL%' THEN
        SET modified_content = 'Shared a video';
    ELSEIF LENGTH(NEW.content) > 50 THEN
        SET modified_content = CONCAT(SUBSTR(NEW.content, 1, 17), '...');
    ELSE
        SET modified_content = NEW.content;
    END IF;
    
    UPDATE phone_tiktok_channels
    SET last_message = modified_content
    WHERE id = NEW.channel_id;
END;

-- Procedures for phone_tiktok_notifications
-- Procedure to make sure each notification entry is unique.
CREATE PROCEDURE IF NOT EXISTS tiktok_insert_notification_if_unique(
    IN p_username VARCHAR(20),
    IN p_from VARCHAR(20),
    IN p_type VARCHAR(20),
    IN p_video_id VARCHAR(10),
    IN p_comment_id VARCHAR(10)
)
BEGIN
    DECLARE duplicate_entry INT DEFAULT 0;

    SELECT COUNT(*)
    INTO duplicate_entry
    FROM phone_tiktok_notifications
    WHERE (username = p_username)
    AND (`from` = p_from)
    AND (`type` = p_type)
    AND (video_id = p_video_id OR (video_id IS NULL AND p_video_id IS NULL))
    AND (comment_id = p_comment_id OR (comment_id IS NULL AND p_comment_id IS NULL));

    IF duplicate_entry = 0 THEN
        INSERT INTO phone_tiktok_notifications (username, `from`, `type`, video_id, comment_id)
        VALUES (p_username, p_from, p_type, p_video_id, p_comment_id);
    END IF;
END;

//
DELIMITER ;
