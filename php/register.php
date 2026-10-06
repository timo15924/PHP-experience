<?php

require_once 'config.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $naam = $_POST["naam"];
    $email = $_POST["email"];
    $wachtwoord = $_POST["wachtwoord"];
    $bevestig = $_POST["wachtwoord_bevestig"];
    $rol = "lid";

    $gezinslid = $_POST["gezinslid"] ?? null; 

    if ($wachtwoord !== $bevestig) {
        die("Wachtwoorden komen niet overeen.");
    }

    $hash = password_hash($wachtwoord, PASSWORD_DEFAULT);

    try {
        $stmt = $pdo->prepare("INSERT INTO users (naam, email, wachtwoord, rol) VALUES (?, ?, ?, ?)");
        $stmt->execute([$naam, $email, $hash, $rol]);

        header("Location: ../login.html");
    } catch (PDOException $e) {
        echo $naam . "<br>";
        echo $email . "<br>";
        echo $hash . "<br>";
        echo $rol . "<br>";
        echo "Fout bij registratie: " . $e->getMessage();
    }
} else {
    die("Ongeldige toegang.");
}
