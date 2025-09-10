<?php
session_start();
require 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $first_name = trim($_POST['first_name'] ?? '');
    $last_name = trim($_POST['last_name'] ?? '');
    $email = filter_var($_POST['email'] ?? '', FILTER_VALIDATE_EMAIL);
    $password = $_POST['password'] ?? '';
    $password_repeat = $_POST['password_repeat'] ?? '';

    // Validate inputs
    if (!$first_name || !$last_name) {
        die('Ime i prezime su obavezni');
    }

    if (!$email) {
        die('Nevažeći email');
    }

    if ($password !== $password_repeat) {
        die('Lozinke se ne poklapaju');
    }

    if (strlen($password) < 6) {
        die('Lozinka mora imati najmanje 6 znakova');
    }

    // Check if email exists
    $stmt = $pdo->prepare('SELECT user_id FROM users WHERE email = ?');
    $stmt->execute([$email]);
    if ($stmt->fetch()) {
        die('Email je već registriran');
    }

    // Hash password
    $password_hash = password_hash($password, PASSWORD_DEFAULT);

    // Insert user
    $stmt = $pdo->prepare('INSERT INTO users (first_name, last_name, email, password_hash) VALUES (?, ?, ?, ?)');
    $stmt->execute([$first_name, $last_name, $email, $password_hash]);

    // Start session and redirect
    $_SESSION['user_email'] = $email;
    $_SESSION['user_first_name'] = $first_name;
    header('Location: index.php');
    exit;
}
die('Nevažeći zahtjev');
