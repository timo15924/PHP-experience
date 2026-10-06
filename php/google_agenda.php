<?php
session_start();
require_once 'config.php';

if (!isset($_SESSION["user_id"])) {
    exit;
}

$id = $_GET["id"];

$stmt = $pdo->prepare("
    SELECT *
    FROM reservations
    WHERE id = ?
");
$stmt->execute([$id]);

$reservering = $stmt->fetch();

if (!$reservering) {
    die("Reservering niet gevonden");
}

$start = date(
    "Ymd\THis",
    strtotime($reservering["datum"] . " " . $reservering["tijd"])
);

$einde = date(
    "Ymd\THis",
    strtotime($reservering["datum"] . " " . $reservering["tijd"] . " +1 hour")
);

$titel = urlencode("BeemBrug - " . ucfirst($reservering["activiteit"]));

$url =
"https://calendar.google.com/calendar/render?action=TEMPLATE" .
"&text=" . $titel .
"&dates=" . $start . "/" . $einde .
"&details=" . urlencode("Reservering via BeemBrug Connect");

header("Location: $url");
exit;