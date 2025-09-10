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
                    'SLR' => 'SLRs',
                    'Rangefinder' => 'Rangefinders',
                    'Point & Shoot' => 'Point & Shoots',
                    'Medium Format' => 'Medium Formats',
                    'Instant Camera' => 'Instant Cameras',
                    'Digital Camera' => 'Digital Cameras'
                ];
                foreach ($categories as $value => $label) {
                    echo '<li><label><input type="checkbox" name="category" value="' . htmlspecialchars($value) . '" onchange="filterProducts()">' . htmlspecialchars($label) . '</label></li>';
                }
                ?>
            </ul>
        </div>

        <div class="filter-section">
            <h3 class="filter-title">BREND</h3>
            <ul class="filter-list">
                <?php
                $brands = [
                    'Leica',
                    'Fujifilm',
                    'Minolta',
                    'Canon',
                    'Pentax',
                    'Konica',
                    'Nikon',
                    'Yashica',
                    'Olympus'
                ];
                foreach ($brands as $brand) {
                    echo '<li><label><input type="checkbox" name="brand" value="' . htmlspecialchars($brand) . '" onchange="filterProducts()">' . htmlspecialchars($brand) . '</label></li>';
                }
                ?>
            </ul>
        </div>
    </aside>

    <main class="products-main">
        <div class="cards-container">
            <div class="cards-container">
                <?php
                $products = [
                    ["img" => "img/minolta-srt-101.png", "type" => "SLR", "title" => "Minolta SRT 101", "price" => 180.00],
                    ["img" => "img/minolta-xe1.png", "type" => "SLR", "title" => "Minolta XE1", "price" => 180.00],
                    ["img" => "img/canon-ae-1.png", "type" => "SLR", "title" => "Canon AE1", "price" => 200.00],
                    ["img" => "img/canon-av-1.png", "type" => "SLR", "title" => "Canon AV1", "price" => 150.00],
                    ["img" => "img/yashica-tl-electro-x.png", "type" => "SLR", "title" => "Yashica TL Electro X", "price" => 130.00],
                    ["img" => "img/yashica-electro35-gsn.png", "type" => "Rangefinder", "title" => "Yashica Electro 35 GSN", "price" => 125.00],
                    ["img" => "img/olympus-xa2.png", "type" => "Point & Shoot", "title" => "Olympus XA2", "price" => 80.00],
                    ["img" => "img/pentax-67.png", "type" => "Medium Format", "title" => "Pentax 67", "price" => 750.00],
                    ["img" => "img/polaroid-supercolor1000.png", "type" => "Instant Camera", "title" => "Polaroid Supercolor 1000", "price" => 75.00],
                    ["img" => "img/fujifilm-finepix-jv100.png", "type" => "Digital Camera", "title" => "Fujifilm FinePix JV100", "price" => 69.00]
                ];

                foreach ($products as $product) {
                    echo '<div class="card">';
                    echo '    <img src="' . htmlspecialchars($product['img']) . '" class="card-img" alt="' . htmlspecialchars($product['title']) . '">';
                    echo '    <div class="card-body">';
                    echo '        <div class="card-type">' . htmlspecialchars($product['type']) . '</div>';
                    echo '        <div class="card-title">' . htmlspecialchars($product['title']) . '</div>';
                    echo '        <div class="card-price">' . number_format($product['price'], 2) . '€</div>';
                    echo '        <a href="#" class="add-to-cart" onclick="addToCart(\'' . addslashes($product['title']) . '\', ' . $product['price'] . ')">DODAJ U KOŠARICU</a>';
                    echo '    </div>';
                    echo '</div>';
                }
                ?>
            </div>
        </div>
    </main>
</div>

<?php
include 'footer.php';
?>