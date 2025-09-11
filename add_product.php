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

// Handle adding new product
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_product'])) {
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

// Handle editing a product
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['edit_product'])) {
    $id = intval($_POST['product_id']);
    $name = trim($_POST['edit_name'] ?? '');
    $price = floatval($_POST['edit_price'] ?? 0);
    $category_id = intval($_POST['edit_category'] ?? 0);
    $description = trim($_POST['edit_description'] ?? '');

    if ($name !== '' && $price > 0 && isset($categories[$category_id])) {
        $stmt = $conn->prepare("UPDATE products SET name = ?, description = ?, price = ?, category_id = ? WHERE product_id = ?");
        $stmt->bind_param("ssdii", $name, $description, $price, $category_id, $id);
        $stmt->execute();
        $stmt->close();
        $message = "Proizvod je uspješno uređen!";
    } else {
        $message = "Molimo unesite ispravne podatke za uređivanje.";
    }
}

// Fetch products for edit table
$products = $conn->query("SELECT * FROM products");
?>

<style>
    body {
        background: black;
        color: white;
        font-family: 'Roboto', sans-serif;
        margin: 0;
        padding: 20px;
    }
    .container {
        max-width: 960px;
        margin: 40px auto;
        border: 3px solid white;
        padding: 20px;
        background-color: black;
    }
    h2 {
        text-align: center;
        font-weight: bold;
        border-bottom: 3px solid white;
        padding-bottom: 10px;
        margin-bottom: 25px;
    }
    .message {
        font-weight: bold;
        border-left: 5px solid;
        padding: 10px;
        margin-bottom: 20px;
        max-width: 960px;
        margin-left: auto;
        margin-right: auto;
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
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px;
    }
    th, td {
        padding: 10px;
        border: 3px solid white;
        vertical-align: middle;
    }
    th {
        background-color: #222;
        font-weight: bold;
        text-align: left;
    }
    input, select, textarea, button {
        width: 100%;
        box-sizing: border-box;
        padding: 8px;
        background: black;
        color: white;
        border: 3px solid white;
        font-family: 'Roboto', sans-serif;
        font-size: 1em;
        resize: vertical;
    }
    textarea {
        min-height: 50px;
    }
    button {
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s ease, color 0.3s ease;
    }
    button:hover {
        background-color: white;
        color: black;
    }
</style>

<div class="container">
    <h2>Uredi proizvode</h2>

    <?php if (!empty($message)): ?>
        <div class="message <?= strpos($message, 'uspješno') !== false ? 'success' : 'error' ?>">
            <?= htmlspecialchars($message) ?>
        </div>
    <?php endif; ?>

    <!-- Add New Product -->
    <form method="POST" action="">
        <table>
            <thead>
                <tr>
                    <th>Naziv</th>
                    <th>Opis</th>
                    <th>Cijena (€)</th>
                    <th>Kategorija</th>
                    <th>Dodaj</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input type="text" name="name" required value="<?= htmlspecialchars($_POST['name'] ?? '') ?>" /></td>
                    <td><textarea name="description" rows="1" placeholder="Opis"></textarea></td>
                    <td><input type="text" name="price" required value="<?= htmlspecialchars($_POST['price'] ?? '') ?>" /></td>
                    <td>
                        <select name="category" required>
                            <option value="">Odaberite kategoriju</option>
                            <?php foreach ($categories as $id => $cat_name): ?>
                                <option value="<?= $id ?>" <?= (isset($_POST['category']) && $_POST['category'] == $id) ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($cat_name) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </td>
                    <td><button type="submit" name="add_product">Dodaj proizvod</button></td>
                </tr>
            </tbody>
        </table>
    </form>