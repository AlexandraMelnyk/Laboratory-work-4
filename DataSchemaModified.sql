CREATE TABLE users (
    email VARCHAR(50),
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    password_hash VARCHAR(100),
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

CREATE TABLE sports_events (
    event_title VARCHAR(50),
    event_date DATE,
    location VARCHAR(100),
    CONSTRAINT sports_events_pk PRIMARY KEY (event_title)
);

CREATE TABLE registrations (
    registration_date DATE,
    user_email VARCHAR(50),
    event_title VARCHAR(50),
    CONSTRAINT registrations_pk PRIMARY KEY (user_email, event_title)
);

ALTER TABLE registrations
ADD CONSTRAINT reg_user_fk
FOREIGN KEY (user_email)
REFERENCES users (email);

ALTER TABLE registrations
ADD CONSTRAINT reg_event_fk
FOREIGN KEY (event_title)
REFERENCES sports_events (event_title);

CREATE TABLE payments (
    payment_date DATE,
    amount NUMERIC(10, 2),
    user_email VARCHAR(50),
    event_title VARCHAR(50)
);

ALTER TABLE payments
ADD CONSTRAINT payment_reg_fk
FOREIGN KEY (user_email, event_title)
REFERENCES registrations (user_email, event_title);

CREATE TABLE restaurants (
    restaurant_name VARCHAR(50),
    rating NUMERIC(2, 1),
    distance NUMERIC(5, 1),
    event_title VARCHAR(50)
);

ALTER TABLE restaurants
ADD CONSTRAINT restaurant_event_fk
FOREIGN KEY (event_title)
REFERENCES sports_events (event_title);

ALTER TABLE restaurants
ADD CONSTRAINT rating_range
CHECK (
    rating BETWEEN 0 AND 5
);

CREATE TABLE notifications (
    message VARCHAR(255),
    send_date DATE,
    user_email VARCHAR(50)
);

ALTER TABLE notifications
ADD CONSTRAINT notif_user_fk
FOREIGN KEY (user_email)
REFERENCES users (email);


