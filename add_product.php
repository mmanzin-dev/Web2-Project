<?php
session_start();
require 'connect.php';
require 'head.php';
require 'header.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$message = "";

// Load categories
$categories = [];
$res = $conn->query("SELECT category_id, name FROM categories");
while ($row = $res->fetch_assoc()) {
    $categories[$row['category_id']] = $row['name'];
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = trim($_POST['name'] ?? '');
    $price = floatval($_POST['price'] ?? 0);
    $category_id = intval($_POST['category'] ?? 0);

    if ($name === '' || $price <= 0 || !isset($categories[$category_id])) {
        $message = "Molimo unesite ispravne podatke.";
    } else {
        $stmt = $conn->prepare("INSERT INTO products (category_id, name, description, price, created_at) VALUES (?, ?, '', ?, NOW())");
        $stmt->bind_param("isd", $category_id, $name, $price);

        if ($stmt->execute()) {
            $message = "Proizvod je uspješno dodan!";
            $_POST = [];
        } else {
            $message = "Greška prilikom dodavanja proizvoda: " . $stmt->error;
        }
        $stmt->close();
    }
}
?>

<style>
    /* simple styles for container and form */
    .container {
        max-width: 600px;
        margin: 40px auto;
        border: 3px solid white;
        padding: 20px;
        background: black;
        color: white;
        font-family: 'Roboto', sans-serif;
    }
    h2 {
        text-align: center;
        font-weight: bold;
        margin-bottom: 25px;
        border-bottom: 3px solid white;
        padding-bottom: 10px;
    }
    label {
        font-weight: bold;
        margin-bottom: 5px;
        display: block;
        letter-spacing: 1px;
    }
    input, select, button {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 3px solid white;
        background: black;
        color: white;
        font-size: 1em;
        font-family: inherit;
        box-sizing: border-box;
    }
    input[type="text"], select {
        appearance: none; /* remove default styling */
        -moz-appearance: none;
        -webkit-appearance: none;
    }
    /* For price input as text to remove arrows */
    input[type="text"].price-field {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
    }
    button {
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s ease, color 0.3s ease;
    }
    button:hover {
        background: white;
        color: black;
    }
    .message {
        font-weight: bold;
        border-left: 5px solid;
        padding: 10px;
        margin-bottom: 20px;
    }
    .message.success {
        border-color: #2ecc71;
        background-color: #113311;
        color: #aaffaa;
    }
    .message.error {
        border-color: #e74c3c;
        background-color: #331111;
        color: #ffaaaa;
    }
</style>

<div class="container">
    <h2>Dodaj novi proizvod</h2>

    <?php if (!empty($message)): ?>
        <div class="message <?= strpos($message, 'uspješno') !== false ? 'success' : 'error' ?>">
            <?= htmlspecialchars($message) ?>
        </div>
    <?php endif; ?>

    <form method="POST" action="">
        <label for="name">Naziv proizvoda</label>
        <input type="text" id="name" name="name" required value="<?= htmlspecialchars($_POST['name'] ?? '') ?>" />

        <label for="price">Cijena (€)</label>
        <input
            type="text"
            id="price"
            name="price"
            class="price-field"
            required
            value="<?= htmlspecialchars($_POST['price'] ?? '') ?>"
            pattern="^\d+(\.\d{1,2})?$"
            title="Unesite ispravnu cijenu, npr. 9.99"
        />

        <label for="category">Kategorija</label>
        <select id="category" name="category" required>
            <option value="">Odaberite kategoriju</option>
            <?php foreach ($categories as $id => $cat_name): ?>
                <option value="<?= $id ?>" <?= (isset($_POST['category']) && $_POST['category'] == $id) ? 'selected' : '' ?>>
                    <?= htmlspecialchars($cat_name) ?>
                </option>
            <?php endforeach; ?>
        </select>

        <button type="submit">Dodaj proizvod</button>
    </form>
</div>