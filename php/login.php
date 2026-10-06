<?php
// login.php (met ingebouwde bugs)

session_start();
require_once 'config.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $email = trim($_POST["email"]);
    $wachtwoord = $_POST["wachtwoord"];

    if (empty($email) || empty($wachtwoord)) {
        die("Vul zowel e-mailadres als wachtwoord in.");
    }

    // selecteer alle gebruikers met hetzelfde e-mailadres
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?"); 
    $stmt->execute([$email]);
    $gebruikers = $stmt->fetchAll();

    if (count($gebruikers) === 0) {
        die("Geen gebruikers gevonden.");
    }

    foreach ($gebruikers as $gebruiker) {
        if (password_verify($wachtwoord, $gebruiker["wachtwoord"])) {
            $_SESSION["user_id"] = $gebruiker["id"];
            $_SESSION["naam"] = $gebruiker["naam"];
            $_SESSION["rol"] = $gebruiker["rol"];

            if ($gebruiker["rol"] === "admin") {
                header("Location: ../admin.php");
            } else {
                header("Location: ../reserveren.html");
            }
            exit;
        }
    }

    die("Onjuist e-mailadres of wachtwoord.");
} else {
    die("Ongeldige toegang.");
}

?>