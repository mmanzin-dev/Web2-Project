<?php
include 'head.php';
include 'header.php';
?>

<div class="main">
    <div class="cart-container">
        <h1 class="cart-title">Košarica</h1>

        <div id="cart-items">
            <!-- Cart items will be dynamically inserted here via JavaScript -->
        </div>

        <div class="cart-total-row">
            <span>Ukupno:</span>
            <span class="cart-total" id="cart-total">0.00€</span>
        </div>

        <div class="cart-actions">
            <a href="#" class="btn-buy" id="pay-btn">Plati</a>
        </div>
    </div>
</div>

<?php
include 'footer.php';
?>