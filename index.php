<?php
session_start();

if (isset($_SESSION['flash_message'])) {
    echo '<p>' . htmlspecialchars($_SESSION['flash_message']) . '</p>';
    unset($_SESSION['flash_message']); // clear after showing once
}

include 'head.php';
include 'header.php';
?>

<div class="main">
    <div class="cards-container">
        <?php
        $cards = [
            ['img' => 'img/cameras.png', 'title' => 'Fotoaparati', 'link' => 'cameras.php'],
            ['img' => 'img/lenses.png', 'title' => 'Objektivi', 'link' => 'lens.php'],
            ['img' => 'img/placeholder.png', 'title' => 'Oprema', 'link' => 'equipment.php'],
            ['img' => 'img/film.png', 'title' => 'Film', 'link' => 'film.php'],
        ];

        foreach ($cards as $card) {
            echo '<div class="card">';
            echo '    <img src="' . htmlspecialchars($card['img']) . '" class="card-img" alt="' . htmlspecialchars($card['title']) . '">';
            echo '    <div class="card-body">';
            echo '        <h2 class="card-title">' . htmlspecialchars($card['title']) . '</h2>';
            echo '        <a href="' . htmlspecialchars($card['link']) . '" class="btn-buy">KUPI</a>';
            echo '    </div>';
            echo '</div>';
        }
        ?>
    </div>

    <div class="graph">
        <div class="best-selling">
            <canvas id="bestsellerChart" width="100" height="300"></canvas>
        </div>
    </div>
</div>

<?php
include 'footer.php';
?>