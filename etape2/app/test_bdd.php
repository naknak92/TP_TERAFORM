<?php
$host = 'data';
$db   = 'testdb';
$user = 'testuser';
$pass = 'testpassword';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);

    // Création d'une table
    $pdo->exec("CREATE TABLE IF NOT EXISTS visitors (id INT AUTO_INCREMENT PRIMARY KEY, visit_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

    // Insertion d'un enregistrement
    $stmt = $pdo->prepare("INSERT INTO visitors () VALUES ()");
    $stmt->execute();

    // Lecture des enregistrements
    $stmt = $pdo->query("SELECT * FROM visitors ORDER BY visit_time DESC");
    $visits = $stmt->fetchAll();

    echo "<h1>Visites récentes :</h1>";
    foreach ($visits as $visit) {
        echo "Visite ID : {$visit['id']} - Heure de visite : {$visit['visit_time']}<br>";
    }
} catch (PDOException $e) {
    echo "Erreur de connexion : " . $e->getMessage();
}
?>

