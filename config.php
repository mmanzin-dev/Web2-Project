<?php

$host = 'localhost';
$dbname = 'retrokamera';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$dbname;charset=$charset";

$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,    // Enable exceptions on errors
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,          // Fetch associative arrays by default
    PDO::ATTR_EMULATE_PREPARES   => false,                     // Use native prepared statements if possible
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
    // If connection fails, stop script and display error message
    throw new \PDOException($e->getMessage(), (int)$e->getCode());
}