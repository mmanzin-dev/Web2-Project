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

// Load categories from DB
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
        // Description removed, insert empty string in DB
        $stmt = $conn->prepare("INSERT INTO products (category_id, name, description, price, created_at) VALUES (?, ?, '', ?, NOW())");
        $stmt->bind_param("isd", $category_id, $name, $price);

        if ($stmt->execute()) {
            $message = "Proizvod je uspješno dodan!";
            $_POST = []; // clear form data after success
        } else {
            $message = "Greška prilikom dodavanja proizvoda: " . $stmt->error;
        }

        $stmt->close();
    }
}
?>

<style>
input[type="text"],
input[type="number"],
select,
button {
    width: calc(100% - 6px);
    box-sizing: border-box;
}
</style>


<div class="container" style="max-width: 600px; border: 3px solid white; padding: 20px; background-color: black; color: white; margin: 40px auto;">
    <h2 style="text-align: center; font-weight: bold; border-bottom: 3px solid white; padding-bottom: 10px; margin-bottom: 25px;">Dodaj novi proizvod</h2>

    <?php if (!empty($message)): ?>
        <div style="font-weight: bold; border-left: 5px solid <?= strpos($message, 'uspješno') !== false ? '#2ecc71' : '#e74c3c' ?>; padding: 10px; margin-bottom: 20px; background-color: <?= strpos($message, 'uspješno') !== false ? '#113311' : '#331111' ?>; color: <?= strpos($message, 'uspješno') !== false ? '#aaffaa' : '#ffaaaa' ?>;">
            <?= htmlspecialchars($message) ?>
        </div>
    <?php endif; ?>

    <form method="POST" action="">
        <label for="name" style="display: block; font-weight: bold; margin-bottom: 5px; letter-spacing: 1px;">Naziv proizvoda</label>
        <input
            type="text"
            id="name"
            name="name"
            required
            value="<?= htmlspecialchars($_POST['name'] ?? '') ?>"
            style="width: 100%; padding: 10px; margin-bottom: 20px; background-color: black; color: white; border: 3px solid white; font-family: 'Roboto', sans-serif;"
        />

        <label for="price" style="display: block; font-weight: bold; margin-bottom: 5px; letter-spacing: 1px;">Cijena (€)</label>
        <input
            type="number"
            id="price"
            name="price"
            step="0.01"
            required
            value="<?= htmlspecialchars($_POST['price'] ?? '') ?>"
            style="width: 100%; padding: 10px; margin-bottom: 20px; background-color: black; color: white; border: 3px solid white; font-family: 'Roboto', sans-serif;"
        />

        <label for="category" style="display: block; font-weight: bold; margin-bottom: 5px; letter-spacing: 1px;">Kategorija</label>
        <select
            id="category"
            name="category"
            required
            style="width: 100%; padding: 10px; margin-bottom: 20px; background-color: black; color: white; border: 3px solid white; font-family: 'Roboto', sans-serif;"
        >
            <option value="">Odaberite kategoriju</option>
            <?php foreach ($categories as $id => $cat_name): ?>
                <option value="<?= $id ?>" <?= (isset($_POST['category']) && $_POST['category'] == $id) ? 'selected' : '' ?>>
                    <?= htmlspecialchars($cat_name) ?>
                </option>
            <?php endforeach; ?>
        </select>

        <button
            type="submit"
            style="background-color: black; color: white; border: 3px solid white; font-weight: bold; padding: 12px 25px; cursor: pointer; transition: all 0.3s ease; width: 100%; font-size: 1.2em;"
        >
            Dodaj proizvod
        </button>
    </form>
</div>