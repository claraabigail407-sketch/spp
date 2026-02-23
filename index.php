<?php
require_once 'config.php';

// Jika sudah login, redirect
if (isset($_SESSION['login'])) {
    if ($_SESSION['role'] == 'admin') {
        header("Location: admin/index.php");
    }
    exit();
}

// Proses Login
if (isset($_POST['login'])) {
    $username = escape($_POST['username']);
    $password = MD5($_POST['password']);
    
    // Cek admin
    $query = "SELECT * FROM admin WHERE username='$username' AND password='$password'";
    $result = mysqli_query($conn, $query);
    
    if (mysqli_num_rows($result) > 0) {
        $data = mysqli_fetch_assoc($result);
        $_SESSION['login'] = true;
        $_SESSION['id_admin'] = $data['id_admin'];
        $_SESSION['username'] = $data['username'];
        $_SESSION['nama'] = $data['nama_lengkap'];
        $_SESSION['role'] = 'admin';
        
        header("Location: admin/index.php");
        exit();
    }
    
    $error = "Username atau password salah!";
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - SPP YP. Adinda Air Genting</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
        }
        .login-left {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 40px;
            text-align: center;
        }
        .login-left i {
            font-size: 80px;
            margin-bottom: 20px;
        }
        .login-right {
            padding: 60px 40px;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 12px;
            font-weight: 600;
            transition: transform 0.3s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        .info-box {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
            font-size: 0.9rem;
        }
        .example-box {
            background: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 10px;
            margin-top: 10px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container row g-0">
            <div class="col-md-5 login-left">
                <i class="fas fa-graduation-cap"></i>
                <h2 class="fw-bold mb-3">SPP YP. Adinda</h2>
                <h4>Air Genting</h4>
                <p class="mt-4">Sistem Pembayaran SPP Online untuk memudahkan monitoring pembayaran siswa</p>
            </div>
            <div class="col-md-7 login-right">
                <h3 class="mb-4 fw-bold">Selamat Datang</h3>
                <p class="text-muted mb-4">Silakan login untuk melanjutkan</p>
                
                <?php if (isset($error)): ?>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> <?= $error ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <?php endif; ?>
                
                <form method="POST" action="">
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-user"></i> Username</label>
                        <input type="text" class="form-control form-control-lg" name="username" required placeholder="Masukkan username">
                    </div>
                    <div class="mb-4">
                        <label class="form-label"><i class="fas fa-lock"></i> Password</label>
                        <input type="password" class="form-control form-control-lg" name="password" required placeholder="Masukkan password">
                    </div>
                    <button type="submit" name="login" class="btn btn-primary btn-login w-100 btn-lg">
                        <i class="fas fa-sign-in-alt"></i> LOGIN
                    </button>
                </form>
                
                <div class="info-box">
                    <h6 class="fw-bold mb-2"><i class="fas fa-info-circle"></i> Informasi Login:</h6>
                    <small>
                        <strong>👨‍💼 Admin:</strong><br>
                        Username: <code>admin</code> / Password: <code>admin123</code>
                    </small>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
