CREATE TABLE Users (
    email VARCHAR(50),                  
    firstName VARCHAR(30),              
    lastName VARCHAR(30),               
    password VARCHAR(100),            
    CONSTRAINT users_pk PRIMARY KEY (email)
);


ALTER TABLE Users
    ADD CONSTRAINT users_email_unique UNIQUE(email);


CREATE TABLE SportsEvent (
    eventTitle VARCHAR(50),              
    eventDate DATE,                      
    location VARCHAR(100),               
    CONSTRAINT events_pk PRIMARY KEY (eventTitle)
);


CREATE TABLE EventRegistration (
    registrationDate DATE,                
    userEmail VARCHAR(50),                
    eventTitle VARCHAR(50),               
    CONSTRAINT reg_pk PRIMARY KEY (userEmail, eventTitle)
);


ALTER TABLE EventRegistration
    ADD CONSTRAINT reg_user_fk
    FOREIGN KEY (userEmail) REFERENCES Users(email);

ALTER TABLE EventRegistration
    ADD CONSTRAINT reg_event_fk
    FOREIGN KEY (eventTitle) REFERENCES SportsEvent(eventTitle);


CREATE TABLE Payment (
    paymentDate DATE,                        
    amount NUMERIC(10,2),                    
    userEmail VARCHAR(50),
    eventTitle VARCHAR(50)
);


ALTER TABLE Payment
    ADD CONSTRAINT payment_reg_fk
    FOREIGN KEY (userEmail, eventTitle)
    REFERENCES EventRegistration (userEmail, eventTitle);


CREATE TABLE Restaurant (
    name VARCHAR(50),
    rating NUMERIC(2,1),
    distance NUMERIC(5,1),
    eventTitle VARCHAR(50)
);


ALTER TABLE Restaurant
    ADD CONSTRAINT restaurant_event_fk
    FOREIGN KEY (eventTitle) REFERENCES SportsEvent(eventTitle);


CREATE TABLE Notification (
    message VARCHAR(255),
    sendDate DATE,
    userEmail VARCHAR(50)
);


ALTER TABLE Notification
    ADD CONSTRAINT notif_user_fk
    FOREIGN KEY (userEmail) REFERENCES Users(email);

ALTER TABLE Users ADD CONSTRAINT user_email_template
CHECK ( email ~ '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$' );


ALTER TABLE Users ADD CONSTRAINT username_format
CHECK ( firstName ~ '^[A-Za-z]+$' );


ALTER TABLE Restaurant ADD CONSTRAINT rating_range
CHECK ( rating BETWEEN 0 AND 5 );

