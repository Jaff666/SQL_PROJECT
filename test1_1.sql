-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 21 Cze 2021, 22:54
-- Wersja serwera: 10.4.18-MariaDB
-- Wersja PHP: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `test1`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `all` ()  BEGIN
SELECT SUM(Ilosc) from stan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePromocja` ()  BEGIN
DECLARE x INT DEFAULT 0;
DECLARE n INT DEFAULT 0;
SELECT COUNT(*) FROM promocja INTO n;

SET x = 0;
    WHILE x < n DO       
        UPDATE Produkt 
        SET Cena_Promocja = Cena * (SELECT Upust from Promocja WHERE produkt.ID_Promocja = promocja.ID_Promocja); 
        SET x = x + 1;
       END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `wybierzRozmiar` (IN `rozmiar` VARCHAR(10))  BEGIN
	SELECT * FROM produkt
    WHERE produkt.Rozmiar = rozmiar;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `zamowienieData` (IN `Data` DATE)  BEGIN
	SELECT * FROM zamowienie
    WHERE Data_kupna = Data;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `zaufaniKurierzy` (IN `kod` INT)  BEGIN
IF kod = 2137 THEN 
	SELECT * FROM firma_kurierska
    WHERE firma_kurierska.Nazwa_firmy IN('Zuo Industries','Jaff Industries', 'Avenger Industries');
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dostawa`
--

CREATE TABLE `dostawa` (
  `ID_Dostawa` int(11) NOT NULL,
  `Data_dostawy` date NOT NULL,
  `ID_Zamowienie` int(11) DEFAULT NULL,
  `ID_Klient` int(11) DEFAULT NULL,
  `ID_Firma_kurierska` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `dostawa`
--

INSERT INTO `dostawa` (`ID_Dostawa`, `Data_dostawy`, `ID_Zamowienie`, `ID_Klient`, `ID_Firma_kurierska`) VALUES
(1, '2020-02-22', 1, 1, 1),
(2, '2019-02-22', 2, 2, 2),
(3, '2020-02-22', 3, 3, 3),
(4, '2021-02-25', 4, 4, 4),
(5, '2021-02-25', 5, 5, 5),
(6, '2021-02-25', 6, 6, 6),
(7, '2016-02-25', 7, 7, 7),
(8, '2021-10-25', 8, 8, 8);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `firma_kurierska`
--

CREATE TABLE `firma_kurierska` (
  `ID_Firma_kurierska` int(11) NOT NULL,
  `Nazwa_firmy` varchar(30) NOT NULL,
  `Adres_firmy` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `firma_kurierska`
--

INSERT INTO `firma_kurierska` (`ID_Firma_kurierska`, `Nazwa_firmy`, `Adres_firmy`) VALUES
(1, 'Batory Industries', 'Gdansk, Batorego 28'),
(2, 'Batory Industries', 'Gdansk, Batorego 28'),
(3, 'Jozef Industries', 'Gdansk, Joachima 28'),
(4, 'Jaff Industries', 'Sopot, Sopocka 28'),
(5, 'Setler Industries', 'Warszawa, Aleje Jerozolimskie '),
(6, 'Avenger Industries', 'Grunwald, Grunwaldzka 1410'),
(7, 'Zuo Industries', 'Gdynia, 3 maja 66'),
(8, 'Jaff Industries', 'Sopot, Sopocka 28');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klient`
--

CREATE TABLE `klient` (
  `ID_Klient` int(11) NOT NULL,
  `Nazwisko` varchar(60) NOT NULL,
  `Imie` varchar(60) NOT NULL,
  `Nr_telefonu` varchar(12) NOT NULL,
  `Ulica` varchar(50) DEFAULT NULL,
  `Miasto` varchar(50) NOT NULL,
  `Email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `klient`
--

INSERT INTO `klient` (`ID_Klient`, `Nazwisko`, `Imie`, `Nr_telefonu`, `Ulica`, `Miasto`, `Email`) VALUES
(1, 'Batory', 'Stefan', '+48 48911133', 'Amona 15', 'Gdansk', 'stefan.batory@wp.pl'),
(2, 'Kalinowski', 'Michal', '+48 99922211', 'Zeusa 69', 'Gdynia', 'michal.kalinowski@scamshop.client.pl'),
(3, 'Pilsudski', 'Jozef', '+48 99999999', 'Wladyslawa 4', 'Gdynia', 'jozef.pilsudski@scamshop.client.pl'),
(4, 'Zemajtys', 'Filip', '+48 99999999', 'Genarala Marii Wittekowny 4', 'Gdynia', 'filip.zemajtys@scamshop.client.pl'),
(5, 'Paluszek', 'Joachim', '+48 55566611', 'Zadupie 44', 'Oborniki', 'joachim.ze@gmail.com'),
(6, 'Zemajtys', 'Filip', '+48 99999999', 'Aleje Straszne', 'Gdynia', 'filip.zemajtys@scamshop.client.pl'),
(7, 'Zemajtys', 'Filip', '+48 99999999', 'Obroncow Wybrzeza', 'Gdansk', 'filip.zemajtys@scamshop.client.pl'),
(8, 'Chyla', 'Filip', '+48 23131233', 'Wychodek 72', 'Gdynia', 'filip.chyla@scamshop.client.pl');

--
-- Wyzwalacze `klient`
--
DELIMITER $$
CREATE TRIGGER `client_email` BEFORE INSERT ON `klient` FOR EACH ROW BEGIN
	IF NEW.email IS NULL THEN
    SET NEW.email = CONCAT(LOWER(NEW.Imie),".",LOWER(New.Nazwisko),"@scamshop.client.pl");
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `client_phone` BEFORE INSERT ON `klient` FOR EACH ROW BEGIN
	IF LENGTH(NEW.Nr_telefonu) = 9 THEN
    SET NEW.Nr_telefonu = CONCAT("+48"," ",New.Nr_telefonu);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `partner`
--

CREATE TABLE `partner` (
  `ID_Partner` int(11) NOT NULL,
  `ID_Rola` int(11) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Nazwisko` varchar(30) NOT NULL,
  `Imie` varchar(20) NOT NULL,
  `Nr_konta` char(16) NOT NULL,
  `Nr_telefonu` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `partner`
--

INSERT INTO `partner` (`ID_Partner`, `ID_Rola`, `Email`, `Nazwisko`, `Imie`, `Nr_konta`, `Nr_telefonu`) VALUES
(1, 1, 'michal.hyla@scamshop.partner.pl', 'Hyla', 'Michal', '2199328129050312', '+48 28148210'),
(2, 2, 'etwardzik@pis.pl', 'Twardzik', 'Emil', '2133328129050322', '+48 33344455'),
(3, 3, 'blaskowkski@tvp.pl', 'Laskowski', 'Bartosz', '1111111111111111', '+48 66666666'),
(4, 4, 'patryk.januszewski@scamshop.partner.pl', 'Januszewski', 'Patryk', '8888888888888888', '+48 22222222'),
(5, 5, 'patryk.sroka@scamshop.partner.pl', 'Sroka', 'Patryk', '8888888888888888', '+48 31312144'),
(6, 6, 'artur.szulist@scamshop.partner.pl', 'Szulist', 'Artur', '3333333333333333', '+48 77788899'),
(7, 7, 'mchyla@tvpis.pl', 'Chyla', 'Michal', '1312312131231312', '+48 66666666'),
(8, 8, 'mariusz.kalinowski@scamshop.partner.pl', 'Kalinowski', 'Mariusz', '4444444444444444', '+48 22222222');

--
-- Wyzwalacze `partner`
--
DELIMITER $$
CREATE TRIGGER `partner_email` BEFORE INSERT ON `partner` FOR EACH ROW BEGIN
	IF NEW.email IS NULL THEN
    SET NEW.email = CONCAT(LOWER(NEW.Imie),".",LOWER(New.Nazwisko),"@scamshop.partner.pl");
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `partner_phone` BEFORE INSERT ON `partner` FOR EACH ROW BEGIN
	IF LENGTH(NEW.Nr_telefonu) = 9 THEN
    SET NEW.Nr_telefonu = CONCAT("+48"," ",NEW.Nr_telefonu);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `platnosc`
--

CREATE TABLE `platnosc` (
  `ID_Platnosc` int(11) NOT NULL,
  `Rodzaj_platnosci` varchar(10) NOT NULL,
  `ID_Zamowienie` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `platnosc`
--

INSERT INTO `platnosc` (`ID_Platnosc`, `Rodzaj_platnosci`, `ID_Zamowienie`) VALUES
(1, 'Karta', 1),
(2, 'Gotowka', 2),
(3, 'Faktura', 3),
(4, 'Karta', 4),
(5, 'Gotowka', 5),
(6, 'Karta', 6),
(7, 'Karta', 7),
(8, 'Gotowka', 8);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `producent`
--

CREATE TABLE `producent` (
  `ID_Producent` int(11) NOT NULL,
  `Nazwa_firmy` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `producent`
--

INSERT INTO `producent` (`ID_Producent`, `Nazwa_firmy`) VALUES
(1, 'AlJazeera ze Szczecina'),
(2, 'AlJazeera z Grunwaldu'),
(3, 'Kapitan Dupa z PJATKU'),
(4, 'Sultan kosmitow z planety kurwix'),
(5, 'Lepkie palce company'),
(6, 'Czarny barak z bialego domu'),
(7, 'Kapitan bombadiero'),
(8, 'Sultan kosmitow z planety kurwix');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkt`
--

CREATE TABLE `produkt` (
  `ID_Produkt` int(11) NOT NULL,
  `Nazwa` varchar(40) NOT NULL,
  `Rozmiar` varchar(50) NOT NULL,
  `ID_Promocja` int(11) DEFAULT NULL,
  `ID_Producent` int(11) DEFAULT NULL,
  `Cena` double(10,2) DEFAULT NULL,
  `Cena_Promocja` double(10,2) DEFAULT NULL,
  `Gwarancja` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `produkt`
--

INSERT INTO `produkt` (`ID_Produkt`, `Nazwa`, `Rozmiar`, `ID_Promocja`, `ID_Producent`, `Cena`, `Cena_Promocja`, `Gwarancja`) VALUES
(1, 'Bluza Nike', 'M', 1, 1, 50.00, 40.00, '10 lat'),
(2, 'Koszulka Addias', 'L', 2, 2, 30.00, 0.00, '2 lata'),
(3, 'Buty z sultanem kosmitow', '42', 3, 3, 300.00, 150.00, '100 lat'),
(4, 'Czapka z logiem galaktyki kurwix', 'S', 4, 4, 1000.00, 0.00, '1 rok'),
(5, 'Dziwnie lepkie rekawiczki', 'XL', 5, 5, 420.00, 0.00, '10 lat'),
(6, 'Bokserki z bialymi plamami', 'M', 6, 6, 30.00, 12.00, '4 lata'),
(7, 'Bluza Nike', 'XXL', 7, 7, 1000.00, 0.00, '1 rok'),
(8, 'Czapka z logiem galaktyki kurwix', 'XL', 8, 8, 1000.00, 900.00, '1 rok');

--
-- Wyzwalacze `produkt`
--
DELIMITER $$
CREATE TRIGGER `update_price` AFTER INSERT ON `produkt` FOR EACH ROW BEGIN
    CALL updatePromocja();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `promocja`
--

CREATE TABLE `promocja` (
  `ID_Promocja` int(11) NOT NULL,
  `Nazwa` varchar(40) NOT NULL,
  `Upust` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `promocja`
--

INSERT INTO `promocja` (`ID_Promocja`, `Nazwa`, `Upust`) VALUES
(1, 'Summer Sale', 0.80),
(2, 'Brak', 0.00),
(3, 'Summer Sale', 0.50),
(4, 'Brak', 0.00),
(5, 'Kup jedna zaplac za dwie', 0.00),
(6, 'BLM', 0.40),
(7, 'Brak', 0.00),
(8, 'All in', 0.90);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `reklamacja`
--

CREATE TABLE `reklamacja` (
  `ID_Reklamacja` int(11) NOT NULL,
  `Opis` varchar(255) DEFAULT NULL,
  `Data_reklamacji` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `reklamacja`
--

INSERT INTO `reklamacja` (`ID_Reklamacja`, `Opis`, `Data_reklamacji`) VALUES
(1, 'Paczka smierdziala jak ja otworzylem', '2020-02-22'),
(2, 'Brak uwag do zamowienia', 'Brak daty '),
(3, 'Brak uwag do zamowienia', 'Brak daty '),
(4, 'Brak uwag do zamowienia', 'Brak daty '),
(5, 'Produkt niezgodny z opisem', '2021-02-25'),
(6, 'Brak uwag do zamowienia', 'Brak daty '),
(7, 'Nadruk szybko sie spral', '2017-02-25'),
(8, 'Brak uwag do zamowienia', 'Brak daty ');

--
-- Wyzwalacze `reklamacja`
--
DELIMITER $$
CREATE TRIGGER `set_basic_date` BEFORE INSERT ON `reklamacja` FOR EACH ROW BEGIN
	IF NEW.Data_reklamacji IS NULL THEN
    SET NEW.Data_reklamacji = CONCAT("Brak daty reklamacji");
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `set_basic_description` BEFORE INSERT ON `reklamacja` FOR EACH ROW BEGIN
	IF NEW.Opis IS NULL THEN
    SET NEW.Opis = CONCAT("Brak uwag do zamowienia");
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rola`
--

CREATE TABLE `rola` (
  `ID_Rola` int(11) NOT NULL,
  `Nazwa` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `rola`
--

INSERT INTO `rola` (`ID_Rola`, `Nazwa`) VALUES
(1, 'Sprzedawca'),
(2, 'Dostawca'),
(3, 'Zlota raczka'),
(4, 'Dostawca'),
(5, 'Sprzedawca'),
(6, 'Sprzedawca'),
(7, 'Dostawca'),
(8, 'Sprzedawca');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `stan`
--

CREATE TABLE `stan` (
  `ID_Stan` int(11) NOT NULL,
  `ID_Produkt` int(11) DEFAULT NULL,
  `Ilosc` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `stan`
--

INSERT INTO `stan` (`ID_Stan`, `ID_Produkt`, `Ilosc`) VALUES
(1, 1, 50),
(2, 2, 30),
(3, 3, 50),
(4, 4, 1),
(5, 5, 100),
(6, 6, 10),
(7, 7, 1000),
(8, 8, 1);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `zamowienia_kompletne`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `zamowienia_kompletne` (
`id_dostawa` int(11)
,`data_dostawy` date
,`Data_kupna` date
,`Nazwa` varchar(40)
,`Rozmiar` varchar(50)
,`Nazwisko` varchar(60)
,`Imie` varchar(60)
,`Nr_telefonu` varchar(12)
,`nazwa_firmy` varchar(30)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zamowienie`
--

CREATE TABLE `zamowienie` (
  `ID_Zamowienie` int(11) NOT NULL,
  `Data_kupna` date NOT NULL,
  `ID_Klient` int(11) DEFAULT NULL,
  `ID_Produkt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `zamowienie`
--

INSERT INTO `zamowienie` (`ID_Zamowienie`, `Data_kupna`, `ID_Klient`, `ID_Produkt`) VALUES
(1, '2020-02-19', 1, 1),
(2, '2019-02-19', 2, 2),
(3, '2020-02-19', 3, 3),
(4, '2021-02-19', 4, 4),
(5, '2012-05-19', 5, 5),
(6, '2022-04-30', 6, 6),
(7, '2015-02-19', 7, 7),
(8, '2021-09-19', 8, 8);

-- --------------------------------------------------------

--
-- Struktura widoku `zamowienia_kompletne`
--
DROP TABLE IF EXISTS `zamowienia_kompletne`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `zamowienia_kompletne`  AS SELECT `dostawa`.`ID_Dostawa` AS `id_dostawa`, `dostawa`.`Data_dostawy` AS `data_dostawy`, `zamowienie`.`Data_kupna` AS `Data_kupna`, `produkt`.`Nazwa` AS `Nazwa`, `produkt`.`Rozmiar` AS `Rozmiar`, `klient`.`Nazwisko` AS `Nazwisko`, `klient`.`Imie` AS `Imie`, `klient`.`Nr_telefonu` AS `Nr_telefonu`, `firma_kurierska`.`Nazwa_firmy` AS `nazwa_firmy` FROM ((((`dostawa` join `klient` on(`dostawa`.`ID_Klient` = `klient`.`ID_Klient`)) join `zamowienie` on(`dostawa`.`ID_Zamowienie` = `zamowienie`.`ID_Zamowienie`)) join `firma_kurierska` on(`firma_kurierska`.`ID_Firma_kurierska` = `dostawa`.`ID_Firma_kurierska`)) join `produkt` on(`produkt`.`ID_Produkt` = `zamowienie`.`ID_Produkt`)) ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `dostawa`
--
ALTER TABLE `dostawa`
  ADD PRIMARY KEY (`ID_Dostawa`),
  ADD KEY `ID_Zamowienie` (`ID_Zamowienie`),
  ADD KEY `ID_Klient` (`ID_Klient`),
  ADD KEY `ID_Firma_kurierska` (`ID_Firma_kurierska`);

--
-- Indeksy dla tabeli `firma_kurierska`
--
ALTER TABLE `firma_kurierska`
  ADD PRIMARY KEY (`ID_Firma_kurierska`);

--
-- Indeksy dla tabeli `klient`
--
ALTER TABLE `klient`
  ADD PRIMARY KEY (`ID_Klient`);

--
-- Indeksy dla tabeli `partner`
--
ALTER TABLE `partner`
  ADD PRIMARY KEY (`ID_Partner`),
  ADD KEY `ID_Rola` (`ID_Rola`);

--
-- Indeksy dla tabeli `platnosc`
--
ALTER TABLE `platnosc`
  ADD PRIMARY KEY (`ID_Platnosc`),
  ADD KEY `ID_Zamowienie` (`ID_Zamowienie`);

--
-- Indeksy dla tabeli `producent`
--
ALTER TABLE `producent`
  ADD PRIMARY KEY (`ID_Producent`);

--
-- Indeksy dla tabeli `produkt`
--
ALTER TABLE `produkt`
  ADD PRIMARY KEY (`ID_Produkt`),
  ADD KEY `ID_Promocja` (`ID_Promocja`),
  ADD KEY `ID_Producent` (`ID_Producent`);

--
-- Indeksy dla tabeli `promocja`
--
ALTER TABLE `promocja`
  ADD PRIMARY KEY (`ID_Promocja`);

--
-- Indeksy dla tabeli `reklamacja`
--
ALTER TABLE `reklamacja`
  ADD PRIMARY KEY (`ID_Reklamacja`);

--
-- Indeksy dla tabeli `rola`
--
ALTER TABLE `rola`
  ADD PRIMARY KEY (`ID_Rola`);

--
-- Indeksy dla tabeli `stan`
--
ALTER TABLE `stan`
  ADD PRIMARY KEY (`ID_Stan`),
  ADD KEY `ID_Produkt` (`ID_Produkt`);

--
-- Indeksy dla tabeli `zamowienie`
--
ALTER TABLE `zamowienie`
  ADD PRIMARY KEY (`ID_Zamowienie`),
  ADD KEY `ID_Klient` (`ID_Klient`),
  ADD KEY `ID_Produkt` (`ID_Produkt`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `dostawa`
--
ALTER TABLE `dostawa`
  MODIFY `ID_Dostawa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `firma_kurierska`
--
ALTER TABLE `firma_kurierska`
  MODIFY `ID_Firma_kurierska` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `klient`
--
ALTER TABLE `klient`
  MODIFY `ID_Klient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `partner`
--
ALTER TABLE `partner`
  MODIFY `ID_Partner` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `platnosc`
--
ALTER TABLE `platnosc`
  MODIFY `ID_Platnosc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `producent`
--
ALTER TABLE `producent`
  MODIFY `ID_Producent` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `produkt`
--
ALTER TABLE `produkt`
  MODIFY `ID_Produkt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `promocja`
--
ALTER TABLE `promocja`
  MODIFY `ID_Promocja` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `reklamacja`
--
ALTER TABLE `reklamacja`
  MODIFY `ID_Reklamacja` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `rola`
--
ALTER TABLE `rola`
  MODIFY `ID_Rola` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `stan`
--
ALTER TABLE `stan`
  MODIFY `ID_Stan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `zamowienie`
--
ALTER TABLE `zamowienie`
  MODIFY `ID_Zamowienie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `dostawa`
--
ALTER TABLE `dostawa`
  ADD CONSTRAINT `dostawa_ibfk_1` FOREIGN KEY (`ID_Zamowienie`) REFERENCES `zamowienie` (`ID_Zamowienie`),
  ADD CONSTRAINT `dostawa_ibfk_2` FOREIGN KEY (`ID_Klient`) REFERENCES `klient` (`ID_Klient`),
  ADD CONSTRAINT `dostawa_ibfk_3` FOREIGN KEY (`ID_Firma_kurierska`) REFERENCES `firma_kurierska` (`ID_Firma_kurierska`);

--
-- Ograniczenia dla tabeli `partner`
--
ALTER TABLE `partner`
  ADD CONSTRAINT `partner_ibfk_1` FOREIGN KEY (`ID_Rola`) REFERENCES `rola` (`ID_Rola`);

--
-- Ograniczenia dla tabeli `platnosc`
--
ALTER TABLE `platnosc`
  ADD CONSTRAINT `platnosc_ibfk_1` FOREIGN KEY (`ID_Zamowienie`) REFERENCES `zamowienie` (`ID_Zamowienie`);

--
-- Ograniczenia dla tabeli `produkt`
--
ALTER TABLE `produkt`
  ADD CONSTRAINT `produkt_ibfk_1` FOREIGN KEY (`ID_Promocja`) REFERENCES `promocja` (`ID_Promocja`),
  ADD CONSTRAINT `produkt_ibfk_2` FOREIGN KEY (`ID_Producent`) REFERENCES `producent` (`ID_Producent`);

--
-- Ograniczenia dla tabeli `stan`
--
ALTER TABLE `stan`
  ADD CONSTRAINT `stan_ibfk_1` FOREIGN KEY (`ID_Produkt`) REFERENCES `produkt` (`ID_Produkt`);

--
-- Ograniczenia dla tabeli `zamowienie`
--
ALTER TABLE `zamowienie`
  ADD CONSTRAINT `zamowienie_ibfk_1` FOREIGN KEY (`ID_Klient`) REFERENCES `klient` (`ID_Klient`),
  ADD CONSTRAINT `zamowienie_ibfk_2` FOREIGN KEY (`ID_Produkt`) REFERENCES `produkt` (`ID_Produkt`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
