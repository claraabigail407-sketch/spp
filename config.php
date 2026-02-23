<?php
// Konfigurasi Database
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'spp_adinda');

// Koneksi Database
$conn = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);

// Cek Koneksi
if (!$conn) {
    die("Koneksi database gagal: " . mysqli_connect_error());
}

// Set charset
mysqli_set_charset($conn, "utf8");

// Fungsi untuk mencegah SQL Injection
function escape($data) {
    global $conn;
    return mysqli_real_escape_string($conn, $data);
}

// Fungsi untuk prepared statement query
function prepared_query($sql, $params = []) {
    global $conn;
    $stmt = mysqli_prepare($conn, $sql);
    if ($stmt === false) {
        return false;
    }

    if (!empty($params)) {
        $types = '';
        foreach ($params as $param) {
            if (is_int($param)) {
                $types .= 'i';
            } elseif (is_float($param)) {
                $types .= 'd';
            } else {
                $types .= 's';
            }
        }
        mysqli_stmt_bind_param($stmt, $types, ...$params);
    }

    mysqli_stmt_execute($stmt);
    return $stmt;
}

// Fungsi format rupiah
function formatRupiah($angka) {
    return "Rp " . number_format($angka, 0, ',', '.');
}

// Fungsi format tanggal Indonesia
function formatTanggal($tanggal) {
    $bulan = array(
        1 => 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    );
    $pecahkan = explode('-', $tanggal);
    return $pecahkan[2] . ' ' . $bulan[(int)$pecahkan[1]] . ' ' . $pecahkan[0];
}

// Fungsi get nama bulan (kept for backward compatibility)
function getNamaBulan($bulan) {
    $bulanArray = array(
        'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    );
    return $bulanArray;
}

// Fungsi get semester
function getSemester() {
    return array(
        'Semester Ganjil (Juli-Desember)',
        'Semester Genap (Januari-Juni)'
    );
}

// Fungsi untuk mendapatkan nilai semester dari nama
function getSemesterValue($semesterName) {
    if (strpos($semesterName, 'Ganjil') !== false) {
        return 'Ganjil';
    } else if (strpos($semesterName, 'Genap') !== false) {
        return 'Genap';
    }
    return $semesterName;
}

// Fungsi untuk mendapatkan nama lengkap semester
function getSemesterFullName($semesterValue) {
    if ($semesterValue == 'Ganjil') {
        return 'Semester Ganjil (Juli-Desember)';
    } else if ($semesterValue == 'Genap') {
        return 'Semester Genap (Januari-Juni)';
    }
    return $semesterValue;
}

// Fungsi untuk mendapatkan semester saat ini berdasarkan bulan
function getCurrentSemester() {
    $bulan = date('n'); // 1-12
    if ($bulan >= 7 && $bulan <= 12) {
        return 'Ganjil';
    } else {
        return 'Genap';
    }
}

// Fungsi untuk mendapatkan bulan-bulan dalam semester
function getBulanDalamSemester($semester) {
    if ($semester == 'Ganjil') {
        return ['Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    } else {
        return ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni'];
    }
}

// Session
session_start();
?>
