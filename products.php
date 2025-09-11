<?php
require 'head.php';
require 'connect.php';  // Your DB connection

$sql = "
    SELECT 
        p.product_id, p.name, p.image_url, p.price, c.name AS category_name
    FROM 
        products p
    JOIN 
        categories c ON p.category_id = c.category_id
    ORDER BY p.created_at DESC
";

$result = $conn->query($sql);

if (!$result) {
    die("Database error: " . $conn->error);
}
?>

<div class="container">
    <div style="margin-bottom: 20px; text-align: center;">
        <a href="index.php" class="btn-view" style="display: inline-block; padding: 10px 20px; border: 3px solid white; color: white; text-decoration: none; cursor: pointer; font-weight: bold; transition: all 0.3s ease;"
            onmouseover="this.style.backgroundColor='white';this.style.color='black';this.style.transform='scale(1.1)';"
            onmouseout="this.style.backgroundColor='black';this.style.color='white';this.style.transform='scale(1)';"
        >Nazad na početnu</a>
    </div>

    <main class="products-main">
        <div class="cards-container">
            <?php if ($result->num_rows === 0): ?>
                <p style="color: white; text-align: center; width: 100%; margin-top: 40px; font-size: 1.5em;">
                    Trenutno nema proizvoda u ponudi.
                </p>
            <?php else: ?>
                <?php while ($product = $result->fetch_assoc()): ?>
                    <div class="card">
                        <img src="<?= htmlspecialchars($product['image_url']) ?>" alt="<?= htmlspecialchars($product['name']) ?>" class="card-img" />
                        <div class="card-body">
                            <div class="card-type"><?= htmlspecialchars($product['category_name']) ?></div>
                            <div class="card-title"><?= htmlspecialchars($product['name']) ?></div>
                            <div class="card-price"><?= number_format($product['price'], 2) ?>€</div>
                            <a href="#" class="btn-view">DODAJ U KOŠARICU</a>
                        </div>
                    </div>
                <?php endwhile; ?>
            <?php endif; ?>
        </div>
    </main>
</div>
