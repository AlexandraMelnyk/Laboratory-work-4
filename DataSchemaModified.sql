CREATE TABLE users (
    user_email VARCHAR(50),
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    user_password VARCHAR(100),
    CONSTRAINT users_pk PRIMARY KEY (user_email),
    CONSTRAINT users_email_unique UNIQUE (user_email),
    CONSTRAINT user_email_template CHECK (user_email ~ '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$'),
    CONSTRAINT username_format CHECK (first_name ~ '^[A-Za-z]+$')
);

CREATE TABLE sports_event (
    event_title VARCHAR(50),
    event_date DATE,
    event_location VARCHAR(100),
    CONSTRAINT events_pk PRIMARY KEY (event_title)
);

CREATE TABLE event_registration (
    registration_date DATE,
    user_email VARCHAR(50),
    event_title VARCHAR(50),
    CONSTRAINT reg_pk PRIMARY KEY (user_email, event_title),
    CONSTRAINT reg_user_fk FOREIGN KEY (user_email) REFERENCES users (user_email),
    CONSTRAINT reg_event_fk FOREIGN KEY (event_title) REFERENCES sports_event (event_title)
);

CREATE TABLE payment (
    payment_date DATE,
    payment_amount NUMERIC(10, 2),
    user_email VARCHAR(50),
    event_title VARCHAR(50),
    CONSTRAINT payment_reg_fk FOREIGN KEY (user_email, event_title)
        REFERENCES event_registration (user_email, event_title)
);

CREATE TABLE restaurant (
    restaurant_name VARCHAR(50),
    rating_value NUMERIC(2, 1),
    distance_km NUMERIC(5, 1),
    event_title VARCHAR(50),
    CONSTRAINT restaurant_event_fk FOREIGN KEY (event_title) REFERENCES sports_event (event_title),
    CONSTRAINT rating_range CHECK (rating_value BETWEEN 0 AND 5)
);

CREATE TABLE notification (
    notification_text VARCHAR(255),
    send_date DATE,
    user_email VARCHAR(50),
    CONSTRAINT notif_user_fk FOREIGN KEY (user_email) REFERENCES users (user_email)
);
