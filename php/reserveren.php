<?php
session_start();
require_once 'config.php';

if (!isset($_SESSION["user_id"])) {
    header("Location: ../login.html");
    exit;
}

$user_id = $_SESSION["user_id"];

/**
 * INPUTS
 */
$activiteit = $_POST["activiteit"] ?? null;
$datumInput = $_POST["datum"] ?? null;
$tijd = $_POST["tijd"] ?? null;

$herhaling = $_POST["herhaling"] ?? "geen";
$einddatumInput = $_POST["einddatum"] ?? null;

$instructeur = $_POST["instructeur_naam"] ?? null;

/**
 * VALIDATIE
 */
if (!$activiteit || !$datumInput || !$tijd) {
    header("Location: ../reserveren.php?error=invalid");
    exit;
}

$datum = new DateTime($datumInput);

/**
 * HERHALING INSTELLING
 */
switch ($herhaling) {
    case "week":
        $interval = "+1 week";
        break;

    case "2weken":
        $interval = "+2 weeks";
        break;

    case "maand":
        $interval = "+1 month";
        break;

    default:
        $interval = null;
}

/**
 * CHECK FUNCTIE (dubbel boeking)
 */
function isBezet($pdo, $datum, $tijd, $activiteit) {

    $stmt = $pdo->prepare("
        SELECT COUNT(*) 
        FROM reservations 
        WHERE datum = ? 
        AND tijd = ? 
        AND activiteit = ?
        AND status = 'geboekt'
    ");

    $stmt->execute([
        $datum->format("Y-m-d"),
        $tijd,
        $activiteit
    ]);

    return $stmt->fetchColumn() > 0;
}

/**
 * 1. EENMALIGE RESERVERING
 */
if (!$interval || empty($einddatumInput)) {

    if (!isBezet($pdo, $datum, $tijd, $activiteit)) {

        $stmt = $pdo->prepare("
            INSERT INTO reservations 
            (user_id, activiteit, datum, tijd, instructeur)
            VALUES (?, ?, ?, ?, ?)
        ");

        $stmt->execute([
            $user_id,
            $activiteit,
            $datum->format("Y-m-d"),
            $tijd,
            $instructeur
        ]);

        header("Location: ../mijn_reserveringen.php?success=1");
        exit;

    } else {

        header("Location: ../reserveren.html?error=bezet");
        exit;
    }
}

/**
 * 2. HERHALING RESERVERING
 */
$einddatum = new DateTime($einddatumInput);

while ($datum <= $einddatum) {

    if (!isBezet($pdo, $datum, $tijd, $activiteit)) {

        $stmt = $pdo->prepare("
            INSERT INTO reservations 
            (user_id, activiteit, datum, tijd, instructeur)
            VALUES (?, ?, ?, ?, ?)
        ");

        $stmt->execute([
            $user_id,
            $activiteit,
            $datum->format("Y-m-d"),
            $tijd,
            $instructeur
        ]);
    }

    $datum->modify($interval);
}

header("Location: ../mijn_reserveringen.php?success=1");
exit;