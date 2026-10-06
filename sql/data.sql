USE boekenplatform;

-- =========================
-- Dummy data: Gebruiker
-- =========================
INSERT INTO Gebruiker (naam, email, wachtwoord, rol) VALUES
('Jan de Vries', 'jan@example.com', 'test123', 'student'),
('Sophie Jansen', 'sophie@example.com', 'test123', 'student'),
('Mohamed El Amrani', 'mohamed@example.com', 'test123', 'student'),
('Lisa Bakker', 'lisa@example.com', 'test123', 'student'),
('Daan Smit', 'daan@example.com', 'test123', 'student'),
('Emma Visser', 'emma@example.com', 'test123', 'student'),
('Beheerder', 'admin@boekenplatform.nl', 'admin123', 'beheerder');


-- =========================
-- Dummy data: Boek
-- =========================
INSERT INTO Boek 
(titel, auteur, conditie, prijs, categorie, locatie, eigenaar_id) VALUES
('De Aanslag', 'Harry Mulisch', 'goed', 8.50, 'Literatuur', 'Rotterdam', 1),
('Het Diner', 'Herman Koch', 'gebruikt', 6.00, 'Literatuur', 'Amsterdam', 2),
('Clean Code', 'Robert C. Martin', 'goed', 25.00, 'Programmeren', 'Rotterdam', 3),
('Java: The Complete Reference', 'Herbert Schildt', 'nieuw', 30.00, 'Programmeren', 'Utrecht', 4),
('Basisboek Marketing', 'Philip Kotler', 'gebruikt', 15.00, 'Marketing', 'Den Haag', 5),
('Harry Potter en de Steen der Wijzen', 'J.K. Rowling', 'goed', 10.00, 'Fantasy', 'Rotterdam', 6),
('Introduction to Algorithms', 'Thomas H. Cormen', 'goed', 35.00, 'Informatica', 'Amsterdam', 1),
('De ontdekking van de hemel', 'Harry Mulisch', 'gebruikt', 9.50, 'Literatuur', 'Utrecht', 2),
('Python Crash Course', 'Eric Matthes', 'nieuw', 22.50, 'Programmeren', 'Rotterdam', 3),
('Economics', 'Paul Samuelson', 'gebruikt', 18.00, 'Economie', 'Den Haag', 4);


-- =========================
-- Dummy data: Transactie
-- =========================
INSERT INTO Transactie 
(status, koper_id, verkoper_id, boek_id) VALUES
('voltooid', 2, 1, 1),
('in behandeling', 4, 2, 2),
('voltooid', 5, 3, 3),
('in behandeling', 6, 4, 4),
('geannuleerd', 1, 5, 5),
('voltooid', 3, 6, 6);


-- =========================
-- Dummy data: Bericht
-- =========================
INSERT INTO Bericht 
(inhoud, verzender_id, ontvanger_id) VALUES
('Hallo, is het boek nog beschikbaar?', 2, 1),
('Ja, het boek is nog beschikbaar.', 1, 2),
('Kun je iets met de prijs doen?', 4, 2),
('Ik kan het boek voor 5 euro verkopen.', 2, 4),
('Wanneer kan ik het boek ophalen?', 5, 3),
('Je kunt het morgenmiddag ophalen.', 3, 5),
('Is het boek nog in goede staat?', 6, 4),
('Ja, er staan alleen wat kleine gebruikssporen in.', 4, 6);


-- =========================
-- Dummy data: Beoordeling
-- =========================
INSERT INTO Beoordeling 
(score, recensie, beoordelaar_id, beoordeelde_id) VALUES
(5, 'Zeer vriendelijke verkoper en snelle overdracht.', 2, 1),
(4, 'Boek was in goede staat en alles verliep goed.', 5, 3),
(5, 'Snelle communicatie en netjes afgehandeld.', 3, 6),
(3, 'Prima boek, maar de communicatie kon beter.', 4, 2),
(4, 'Goede ervaring, boek zag er netjes uit.', 6, 4);


-- =========================
-- Dummy data: Notificatie
-- =========================
INSERT INTO Notificatie 
(bericht, gelezen, gebruiker_id) VALUES
('Je hebt een nieuw bericht ontvangen.', FALSE, 1),
('Je transactie is voltooid.', TRUE, 2),
('Je hebt een nieuw bericht ontvangen.', FALSE, 3),
('Je boek is verkocht.', FALSE, 4),
('Je transactie is geannuleerd.', TRUE, 5),
('Je hebt een nieuwe beoordeling ontvangen.', FALSE, 6),
('Er is een nieuwe gebruiker geregistreerd.', TRUE, 7);
        

-- =========================
-- Dummy data: Advertentie
-- =========================
INSERT INTO Advertentie 
(status, boek_id, gebruiker_id) VALUES
('actief', 1, 1),
('verkocht', 2, 2),
('verkocht', 3, 3),
('actief', 4, 4),
('verwijderd', 5, 5),
('verkocht', 6, 6),
('actief', 7, 1),
('actief', 8, 2),
('actief', 9, 3),
('actief', 10, 4);