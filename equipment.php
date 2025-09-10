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
                    'Bljeskalica' => 'Bljeskalice',
                    'Stativ' => 'Stativi',
                    'Okidač' => 'Okidači',
                    'Skener' => 'Skeneri'
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
            $equipment = [
                ["img" => "img/vivitar283.png", "type" => "Bljeskalica", "title" => "Vivitar 283", "price" => 50.00],
                ["img" => "img/vivitar285.png", "type" => "Bljeskalica", "title" => "Vivitar 285", "price" => 70.00],
                ["img" => "img/cullmann-alpha-stativ.png", "type" => "Stativ", "title" => "Cullmann Alpha 1800", "price" => 40.00],
                ["img" => "img/shutter-release-cable.png", "type" => "Okidač", "title" => "Okidač za fotoaparat 1m", "price" => 10.00],
                ["img" => "img/lomography-scanner.png", "type" => "Skener", "title" => "Lomography skener za 35mm film", "price" => 40.00]
            ];
            foreach ($equipment as $item) {
                echo '<div class="card">';
                echo '    <img src="' . htmlspecialchars($item["img"]) . '" class="card-img" alt="' . htmlspecialchars($item["title"]) . '">';
                echo '    <div class="card-body">';
                echo '        <div class="card-type">' . htmlspecialchars($item["type"]) . '</div>';
                echo '        <div class="card-title">' . htmlspecialchars($item["title"]) . '</div>';
                echo '        <div class="card-price">' . number_format($item["price"], 2) . '€</div>';
                echo '        <a href="#" class="add-to-cart" onclick="addToCart(\'' . addslashes($item["title"]) . '\',' . $item["price"] . ')">DODAJ U KOŠARICU</a>';
                echo '    </div>';
                echo '</div>';
            }
            ?>
        </div>
    </main>
</div>

<?php include 'footer.php'; ?>