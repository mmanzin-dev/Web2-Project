<!DOCTYPE html>
<html lang="hr">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Retrokamera - Registracija</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.22.0/dist/sweetalert2.all.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.22.0/dist/sweetalert2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="bootstrapStyle.css" />
</head>

<body>
    <div class="container d-flex align-items-center justify-content-center vh-100">
        <div class="border border-3 rounded p-3 mt-3 form-width">
            <form method="POST" action="register_handler.php">
                <img src="img/logo.png" alt="RetroKamera Logo" class="mt-3 mb-3 d-block mx-auto" style="max-width: 100px; max-height: 100px;" />
                <h3 class="text-center mb-3">Registriraj se za RetroKameru</h3>

                <div class="mb-3">
                    <label for="first-name" class="form-label">Ime</label>
                    <input type="text" name="first_name" id="first-name" class="form-control" required />
                </div>

                <div class="mb-3">
                    <label for="last-name" class="form-label">Prezime</label>
                    <input type="text" name="last_name" id="last-name" class="form-control" required />
                </div>


                <div class="mb-3">
                    <label for="register-email" class="form-label">Email</label>
                    <input type="email" id="register-email" name="email" class="form-control" required />
                </div>

                <div class="mb-3">
                    <label for="register-password" class="form-label">Lozinka</label>
                    <input type="password" id="register-password" name="password" class="form-control" required />
                </div>

                <div class="mb-3">
                    <label for="register-password-repeat" class="form-label">Ponovite lozinku</label>
                    <input type="password" id="register-password-repeat" name="password_repeat" class="form-control" required />
                </div>

                <div class="text-end">
                    <button type="submit" class="btn btn-primary">Registrirajte se</button>
                </div>

                <div class="text-center mt-2">
                    <span>Već ste registrirani? <a href="login.php">Prijavite se</a></span>
                </div>
            </form>
        </div>
    </div>
</body>

</html>