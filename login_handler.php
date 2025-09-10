<?php
session_start();
require 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = filter_var($_POST['email'] ?? '', FILTER_VALIDATE_EMAIL);
    $password = $_POST['password'] ?? '';

    if (!$email || !$password) {
        die('Email i lozinka su obavezni.');
    }

    // Fetch user from DB
    $stmt = $pdo->prepare('SELECT user_id, first_name, password_hash FROM users WHERE email = ?');
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user || !password_verify($password, $user['password_hash'])) {
        die('Neispravan email ili lozinka.');
    }

    // Login success: store user info in session
    $_SESSION['user_id'] = $user['user_id'];
    $_SESSION['user_email'] = $email;
    $_SESSION['user_first_name'] = $user['first_name'];

    $_SESSION['flash_message'] = 'Dobrodošao/la, ' . $user['first_name'] . '!';
    
    // Redirect to homepage or dashboard
    header('Location: index.php');
    exit;
}

die('Nevažeći zahtjev.');