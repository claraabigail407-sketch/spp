-- Database: spp_adinda
CREATE DATABASE IF NOT EXISTS spp_adinda;
USE spp_adinda;

-- Tabel Admin
CREATE TABLE IF NOT EXISTS admin (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Kelas
CREATE TABLE IF NOT EXISTS kelas (
    id_kelas INT AUTO_INCREMENT PRIMARY KEY,
    nama_kelas VARCHAR(10) NOT NULL,
    tingkat ENUM('TK', 'MIS') NOT NULL,
    no_wa_wali VARCHAR(20)
);

-- Tabel Jenis Keringanan
CREATE TABLE IF NOT EXISTS jenis_keringanan (
    id_keringanan INT AUTO_INCREMENT PRIMARY KEY,
    nama_keringanan VARCHAR(100) NOT NULL,
    persentase_diskon INT NOT NULL DEFAULT 0,
    nominal_diskon INT NOT NULL DEFAULT 0,
    tipe_diskon ENUM('persentase', 'nominal') NOT NULL,
    keterangan TEXT,
    status ENUM('Aktif', 'Nonaktif') DEFAULT 'Aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Siswa
CREATE TABLE IF NOT EXISTS siswa (
    id_siswa INT AUTO_INCREMENT PRIMARY KEY,
    nis VARCHAR(20) NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    nama_wali VARCHAR(100) NULL,
    id_kelas INT,
    tingkat ENUM('TK', 'MIS') NOT NULL,
    no_wa_wali VARCHAR(20),
    id_keringanan INT NULL,
    status ENUM('Aktif', 'Nonaktif') DEFAULT 'Aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_kelas) REFERENCES kelas(id_kelas),
    FOREIGN KEY (id_keringanan) REFERENCES jenis_keringanan(id_keringanan) ON DELETE SET NULL
);

-- Tabel Pembayaran
CREATE TABLE IF NOT EXISTS pembayaran (
    id_pembayaran INT AUTO_INCREMENT PRIMARY KEY,
    id_siswa INT,
    bulan VARCHAR(20) NOT NULL,
    tahun INT NOT NULL,
    jumlah_normal INT NOT NULL,
    jumlah_diskon INT DEFAULT 0,
    jumlah_bayar INT NOT NULL,
    tanggal_bayar DATE NOT NULL,
    metode_bayar ENUM('Tunai', 'Transfer') DEFAULT 'Tunai',
    keterangan TEXT,
    status ENUM('Lunas', 'Belum Lunas') DEFAULT 'Lunas',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_siswa) REFERENCES siswa(id_siswa)
);

-- Tabel Tarif SPP
CREATE TABLE IF NOT EXISTS tarif_spp (
    id_tarif INT AUTO_INCREMENT PRIMARY KEY,
    tingkat ENUM('TK', 'MIS') NOT NULL,
    nominal INT NOT NULL,
    tahun_ajaran VARCHAR(20) NOT NULL
);

-- Insert Data Jenis Keringanan
INSERT INTO jenis_keringanan (nama_keringanan, persentase_diskon, nominal_diskon, tipe_diskon, keterangan, status) VALUES
('Adik/Kakak Gratis', 100, 0, 'persentase', 'Untuk adik/kakak dari siswa yang sudah bersekolah - GRATIS PENUH', 'Aktif'),
('Adik/Kakak Diskon 50%', 50, 0, 'persentase', 'Untuk adik/kakak dari siswa yang sudah bersekolah - Bayar Setengah', 'Aktif'),
('Anak Guru', 100, 0, 'persentase', 'Anak dari guru/tenaga pendidik - GRATIS', 'Aktif'),
('Anak Yatim', 75, 0, 'persentase', 'Anak yang tidak memiliki ayah - Diskon 75%', 'Aktif'),
('Anak Piatu', 75, 0, 'persentase', 'Anak yang tidak memiliki ibu - Diskon 75%', 'Aktif'),
('Anak Yatim Piatu', 100, 0, 'persentase', 'Anak yang tidak memiliki kedua orang tua - GRATIS', 'Aktif'),
('Keluarga Tidak Mampu', 50, 0, 'persentase', 'Untuk keluarga yang kurang mampu secara ekonomi', 'Aktif'),
('Diskon Khusus', 0, 10000, 'nominal', 'Diskon khusus nominal tertentu', 'Aktif');

-- Insert Data Kelas MIS
INSERT INTO kelas (nama_kelas, tingkat, no_wa_wali) VALUES
('1A', 'MIS', '081234567801'),
('1B', 'MIS', '081234567802'),
('2A', 'MIS', '081234567803'),
('2B', 'MIS', '081234567804'),
('3', 'MIS', '081234567805'),
('4A', 'MIS', '081234567806'),
('4B', 'MIS', '081234567807'),
('5', 'MIS', '081234567808'),
('6A', 'MIS', '081234567809'),
('6B', 'MIS', '081234567810');

-- Insert Data Kelas TK
INSERT INTO kelas (nama_kelas, tingkat, no_wa_wali) VALUES
('A', 'TK', '081234567811'),
('B', 'TK', '081234567812'),
('C', 'TK', '081234567813'),
('D', 'TK', '081234567814');

-- Insert Admin Default
INSERT INTO admin (username, password, nama_lengkap) VALUES
('admin', MD5('admin123'), 'Administrator'),
('kepsek', MD5('kepsek123'), 'Kepala Sekolah');

-- Insert Tarif SPP
INSERT INTO tarif_spp (tingkat, nominal, tahun_ajaran) VALUES
('MIS', 25000, '2025/2026'),
('TK', 40000, '2025/2026');

-- Insert Data Siswa Contoh MIS (beberapa dengan keringanan)
INSERT INTO siswa (nis, nama_lengkap, nama_wali, id_kelas, tingkat, no_wa_wali, status, id_keringanan) VALUES
('2501001', 'ZAKIA SYIFA ACMI AKRAT', 'Budi Akrat', 1, 'MIS', '081234567001', 'Aktif', NULL),
('2501002', 'AKIL FIKRI', 'Ahmad Fikri', 1, 'MIS', '081234567002', 'Aktif', 2),
('2501003', 'ADAM AL FATIH', 'Fatih Guru', 1, 'MIS', '081234567003', 'Aktif', 3),
('2501004', 'ATIKA SIDRAT DZAKIEA', 'Slamet Sidrat', 1, 'MIS', '081234567004', 'Aktif', NULL),
('2501005', 'ATIKA SAFITA', 'Rudi Safita', 1, 'MIS', '081234567005', 'Aktif', 4),
('2501006', 'AHMAD FAUZI', 'Fauzi Senior', 2, 'MIS', '081234567006', 'Aktif', NULL),
('2501007', 'SITI NURHALIZA', 'Haliza Wati', 2, 'MIS', '081234567007', 'Aktif', 1),
('2501008', 'MUHAMMAD RIZKI', 'Rizki Bapak', 3, 'MIS', '081234567008', 'Aktif', NULL),
('2501009', 'FATIMAH ZAHRA', 'Zahra Ibu', 3, 'MIS', '081234567009', 'Aktif', NULL),
('2501010', 'ABDUL AZIZ', 'Aziz Wali', 4, 'MIS', '081234567010', 'Aktif', 6);

-- Insert Data Siswa Contoh TK (beberapa dengan keringanan)
INSERT INTO siswa (nis, nama_lengkap, nama_wali, id_kelas, tingkat, no_wa_wali, status, id_keringanan) VALUES
('2601001', 'ANDI PRATAMA', 'Pratama Bapak', 11, 'TK', '081234567021', 'Aktif', NULL),
('2601002', 'BUDI SANTOSO', 'Santoso Wali', 11, 'TK', '081234567022', 'Aktif', 2),
('2601003', 'CITRA DEWI', 'Dewi Ibu', 11, 'TK', '081234567023', 'Aktif', NULL),
('2601004', 'DINA AMELIA', 'Amelia Wali', 12, 'TK', '081234567024', 'Aktif', 5),
('2601005', 'EKA PUTRA', 'Putra Bapak', 12, 'TK', '081234567025', 'Aktif', NULL),
('2601006', 'FITRI HANDAYANI', 'Handayani Ibu', 13, 'TK', '081234567026', 'Aktif', NULL),
('2601007', 'GILANG RAMADHAN', 'Ramadhan Guru', 13, 'TK', '081234567027', 'Aktif', 3),
('2601008', 'HANI SAFITRI', 'Safitri Wali', 14, 'TK', '081234567028', 'Aktif', NULL);

-- Insert Data Pembayaran Contoh
INSERT INTO pembayaran (id_siswa, bulan, tahun, jumlah_normal, jumlah_diskon, jumlah_bayar, tanggal_bayar, metode_bayar, status) VALUES
(1, 'Januari', 2026, 25000, 0, 25000, '2026-01-05', 'Transfer', 'Lunas'),
(1, 'Februari', 2026, 25000, 0, 25000, '2026-02-05', 'Transfer', 'Lunas');

-- Siswa dengan keringanan 50%
INSERT INTO pembayaran (id_siswa, bulan, tahun, jumlah_normal, jumlah_diskon, jumlah_bayar, tanggal_bayar, metode_bayar, status, keterangan) VALUES
(2, 'Januari', 2026, 25000, 12500, 12500, '2026-01-10', 'Tunai', 'Lunas', 'Diskon 50% - Adik/Kakak');

-- Siswa TK dengan pembayaran penuh
INSERT INTO pembayaran (id_siswa, bulan, tahun, jumlah_normal, jumlah_diskon, jumlah_bayar, tanggal_bayar, metode_bayar, status) VALUES
(11, 'Januari', 2026, 40000, 0, 40000, '2026-01-08', 'Transfer', 'Lunas'),
(11, 'Februari', 2026, 40000, 0, 40000, '2026-02-08', 'Transfer', 'Lunas');

-- Siswa TK dengan keringanan 50%
INSERT INTO pembayaran (id_siswa, bulan, tahun, jumlah_normal, jumlah_diskon, jumlah_bayar, tanggal_bayar, metode_bayar, status, keterangan) VALUES
(12, 'Januari', 2026, 40000, 20000, 20000, '2026-01-12', 'Tunai', 'Lunas', 'Diskon 50% - Adik/Kakak');
