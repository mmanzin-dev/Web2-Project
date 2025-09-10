<?php
include 'head.php';
include 'header.php';
?>

<div class="products-page">
    <aside class="sidebar">
        <div class="filter-section">
            <h3 class="filter-title">KATEGORIJE</h3>
            <ul class="filter-list">
                <?php
                $categories = [
                    '35mm' => '35mm',
                    '120mm' => '120mm',
                    'Instant Film' => 'Instant Film'
                ];
                foreach ($categories as $value => $label) {
                    echo '<li><label><input type="checkbox" name="category" value="' . htmlspecialchars($value) . '" onchange="filterProducts()">' . htmlspecialchars($label) . '</label></li>';
                }
                ?>
            </ul>
        </div>
    </aside>

    <main class="products-main">
        <div class="cards-container">
            <?php
            $films = [
                ['img' => 'img/kodak-gold-200-36-exp.png', 'type' => '35mm', 'title' => 'Kodak Gold 200', 'price' => 15.00],
                ['img' => 'img/agfa-apx-100-36-exp.png', 'type' => '35mm', 'title' => 'Agfa APX 100', 'price' => 12.00],
                ['img' => 'img/candido400.png', 'type' => '35mm', 'title' => 'Candido 400', 'price' => 17.00],
                ['img' => 'img/candido800.png', 'type' => '35mm', 'title' => 'Candido 800', 'price' => 20.00],
                ['img' => 'img/wolfen-nc500.png', 'type' => '35mm', 'title' => 'Wolfen NC 500', 'price' => 25.00],
                ['img' => 'img/polaroid-color600.png', 'type' => 'Instant Film', 'title' => 'Polaroid Color 600', 'price' => 30.00],
            ];
            foreach ($films as $film) {
                echo '<div class="card">';
                echo '    <img src="' . htmlspecialchars($film['img']) . '" class="card-img" alt="' . htmlspecialchars($film['title']) . '">';
                echo '    <div class="card-body">';
                echo '        <div class="card-type">' . htmlspecialchars($film['type']) . '</div>';
                echo '        <div class="card-title">' . htmlspecialchars($film['title']) . '</div>';
                echo '        <div class="card-price">' . number_format($film['price'], 2) . '€</div>';
                echo '        <a href="#" class="add-to-cart" onclick="addToCart(\'' . addslashes($film['title']) . '\', ' . $film['price'] . ')">DODAJ U KOŠARICU</a>';
                echo '    </div>';
                echo '</div>';
            }
            ?>
        </div>
    </main>
</div>

<?php include 'footer.php'; ?>