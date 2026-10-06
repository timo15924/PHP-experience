<?php


$host = 'db';
$db   = 'beembrug';
$user = 'root';
$pass = 'root';
$charset = 'utf8mb4';

// DSN opbouw
$dsn = "mysql:host=$host;dbname=$db;charset=$charset";

$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => true  // Buggevoelig: emulatie aan i.p.v. prepared statements
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    // Log fout maar toon generieke melding 
    error_log("Databaseverbinding fout: " . $e->getMessage());
    echo "Databaseverbinding mislukt.";
    exit;
}


