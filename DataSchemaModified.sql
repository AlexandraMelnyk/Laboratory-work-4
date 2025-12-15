CREATE TABLE users (
    email VARCHAR(50),
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    "password" VARCHAR(100),
    CONSTRAINT users_pk PRIMARY KEY (email)
);

ALTER TABLE users
ADD CONSTRAINT users_email_unique UNIQUE (email);

ALTER TABLE users
ADD CONSTRAINT user_email_template
CHECK (
    email ~ '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$'
);

ALTER TABLE users
ADD CONSTRAINT username_format
CHECK (
    first_name ~ '^[A-Za-z]+$'
);

CREATE TABLE sports_event (
    event_title VARCHAR(50),
    event_date DATE,
    location VARCHAR(100),
    CONSTRAINT events_pk PRIMARY KEY (event_title)
);

CREATE TABLE event_registration (
    registration_date DATE,
    user_email VARCHAR(50),
    event_title VARCHAR(50),
    CONSTRAINT reg_pk PRIMARY KEY (user_email, event_title)
);

ALTER TABLE event_registration
ADD CONSTRAINT reg_user_fk
FOREIGN KEY (user_email)
REFERENCES users (email);

ALTER TABLE event_registration
ADD CONSTRAINT reg_event_fk
FOREIGN KEY (event_title)
REFERENCES sports_event (event_title);

CREATE TABLE payment (
    payment_date DATE,
    amount NUMERIC(10, 2),
    user_email VARCHAR(50),
    event_title VARCHAR(50)
);

ALTER TABLE payment
ADD CONSTRAINT payment_reg_fk
FOREIGN KEY (user_email, event_title)
REFERENCES event_registration (user_email, event_title);

CREATE TABLE restaurant (
    "name" VARCHAR(50),
    rating NUMERIC(2, 1),
    distance NUMERIC(5, 1),
    event_title VARCHAR(50)
);

ALTER TABLE restaurant
ADD CONSTRAINT restaurant_event_fk
FOREIGN KEY (event_title)
REFERENCES sports_event (event_title);

ALTER TABLE restaurant
ADD CONSTRAINT rating_range
CHECK (
    rating BETWEEN 0 AND 5
);

CREATE TABLE "notification" (
    message VARCHAR(255),
    send_date DATE,
    user_email VARCHAR(50)
);

ALTER TABLE "notification"
ADD CONSTRAINT notif_user_fk
FOREIGN KEY (user_email)
REFERENCES users (email);
