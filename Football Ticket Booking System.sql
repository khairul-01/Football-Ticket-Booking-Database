-- SYSTEM: Football Ticket Booking System Database Setup Template

-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

-- =========================================================================
-- CREATE Database
-- =========================================================================
CREATE DATABASE "Football Ticket Booking System";

-- =========================================================================
-- CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
  user_id serial PRIMARY KEY,
  full_name varchar(200) NOT NULL,
  email varchar(200) UNIQUE NOT NULL,
  role varchar(150) NOT NULL CHECK (role IN ('Ticket Manager', 'Football Fan')),
  phone_number varchar(25)
);

-- =========================================================================
-- CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
  match_id serial PRIMARY KEY,
  fixture varchar(255) NOT NULL,
  tournament_category varchar(255),
  base_ticket_price decimal(10, 2) CHECK (base_ticket_price >= 0),
  match_status varchar(100) CHECK (
    match_status IN (
      'Available',
      'Selling Fast',
      'Sold Out',
      'Postponed'
    )
  )
);

-- =========================================================================
-- CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
  booking_id serial PRIMARY KEY,
  user_id int NOT NULL REFERENCES Users (user_id) ON DELETE CASCADE,
  match_id int NOT NULL REFERENCES Matches (match_id) ON DELETE CASCADE,
  seat_number varchar(50),
  payment_status varchar(50) CHECK (
    payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
  ),
  total_cost decimal(10, 2) NOT NULL
);

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
INSERT INTO Users (full_name, email, role, phone_number) VALUES
('Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
('Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
('Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
('Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================
INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);