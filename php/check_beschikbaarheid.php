<?php
require_once 'config.php';

$datum = $_GET["datum"] ?? null;
$tijd = $_GET["tijd"] ?? null;

if (!$datum || !$tijd) {
    echo json_encode([]);
    exit;
}

$stmt = $pdo->prepare("
    SELECT tijd 
    FROM reservations 
    WHERE datum = ? AND status = 'geboekt'
");
$stmt->execute([$datum]);

$bezet = $stmt->fetchAll(PDO::FETCH_COLUMN);

$input = strtotime($tijd);

$suggesties = [];

for ($i = -2; $i <= 2; $i++) {

    if ($i === 0) continue;

    $nieuw = date("H:i", strtotime("$i hour", $input));

    if (!in_array($nieuw, $bezet)) {
        $suggesties[] = $nieuw;
    }
}

header('Content-Type: application/json');
echo json_encode($suggesties);