DROP DATABASE IF EXISTS airitaly;
CREATE DATABASE IF NOT EXISTS airitaly;
USE airitaly;

CREATE TABLE IF NOT EXISTS airport (
	code char(3) NOT NULL,
	city varchar(20) NOT NULL,
  	hub boolean NOT NULL,
	country varchar(20) NOT NULL,
	PRIMARY KEY (code)    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS flight (
	id char(5) NOT NULL,
	duration time NOT NULL,
	distance int NOT NULL,
	departureTime time NOT NULL,
	arrivalTime time NOT NULL,
	departureAirport char(3) NOT NULL,
	arrivalAirport char(3) NOT NULL,
	PRIMARY KEY (id),
    FOREIGN KEY (departureAirport) REFERENCES airport (code),
    FOREIGN KEY (arrivalAirport) REFERENCES airport (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS aircraft (
	registration char(4) NOT NULL,
	manufacturer varchar(20) NOT NULL,
	model varchar(20) NOT NULL,
	year year NOT NULL,
	PRIMARY KEY (registration)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS pilot (
	pilotId char(4) NOT NULL,
	firstName varchar(20) NOT NULL,
	lastName varchar(20) NOT NULL,
    gender char(1) NOT NULL,
	birthDate date NOT NULL,
	PRIMARY KEY (pilotId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS passenger (
	fiscalCode char(16) NOT NULL,
	firstName varchar(20) NOT NULL,
	lastName varchar(20) NOT NULL,
	birthDate date NOT NULL,
	phone char(10) UNIQUE NOT NULL,
	PRIMARY KEY (fiscalCode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS trip (
	flightId char(5) NOT NULL,
	flightDate date NOT NULL,
	status enum ('completed', 'in progress', 'scheduled'),
	aircraftRegistration char(4) NOT NULL,
	pilotId char(4) NOT NULL,
	PRIMARY KEY (flightDate, flightId),
    FOREIGN KEY (flightId) REFERENCES flight (id),
    FOREIGN KEY (pilotId) REFERENCES pilot (pilotId),
    FOREIGN KEY (aircraftRegistration) REFERENCES aircraft (registration),
	UNIQUE KEY (flightDate, pilotId),
	UNIQUE KEY (flightDate, aircraftRegistration)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS booking (
	bookingId char(5) NOT NULL,
    passengerFiscalCode char(16) NOT NULL,
    flightId char(5) NOT NULL,
	flightDate date NOT NULL,
    PRIMARY KEY (bookingId),
    FOREIGN KEY (passengerFiscalCode) REFERENCES passenger (fiscalCode),
    FOREIGN KEY (flightId) REFERENCES trip (flightId),
    FOREIGN KEY (flightDate) REFERENCES trip (flightDate),
    UNIQUE KEY (passengerFiscalCode, flightId, flightDate)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
