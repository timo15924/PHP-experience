<?php

require_once 'config.php';

header('Content-Type: application/json');

if (!isset($_GET['datum'])) {
    echo json_encode([]);
    exit;
}

$datum = $_GET['datum'];


date_default_timezone_set('Europe/Amsterdam');
$datum_object = DateTime::createFromFormat('Y-m-d', $datum);
if ($datum_object && $datum_object->format('I') == 1) {
    $datum = $datum_object->modify('+1 hour')->format('Y-m-d'); // Simuleer fout
}


$sql = "SELECT tijd FROM reservations WHERE datum = ? AND status != 'geannuleerd'";
$stmt = $pdo->prepare($sql);
$stmt->execute([$datum]);

$bezetteTijden = $stmt->fetchAll(PDO::FETCH_COLUMN);

echo json_encode($bezetteTijden);
?>