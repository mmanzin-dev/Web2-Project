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
                    'Wide' => 'Wide',
                    'Standard' => 'Standard',
                    'Telephoto' => 'Telephoto',
                    'SuperTelephoto' => 'Super Telephoto'
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
                    'Minolta' => 'Minolta-Rokkor',
                    'Canon' => 'Canon',
                    'Nikon' => 'Nikon',
                    'Sigma' => 'Sigma',
                    'Revuenon' => 'Revuenon'
                ];
                foreach ($brands as $value => $label) {
                    echo '<li><label><input type="checkbox" name="brand" value="' . htmlspecialchars($value) . '" onchange="filterProducts()">' . htmlspecialchars($label) . '</label></li>';
                }
                ?>
            </ul>
        </div>
    </aside>

    <main class="products-main">
        <div class="cards-container">
            <?php
            $lenses = [
                [
                    "img" => "img/minolta-md-rokkor-28mm-f28.png",
                    "type" => "28mm f2.8",
                    "lens_type" => "Wide",
                    "title" => "Minolta MD Rokkor",
                    "price" => 90.00
                ],
                [
                    "img" => "img/minolta-md-rokkor-50mm-f14.png",
                    "type" => "50mm f1.4",
                    "lens_type" => "Standard",
                    "title" => "Minolta MD Rokkor",
                    "price" => 100.00
                ],
                [
                    "img" => "img/canon-ef-28-105mm-f35-45.png",
                    "type" => "28-105mm f3.5-4.5",
                    "lens_type" => "Wide / Standard / Telephoto",
                    "title" => "Canon EF Ultrasonic",
                    "price" => 120.00
                ],
                [
                    "img" => "img/canon-ef-50mm-f18.png",
                    "type" => "50mm f1.8",
                    "lens_type" => "Standard",
                    "title" => "Canon EF",
                    "price" => 125.00
                ],
                [
                    "img" => "img/nikon-nikkor-43-86mm-f35.png",
                    "type" => "43-86mm f3.5",
                    "lens_type" => "Standard / Telephoto",
                    "title" => "Nikon NIKKOR",
                    "price" => 150.00
                ],
                [
                    "img" => "img/revuenon-auto-mc-135mm-f28.png",
                    "type" => "135mm f2.8",
                    "lens_type" => "Telephoto",
                    "title" => "Revuenon Auto MC",
                    "price" => 150.00
                ]
            ];

            foreach ($lenses as $lens) {
                echo '<div class="card">';
                echo '    <img src="' . htmlspecialchars($lens['img']) . '" class="card-img" alt="' . htmlspecialchars($lens['title']) . '">';
                echo '    <div class="card-body">';
                echo '        <div class="card-type">' . htmlspecialchars($lens['type']) . '</div>';
                echo '        <div class="lens-type">' . htmlspecialchars($lens['lens_type']) . '</div>';
                echo '        <div class="card-title">' . htmlspecialchars($lens['title']) . '</div>';
                echo '        <div class="card-price">' . number_format($lens['price'], 2) . '€</div>';
                echo '        <a href="#" class="add-to-cart" onclick="addToCart(\'' . addslashes($lens['title'] . ' ' . $lens['type']) . "', " . $lens['price'] . ')">DODAJ U KOŠARICU</a>';
                echo '    </div>';
                echo '</div>';
            }
            ?>
        </div>
    </main>
</div>

<?php include 'footer.php'; ?>