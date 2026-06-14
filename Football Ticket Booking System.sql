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