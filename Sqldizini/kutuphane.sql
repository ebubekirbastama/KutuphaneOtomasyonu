-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Anamakine: localhost
-- Üretim Zamanı: 05 Eki 2016, 06:14:07
-- Sunucu sürümü: 5.6.13
-- PHP Sürümü: 5.4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Veritabanı: `kutuphane`
--
CREATE DATABASE IF NOT EXISTS `kutuphane` DEFAULT CHARACTER SET utf8 COLLATE utf8_turkish_ci;
USE `kutuphane`;

DELIMITER $$
--
-- Yordamlar
--
DROP PROCEDURE IF EXISTS `kgirisi`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `kgirisi`(IN `ytkl_ism` VARCHAR(50), IN `ytkl_sf` VARCHAR(100))
    NO SQL
BEGIN
    DECLARE dgri INT;
    

    SELECT  COUNT(*) INTO dgri FROM yetkili WHERE ytkl_ismi=ytkl_ism and  ytkl_sfr=ytkl_sf;
    
if (dgri = 0) then

        set dgri = 0; 

    else 
        
          set dgri = 1;
        
    end if;

    SELECT dgri;    
END$$

DROP PROCEDURE IF EXISTS `ktgr_ekle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ktgr_ekle`(IN `ktgr_ismi_` VARCHAR(90))
    NO SQL
BEGIN
  
    DECLARE dgr INT;  

    SELECT  COUNT(*) INTO dgr FROM ktp_ktgr WHERE  ktgr_ismi=ktgr_ismi_;
    if (dgr = 0) then

        insert into ktp_ktgr
(ktgr_ismi,ktpktgr_kayit_tarih)
values
(ktgr_ismi_, SYSDATE());
    else 
        
          set dgr = 1;
        
    end if;

    SELECT dgr;    
END$$

DROP PROCEDURE IF EXISTS `ktgr_guncelle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ktgr_guncelle`(IN `id_` INT, IN `ktgr_ismi_` VARCHAR(90))
    MODIFIES SQL DATA
update ktp_ktgr  set
ktgr_ismi=ktgr_ismi_,
ktpktgr_kayit_tarih=SYSDATE()
 where id=id_$$

DROP PROCEDURE IF EXISTS `ktgr_sil`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ktgr_sil`(IN `id_` INT)
delete From ktp_ktgr where id=id_$$

DROP PROCEDURE IF EXISTS `ktp_ekle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ktp_ekle`(IN `ktp_brkt_nmr_` BIGINT, IN `ktp_ismi_` VARCHAR(100) CHARSET utf8, IN `ktp_adedi_` BIGINT, IN `ktp_ktgr_` VARCHAR(100) CHARSET utf8, IN `ktp_raf_nmr_` VARCHAR(100) CHARSET utf8, IN `ktp_yzr_ismi_` VARCHAR(100) CHARSET utf8)
    NO SQL
BEGIN
DECLARE dgr INT;

SELECT COUNT( * )INTO dgr FROM kitaplar WHERE ktp_brkt_nmr=ktp_brkt_nmr_;

if( dgr=0 ) THEN 
    INSERT INTO kitaplar(
ktp_brkt_nmr ,
ktp_ismi ,
ktp_adedi ,
ktp_ktgr ,
ktp_raf_nmr ,
ktp_yzr_ismi ,
ktp_kayit_tarih
)
VALUES (
ktp_brkt_nmr_ ,
ktp_ismi_ ,
ktp_adedi_ ,
ktp_ktgr_ ,
ktp_raf_nmr_ ,
ktp_yzr_ismi_ ,
SYSDATE()
);

ELSE
SET dgr =1;

END IF ;

SELECT dgr;

END$$

DROP PROCEDURE IF EXISTS `ktp_gncl`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ktp_gncl`(IN `ktp_brkt_nmr_` BIGINT, IN `ktp_ismi_` VARCHAR(100) CHARSET utf8, IN `ktp_adedi_` BIGINT, IN `ktp_ktgr_` VARCHAR(100) CHARSET utf8, IN `ktp_raf_nmr_` VARCHAR(100) CHARSET utf8, IN `ktp_yzr_ismi_` VARCHAR(100) CHARSET utf8)
update kitaplar set
ktp_ismi=ktp_ismi_ ,
ktp_adedi=ktp_adedi_ ,
ktp_ktgr=ktp_ktgr_ ,
ktp_raf_nmr=ktp_raf_nmr_ ,
ktp_yzr_ismi=ktp_yzr_ismi_ ,
ktp_kayit_tarih=SYSDATE()

 where ktp_brkt_nmr=ktp_brkt_nmr_$$

DROP PROCEDURE IF EXISTS `ktp_odunc_gr_verme`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ktp_odunc_gr_verme`(IN `ogr_tc_no_` TEXT, IN `ktp_brkt_nmr_` TEXT)
    NO SQL
INSERT INTO `ktp_odunc_gr_vr`(`ogr_tc_no`, `ktp_brkt_nmr`, `ktp_kayit_tarihi`)
VALUES (ogr_tc_no_,ktp_brkt_nmr_,SYSDATE())$$

DROP PROCEDURE IF EXISTS `ktp_odunc_verme`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ktp_odunc_verme`(IN `ogr_tc_no_` TEXT, IN `ktp_brkt_nmr_` TEXT)
    NO SQL
INSERT INTO `ktp_odunc`(`ogr_tc_no`, `ktp_brkt_nmr`, `ktp_kayit_tarihi`)
VALUES (ogr_tc_no_,ktp_brkt_nmr_,SYSDATE())$$

DROP PROCEDURE IF EXISTS `ktp_sil`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ktp_sil`(IN `ktp_brkt_nmr_` BIGINT)
delete from kitaplar where ktp_brkt_nmr=ktp_brkt_nmr_$$

DROP PROCEDURE IF EXISTS `ogr_ekle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ogr_ekle`(IN `ogr_tc_no_` TEXT, IN `ogr_adi_` VARCHAR(100), IN `ogr_syd_` VARCHAR(100), IN `ogr_snf_` VARCHAR(15), IN `ogr_tel_no_` VARCHAR(13))
    NO SQL
BEGIN
DECLARE dgr INT;

SELECT COUNT( * )INTO dgr FROM ogr WHERE ogr_tc_no=ogr_tc_no_;

if( dgr=0 ) THEN 

    INSERT INTO ogr(
 ogr_tc_no, 
  ogr_adi ,
  ogr_syd ,
  ogr_snf ,
  ogr_tel_no, 
  kyt_trh
)
VALUES (
 ogr_tc_no_ ,
  ogr_adi_ ,
  ogr_syd_ ,
  ogr_snf_ ,
  ogr_tel_no_, 
   SYSDATE()
);

ELSE
SET dgr =1;

END IF ;

SELECT dgr;

END$$

DROP PROCEDURE IF EXISTS `ogr_guncelle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ogr_guncelle`(IN `ogr_tc_no_` TEXT, IN `ogr_adi_` VARCHAR(100), IN `ogr_syd_` VARCHAR(100), IN `ogr_snf_` VARCHAR(15), IN `ogr_tel_no_` VARCHAR(13))
update ogr set 
  ogr_adi=ogr_adi_ ,
  ogr_syd=ogr_syd_ ,
  ogr_snf=ogr_snf_ ,
  ogr_tel_no=ogr_tel_no_, 
  kyt_trh=SYSDATE()
where ogr_tc_no=ogr_tc_no_$$

DROP PROCEDURE IF EXISTS `ogr_sil`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ogr_sil`(IN `ogr_tc_no_` TEXT)
    NO SQL
delete from ogr where ogr_tc_no=ogr_tc_no_$$

DROP PROCEDURE IF EXISTS `yetkili_ekle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `yetkili_ekle`(IN `ytkl_ismi_` VARCHAR(50), IN `ytkl_soyadi_` VARCHAR(50), IN `ytkl_unvani_` VARCHAR(100), IN `ytkl_sfr_` VARCHAR(100))
    NO SQL
BEGIN
DECLARE dgr INT;

SELECT COUNT( * )INTO dgr FROM yetkili WHERE ytkl_ismi=ytkl_ismi_ and ytkl_soyadi=ytkl_soyadi_;

if( dgr=0 ) THEN 

    INSERT INTO yetkili(
   ytkl_ism,
  ytkl_soyadi,
  ytkl_unvani,
  ytkl_sfr,
  ytkl_kyt_trh
)
VALUES (
  ytkl_ism_,
  ytkl_soyadi_,
  ytkl_unvani_,
  ytkl_sfr_,
   SYSDATE()
);

ELSE
SET dgr =1;

END IF ;

SELECT dgr;

END$$

DROP PROCEDURE IF EXISTS `yetkili_guncelle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `yetkili_guncelle`(IN `id_` INT(21), IN `ytkl_ismi_` VARCHAR(50), IN `ytkl_soyadi_` VARCHAR(50), IN `ytkl_unvani_` VARCHAR(100), IN `ytkl_sfr_` VARCHAR(100))
    NO SQL
UPDATE yetkili SET

ytkl_ismi=ytkl_ismi_,ytkl_soyadi=ytkl_soyadi_,ytkl_unvani=ytkl_unvani_,ytkl_sfr=ytkl_sfr_,
ytkl_kyt_trh=SYSDATE() WHERE id=id_$$

DROP PROCEDURE IF EXISTS `yetkili_sil`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `yetkili_sil`(
 IN id INT(21)
)
delete from yetkili where id=id_$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitaplar`
--

DROP TABLE IF EXISTS `kitaplar`;
CREATE TABLE IF NOT EXISTS `kitaplar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ktp_brkt_nmr` bigint(20) NOT NULL,
  `ktp_ismi` varchar(100) CHARACTER SET utf8 COLLATE utf8_turkish_ci NOT NULL,
  `ktp_adedi` bigint(250) NOT NULL,
  `ktp_ktgr` varchar(100) CHARACTER SET utf8 COLLATE utf8_turkish_ci NOT NULL,
  `ktp_raf_nmr` varchar(100) CHARACTER SET utf8 COLLATE utf8_turkish_ci NOT NULL,
  `ktp_yzr_ismi` varchar(100) CHARACTER SET utf8 COLLATE utf8_turkish_ci NOT NULL,
  `ktp_kayit_tarih` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Tablo döküm verisi `kitaplar`
--

INSERT INTO `kitaplar` VALUES
(1, 123456789, 'Simyacı', 5, 'Psikoloji', '2.Raft', 'ebubekir bastama', '2016-10-04 21:51:32'),
(3, 125458, 'Hacking Master', 15, 'Siber Güvenlik', '4.rafta', 'Ebubekir Bastama', '2016-10-04 21:53:04');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitaplar_log`
--

DROP TABLE IF EXISTS `kitaplar_log`;
CREATE TABLE IF NOT EXISTS `kitaplar_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ktp_brkt_nmr` bigint(20) NOT NULL,
  `ytkl_adi_soyad` varchar(50) NOT NULL,
  `ktp_kayit_tarih` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ktp_ktgr`
--

DROP TABLE IF EXISTS `ktp_ktgr`;
CREATE TABLE IF NOT EXISTS `ktp_ktgr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ktgr_ismi` varchar(90) CHARACTER SET utf8 COLLATE utf8_turkish_ci NOT NULL,
  `ktpktgr_kayit_tarih` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Tablo döküm verisi `ktp_ktgr`
--

INSERT INTO `ktp_ktgr` VALUES
(2, 'Siber Güvenlik', '2016-10-04 21:53:37'),
(4, 'Psikoloji', '2016-10-04 21:54:09');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ktp_odunc`
--

DROP TABLE IF EXISTS `ktp_odunc`;
CREATE TABLE IF NOT EXISTS `ktp_odunc` (
  `ogr_tc_no` text NOT NULL,
  `ktp_brkt_nmr` text NOT NULL,
  `ktp_kayit_tarihi` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Tablo döküm verisi `ktp_odunc`
--

INSERT INTO `ktp_odunc` VALUES
('12345', '123456789', '2016-09-29 17:26:31', 1),
('12345', '12345', '2016-09-29 17:26:31', 2);

--
-- Tetikleyiciler `ktp_odunc`
--
DROP TRIGGER IF EXISTS `trg_odunc`;
DELIMITER //
CREATE TRIGGER `trg_odunc` AFTER INSERT ON `ktp_odunc`
 FOR EACH ROW update kitaplar  set ktp_adedi=ktp_adedi-1  where ktp_brkt_nmr=new.ktp_brkt_nmr
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ktp_odunc_gr_vr`
--

DROP TABLE IF EXISTS `ktp_odunc_gr_vr`;
CREATE TABLE IF NOT EXISTS `ktp_odunc_gr_vr` (
  `ogr_tc_no` text NOT NULL,
  `ktp_brkt_nmr` text NOT NULL,
  `ktp_kayit_tarihi` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Tetikleyiciler `ktp_odunc_gr_vr`
--
DROP TRIGGER IF EXISTS `trg_odunc_gr_vr`;
DELIMITER //
CREATE TRIGGER `trg_odunc_gr_vr` AFTER INSERT ON `ktp_odunc_gr_vr`
 FOR EACH ROW update kitaplar  set ktp_adedi=ktp_adedi+1  where ktp_brkt_nmr=new.ktp_brkt_nmr
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ogr`
--

DROP TABLE IF EXISTS `ogr`;
CREATE TABLE IF NOT EXISTS `ogr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ogr_tc_no` text CHARACTER SET utf8 COLLATE utf8_turkish_ci NOT NULL,
  `ogr_adi` varchar(100) CHARACTER SET utf8 COLLATE utf8_turkish_ci NOT NULL,
  `ogr_syd` varchar(100) CHARACTER SET utf8 COLLATE utf8_turkish_ci NOT NULL,
  `ogr_snf` varchar(15) CHARACTER SET utf8 COLLATE utf8_turkish_ci NOT NULL,
  `ogr_tel_no` varchar(13) CHARACTER SET utf8 COLLATE utf8_turkish_ci NOT NULL,
  `kyt_trh` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Tablo döküm verisi `ogr`
--

INSERT INTO `ogr` VALUES
(3, '22018635785', 'Ebubekir', 'Bastama', '11/C', '05554128854', '2016-09-21 13:17:01'),
(4, '12345', 'Hasen', 'Mintizar', '11/c', '05554786524', '2016-10-04 21:55:54');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yetkili`
--

DROP TABLE IF EXISTS `yetkili`;
CREATE TABLE IF NOT EXISTS `yetkili` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ytkl_ismi` varchar(50) CHARACTER SET latin1 NOT NULL,
  `ytkl_soyadi` varchar(50) CHARACTER SET latin1 NOT NULL,
  `ytkl_unvani` varchar(100) CHARACTER SET latin1 NOT NULL,
  `ytkl_sfr` varchar(100) CHARACTER SET latin1 NOT NULL,
  `ytkl_kyt_trh` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Tablo döküm verisi `yetkili`
--

INSERT INTO `yetkili` VALUES
(1, 'ebubekir', 'Bastama', '1', '123', '2016-09-21 13:17:21');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
