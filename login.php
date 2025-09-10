<!DOCTYPE html>
<html lang="hr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Retrokamera - Prijava</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.22.0/dist/sweetalert2.all.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.22.0/dist/sweetalert2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="bootstrapStyle.css" />
</head>

<body>
    <div class="container d-flex align-items-center justify-content-center vh-100">
        <div class="border border-3 rounded p-3 mt-3 form-width">
            <form method="POST" action="login_handler.php">
                <img src="img/logo.png" class="mt-3 mb-3 d-block mx-auto" alt="RetroKamera Logo" style="max-width: 100px; max-height: 100px;" />
                <h3 class="text-center mb-3">Prijavite se u RetroKameru</h3>
                <div class="mb-3">
                    <label for="login-email" class="form-label">Email</label>
                    <input type="email" id="login-email" name="email" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label for="login-password" class="form-label">Lozinka</label>
                    <input type="password" id="login-password" name="password" class="form-control" required />
                </div>
                <div class="text-end">
                    <button type="submit" class="btn btn-primary">Prijavite se</button>
                </div>
                <div class="text-center mt-2">
                    <span>Nemate račun? <a href="register.php">Registrirajte se</a></span>
                </div>
            </form>
        </div>
    </div>
</body>
</html>