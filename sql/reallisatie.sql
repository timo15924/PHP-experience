CREATE DATABASE IF NOT EXISTS boekenplatform;
USE boekenplatform;

-- =========================
-- Tabel: Gebruiker
-- =========================
CREATE TABLE Gebruiker (
    id INT PRIMARY KEY AUTO_INCREMENT,
    naam VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    wachtwoord VARCHAR(255) NOT NULL,
    rol ENUM('student', 'beheerder') NOT NULL
);

-- =========================
-- Tabel: Boek
-- =========================
CREATE TABLE Boek (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titel VARCHAR(255) NOT NULL,
    auteur VARCHAR(255) NOT NULL,
    conditie ENUM('nieuw', 'goed', 'gebruikt') NOT NULL,
    prijs DECIMAL(10,2) NOT NULL,
    categorie VARCHAR(100) NOT NULL,
    locatie VARCHAR(100) NOT NULL,
    eigenaar_id INT NOT NULL,

    CONSTRAINT fk_boek_eigenaar
        FOREIGN KEY (eigenaar_id)
        REFERENCES Gebruiker(id)
);

-- =========================
-- Tabel: Transactie
-- =========================
CREATE TABLE Transactie (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status ENUM('in behandeling', 'voltooid', 'geannuleerd') NOT NULL,
    koper_id INT NOT NULL,
    verkoper_id INT NOT NULL,
    boek_id INT NOT NULL,

    CONSTRAINT fk_transactie_koper
        FOREIGN KEY (koper_id)
        REFERENCES Gebruiker(id),

    CONSTRAINT fk_transactie_verkoper
        FOREIGN KEY (verkoper_id)
        REFERENCES Gebruiker(id),

    CONSTRAINT fk_transactie_boek
        FOREIGN KEY (boek_id)
        REFERENCES Boek(id)
);

-- =========================
-- Tabel: Bericht
-- =========================
CREATE TABLE Bericht (
    id INT PRIMARY KEY AUTO_INCREMENT,
    inhoud TEXT NOT NULL,
    verzender_id INT NOT NULL,
    ontvanger_id INT NOT NULL,

    CONSTRAINT fk_bericht_verzender
        FOREIGN KEY (verzender_id)
        REFERENCES Gebruiker(id),

    CONSTRAINT fk_bericht_ontvanger
        FOREIGN KEY (ontvanger_id)
        REFERENCES Gebruiker(id)
);

-- =========================
-- Tabel: Beoordeling
-- =========================
CREATE TABLE Beoordeling (
    id INT PRIMARY KEY AUTO_INCREMENT,
    score INT NOT NULL,
    recensie TEXT,
    beoordelaar_id INT NOT NULL,
    beoordeelde_id INT NOT NULL,

    CONSTRAINT fk_beoordeling_beoordelaar
        FOREIGN KEY (beoordelaar_id)
        REFERENCES Gebruiker(id),

    CONSTRAINT fk_beoordeling_beoordeelde
        FOREIGN KEY (beoordeelde_id)
        REFERENCES Gebruiker(id),

    CONSTRAINT chk_beoordeling_score
        CHECK (score BETWEEN 1 AND 5)
);

-- =========================
-- Tabel: Notificatie
-- =========================
CREATE TABLE Notificatie (
    id INT PRIMARY KEY AUTO_INCREMENT,
    bericht VARCHAR(255) NOT NULL,
    gelezen BOOLEAN NOT NULL DEFAULT FALSE,
    gebruiker_id INT NOT NULL,

    CONSTRAINT fk_notificatie_gebruiker
        FOREIGN KEY (gebruiker_id)
        REFERENCES Gebruiker(id)
);

-- =========================
-- Tabel: Advertentie
-- =========================
CREATE TABLE Advertentie (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status ENUM('actief', 'verwijderd', 'verkocht') NOT NULL,
    boek_id INT NOT NULL,
    gebruiker_id INT NOT NULL,

    CONSTRAINT fk_advertentie_boek
        FOREIGN KEY (boek_id)
        REFERENCES Boek(id),

    CONSTRAINT fk_advertentie_gebruiker
        FOREIGN KEY (gebruiker_id)
        REFERENCES Gebruiker(id)
);