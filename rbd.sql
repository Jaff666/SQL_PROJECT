CREATE TABLE IF NOT EXISTS Rola(
    ID_Rola INT PRIMARY KEY AUTO_INCREMENT,
    Nazwa VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Partner(
    ID_Partner INT PRIMARY KEY AUTO_INCREMENT,
    ID_Rola INT,
    Email VARCHAR(30),
    Nazwisko VARCHAR(30) NOT NULL,
    Imie VARCHAR(20) NOT NULL,
    Nr_konta CHAR(16) NOT NULL,
    Nr_telefonu VARCHAR(12) NOT NULL,
    FOREIGN KEY (ID_rola) REFERENCES Rola(ID_Rola)
);

CREATE TABLE IF NOT EXISTS Promocja (
    ID_Promocja INT PRIMARY KEY AUTO_INCREMENT,
    Nazwa VARCHAR(40) NOT NULL,
    Upust FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS Producent (
    ID_Producent INT PRIMARY KEY AUTO_INCREMENT,
    Nazwa_firmy VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS Produkt(
    ID_Produkt INT PRIMARY KEY AUTO_INCREMENT,
    Nazwa VARCHAR(40) NOT NULL,
    Rozmiar VARCHAR(50) NOT NULL,
    ID_Promocja INT,
    ID_Producent INT,
    Cena FLOAT,
    Gwarancja VARCHAR(20),
    FOREIGN KEY (ID_Promocja) REFERENCES Promocja(ID_Promocja),
    FOREIGN KEY (ID_Producent) REFERENCES Producent(ID_Producent)
);

CREATE TABLE IF NOT EXISTS Stan (
    ID_Stan INT PRIMARY KEY AUTO_INCREMENT,
    ID_Produkt INT,
    Ilosc INT,
    FOREIGN KEY (ID_Produkt) REFERENCES Produkt(ID_Produkt)
);

CREATE TABLE IF NOT EXISTS Klient (
    ID_Klient INT AUTO_INCREMENT PRIMARY KEY,
    Nazwisko VARCHAR(60) NOT NULL,
    Imie VARCHAR(60) NOT NULL,
    Nr_telefonu VARCHAR(12) NOT NULL,
    Ulica VARCHAR(50),
    Miasto VARCHAR (50) NOT NULL,
    Email VARCHAR (50)
);

CREATE TABLE IF NOT EXISTS Zamowienie (
    ID_Zamowienie INT AUTO_INCREMENT PRIMARY KEY,
    Data_kupna DATE NOT NULL,
    ID_Klient INT,
    FOREIGN KEY (ID_Klient) REFERENCES Klient(ID_Klient)
);

CREATE TABLE IF NOT EXISTS Platnosc (
    ID_Platnosc INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Rodzaj_platnosci VARCHAR (10) NOT NULL,
    ID_Zamowienie INT,
    FOREIGN KEY (ID_Zamowienie) REFERENCES Zamowienie(ID_Zamowienie)
);

CREATE TABLE IF NOT EXISTS Firma_kurierska (
    ID_Firma_kurierska INT AUTO_INCREMENT PRIMARY KEY,
    Nazwa_firmy VARCHAR(30) NOT NULL,
    Adres_firmy VARCHAR (30)
);

CREATE TABLE IF NOT EXISTS Dostawa (
    ID_Dostawa INT AUTO_INCREMENT PRIMARY KEY,
    Data_dostawy DATE NOT NULL,
    ID_Zamowienie INT,
    ID_Klient INT,
    ID_Firma_kurierska INT,
    FOREIGN KEY (ID_Zamowienie) REFERENCES Zamowienie(ID_Zamowienie),
    FOREIGN KEY (ID_Klient) REFERENCES Klient(ID_Klient),
    FOREIGN KEY (ID_Firma_kurierska) REFERENCES Firma_kurierska(ID_Firma_kurierska)
    
);

CREATE TABLE IF NOT EXISTS Reklamacja (
    ID_Reklamacja INT AUTO_INCREMENT PRIMARY KEY,
    Opis VARCHAR(255),
    Data_reklamacji DATE
);

CREATE TABLE IF NOT EXISTS Zamowienie_produkt (
    ID_zamowienie_produkt INT AUTO_INCREMENT PRIMARY KEY,
    ID_Produkt INT,
    ID_Zamowienie INT,
    Ilosc INT NOT NULL,
    FOREIGN KEY (ID_Produkt) REFERENCES Produkt(ID_Produkt),
    FOREIGN KEY (ID_Zamowienie) REFERENCES Zamowienie(ID_Zamowienie)
);


DELIMITER //
CREATE TRIGGER partner_email
BEFORE INSERT
ON Partner FOR EACH ROW
BEGIN
	IF NEW.email IS NULL THEN
    SET NEW.email = CONCAT(LOWER(NEW.Imie),".",LOWER(New.Nazwisko),"@scamshop.partner.pl");
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER client_email
BEFORE INSERT
ON Klient FOR EACH ROW
BEGIN
	IF NEW.email IS NULL THEN
    SET NEW.email = CONCAT(LOWER(NEW.Imie),".",LOWER(New.Nazwisko),"@scamshop.client.pl");
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER partner_phone
BEFORE INSERT
ON Partner FOR EACH ROW
BEGIN
	IF NEW.Nr_telefonu IS NULL THEN
    SET NEW.Nr_telefonu = CONCAT("+48"," ",NEW.Nr_telefonu);
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER client_phone
BEFORE INSERT
ON Klient FOR EACH ROW
BEGIN
	IF NEW.Nr_telefonu IS NULL THEN
    SET NEW.Nr_telefonu = CONCAT("+48"," ",New.Nr_telefonu);
    END IF;
END//
DELIMITER ;


INSERT INTO Rola VALUES (
    DEFAULT, 'Sprzedawca'
);
INSERT INTO Partner VALUES (
    DEFAULT, '1', NULL, 'Hyla', 'Michal', '2199328129050312', '281482102'
);
INSERT INTO Producent VALUES(
    DEFAULT, 'AlJazeera ze Szczecina'
);
INSERT INTO Promocja VALUES (
    DEFAULT, 'Summer Sale' , 0.8
);
INSERT INTO Produkt VALUES (
    DEFAULT,'Bluza Nike', 'M', 1, 1, 50, '10 lat'
);
INSERT INTO Stan VALUES (
    DEFAULT, 1, 50
);
INSERT INTO Klient VALUES(
    DEFAULT, "Batory", "Stefan", "489111333","Amona 15","Gdansk","stefan.batory@wp.pl"
); 
INSERT INTO Zamowienie VALUES(
    DEFAULT,"2020-02-19",1
); 
INSERT INTO Platnosc VALUES(
    DEFAULT,"Karta",1
); 
INSERT INTO Firma_kurierska VALUES(
    1,"Batory Industries","Gdansk, Batorego 28"
); 
INSERT INTO Dostawa VALUES(
    DEFAULT,"2020-02-22",1,1,1
);
INSERT INTO Reklamacja VALUES(
    DEFAULT,"Paczka smierdziala jak ja otworzylem","2020-02-22"
); 
INSERT INTO Zamowienie_produkt VALUES(
    DEFAULT,1,1,1
);

INSERT INTO Rola VALUES (
    DEFAULT, 'Dostawca'
);
INSERT INTO Partner VALUES (
    DEFAULT, '2', 'etwardzik@pis.pl', 'Twardzik', 'Emil', '2133328129050322', '333444555'
);
INSERT INTO Producent VALUES(
    DEFAULT, 'AlJazeera z Grunwaldu'
);
INSERT INTO Promocja VALUES (
    DEFAULT, 'Brak' , 0.0
);
INSERT INTO Produkt VALUES (
    DEFAULT,'Koszulka Addias',"L",2, 2, 30, '2 lata'
);
INSERT INTO Stan VALUES (
    DEFAULT, 2, 30
);
INSERT INTO Klient VALUES(
    DEFAULT, "Kalinowski", "Michal", "999222111","Zeusa 69","Gdynia",NULL
); 
INSERT INTO Zamowienie VALUES(
    DEFAULT,"2019-02-19",2
); 
INSERT INTO Platnosc VALUES(
    DEFAULT,"Gotowka",2
); 
INSERT INTO Firma_kurierska VALUES(
    2,"Batory Industries","Gdansk, Batorego 28"
); 
INSERT INTO Dostawa VALUES(
    DEFAULT,"2019-02-22",2,2,2
);
INSERT INTO Reklamacja VALUES(
    DEFAULT,NULL,NULL
); 
INSERT INTO Zamowienie_produkt VALUES(
    DEFAULT,2,2,2
);

INSERT INTO Rola VALUES (
    DEFAULT, 'Zlota raczka'
);
INSERT INTO Partner VALUES (
    DEFAULT, '3', 'blaskowkski@tvp.pl', 'Laskowski', 'Bartosz', '1111111111111111', '666666666'
);
INSERT INTO Producent VALUES(
    DEFAULT, 'Kapitan Dupa z PJATKU'
);
INSERT INTO Promocja VALUES (
    DEFAULT, 'Summer Sale' , 0.5
);
INSERT INTO Produkt VALUES (
    DEFAULT,'Buty z sultanem kosmitow','42', 3, 3, 300, '100 lat'
);
INSERT INTO Stan VALUES (
    DEFAULT, 3, 50
);
INSERT INTO Klient VALUES(
    DEFAULT, "Pilsudski", "Jozef", "999999999","Wladyslawa 4","Gdynia",NULL
); 
INSERT INTO Zamowienie VALUES(
    DEFAULT,"2020-02-19",3
); 
INSERT INTO Platnosc VALUES(
    DEFAULT,"Faktura",3
); 
INSERT INTO Firma_kurierska VALUES(
    DEFAULT,"Jozef Industries","Gdansk, Joachima 28"
); 
INSERT INTO Dostawa VALUES(
    DEFAULT,"2020-02-22",3,3,3
);
INSERT INTO Reklamacja VALUES(
    DEFAULT,NULL,NULL
); 
INSERT INTO Zamowienie_produkt VALUES(
    DEFAULT,3,3,3
);

INSERT INTO Rola VALUES (
    DEFAULT, 'Dostawca'
);
INSERT INTO Partner VALUES (
    DEFAULT, '4', NULL, 'Januszewski', 'Patryk', '8888888888888888', '222222222'
);
INSERT INTO Producent VALUES(
    DEFAULT, 'Sultan kosmitow z planety kurwix'
);
INSERT INTO Promocja VALUES (
    DEFAULT, 'Brak' , 0.0
);
INSERT INTO Produkt VALUES (
    DEFAULT,'Czapka z logiem galaktyki kurwix', 'S', 4, 4, 1000, '1 rok'
);
INSERT INTO Stan VALUES (
    DEFAULT, 4, 1
);
INSERT INTO Klient VALUES(
    DEFAULT, "Zemajtys", "Filip", "999999999","Genarala Marii Wittekowny 4","Gdynia",NULL
); 
INSERT INTO Zamowienie VALUES(
    DEFAULT,"2021-02-19",4
); 
INSERT INTO Platnosc VALUES(
    DEFAULT,"Karta",4
); 
INSERT INTO Firma_kurierska VALUES(
    DEFAULT,"Jaff Industries","Sopot, Sopocka 28"
); 
INSERT INTO Dostawa VALUES(
    DEFAULT,"2021-02-25",4,4,4
);
INSERT INTO Reklamacja VALUES(
    DEFAULT,NULL,NULL
); 
INSERT INTO Zamowienie_produkt VALUES(
    DEFAULT,4,4,4
);


INSERT INTO Rola VALUES (
    DEFAULT, 'Sprzedawca'
);
INSERT INTO Partner VALUES (
    DEFAULT, 5, NULL, 'Sroka', 'Patryk', '8888888888888888', '313121444'
);
INSERT INTO Producent VALUES(
    DEFAULT, 'Lepkie palce company'
);
INSERT INTO Promocja VALUES (
    DEFAULT, 'Kup jedna zaplac za dwie' , 0.0
);
INSERT INTO Produkt VALUES (
    DEFAULT,'Dziwnie lepkie rekawiczki', 'XL', 5, 5, 420, '10 lat'
);
INSERT INTO Stan VALUES (
    DEFAULT, 5, 100
);
INSERT INTO Klient VALUES(
    DEFAULT, "Paluszek", "Joachim", "555666111","Zadupie 44","Oborniki","joachim.ze@gmail.com"
); 
INSERT INTO Zamowienie VALUES(
    DEFAULT,"2012-05-19",5
); 
INSERT INTO Platnosc VALUES(
    DEFAULT,"Gotowka",5
); 
INSERT INTO Firma_kurierska VALUES(
    DEFAULT,"Setler Industries","Warszawa, Aleje Jerozolimskie 28"
); 
INSERT INTO Dostawa VALUES(
    DEFAULT,"2021-02-25",5,5,5
);
INSERT INTO Reklamacja VALUES(
    DEFAULT,"Produkt niezgodny z opisem","2021-02-25"
); 
INSERT INTO Zamowienie_produkt VALUES(
    DEFAULT,5,5,5
);


INSERT INTO Rola VALUES (
    DEFAULT, 'Sprzedawca'
);
INSERT INTO Partner VALUES (
    DEFAULT, 6, NULL, 'Szulist', 'Artur', '3333333333333333', '777888999'
);
INSERT INTO Producent VALUES(
    DEFAULT, 'Czarny barak z bialego domu'
);
INSERT INTO Promocja VALUES (
    DEFAULT, 'BLM' , 0.4
);
INSERT INTO Produkt VALUES (
    DEFAULT,'Bokserki z bialymi plamami', 'M', 6, 6, 30, '4 lata'
);
INSERT INTO Stan VALUES (
    DEFAULT, 6, 10
);
INSERT INTO Klient VALUES(
    DEFAULT, "Zemajtys", "Filip", "999999999","Aleje Straszne","Gdynia",NULL
); 
INSERT INTO Zamowienie VALUES(
    DEFAULT,"2022-04-30",6
); 
INSERT INTO Platnosc VALUES(
    DEFAULT,"Karta",6
); 
INSERT INTO Firma_kurierska VALUES(
    DEFAULT,"Avenger Industries","Grunwald, Grunwaldzka 1410"
); 
INSERT INTO Dostawa VALUES(
    DEFAULT,"2021-02-25",6,6,6
);
INSERT INTO Reklamacja VALUES(
    DEFAULT,NULL,NULL
); 
INSERT INTO Zamowienie_produkt VALUES(
    DEFAULT,6,6,6
);


INSERT INTO Rola VALUES (
    DEFAULT, 'Dostawca'
);
INSERT INTO Partner VALUES (
    DEFAULT, 7, 'mchyla@tvpis.pl', 'Chyla', 'Michal', '1312312131231312', '666666666'
);
INSERT INTO Producent VALUES(
    DEFAULT, 'Kapitan bombadiero'
);
INSERT INTO Promocja VALUES (
    DEFAULT, 'Brak' , 0.0
);
INSERT INTO Produkt VALUES (
    DEFAULT,'Bluza Nike', 'XXL', 7, 7, 1000, '1 rok'
);
INSERT INTO Stan VALUES (
    DEFAULT, 7, 1000
);
INSERT INTO Klient VALUES(
    DEFAULT, "Zemajtys", "Filip", "999999999","Obroncow Wybrzeza","Gdansk",NULL
); 
INSERT INTO Zamowienie VALUES(
    DEFAULT,"2015-02-19",7
); 
INSERT INTO Platnosc VALUES(
    DEFAULT,"Karta",7
); 
INSERT INTO Firma_kurierska VALUES(
    DEFAULT,"Zuo Industries","Gdynia, 3 maja 66"
); 
INSERT INTO Dostawa VALUES(
    DEFAULT,"2016-02-25",7,7,7
);
INSERT INTO Reklamacja VALUES(
    DEFAULT,"Nadruk szybko sie spral","2017-02-25"
); 
INSERT INTO Zamowienie_produkt VALUES(
    DEFAULT,7,7,7
);

INSERT INTO Rola VALUES (
    DEFAULT, 'Sprzedawca'
);
INSERT INTO Partner VALUES (
    DEFAULT, 8, NULL, 'Kalinowski', 'Mariusz', '4444444444444444', '222222222'
);
INSERT INTO Producent VALUES(
    DEFAULT, 'Sultan kosmitow z planety kurwix'
);
INSERT INTO Promocja VALUES (
    DEFAULT, 'All in' , 0.9
);
INSERT INTO Produkt VALUES (
    DEFAULT,'Czapka z logiem galaktyki kurwix', 'XL', 8, 8, 1000, '1 rok'
);
INSERT INTO Stan VALUES (
    DEFAULT, 8, 1
);
INSERT INTO Klient VALUES(
    DEFAULT, "Chyla", "Filip", "231312333","Wychodek 72","Gdynia",NULL
); 
INSERT INTO Zamowienie VALUES(
    DEFAULT,"2021-09-19",8
); 
INSERT INTO Platnosc VALUES(
    DEFAULT,"Gotowka",8
); 
INSERT INTO Firma_kurierska VALUES(
    DEFAULT,"Jaff Industries","Sopot, Sopocka 28"
); 
INSERT INTO Dostawa VALUES(
    DEFAULT,"2021-10-25",8,8,8
);
INSERT INTO Reklamacja VALUES(
    DEFAULT,NULL,NULL
); 
INSERT INTO Zamowienie_produkt VALUES(
    DEFAULT,8,8,8
);

DELIMITER /
CREATE PROCEDURE test1.all()
BEGIN
SELECT SUM(Ilosc) from stan;
END//
DELIMITER ;



DELIMITER //
CREATE PROCEDURE test1.zamowienieData(IN Data DATE)
BEGIN
	SELECT * FROM zamowienie
    WHERE Data_kupna = Data;
END//
DELIMITER ;



DELIMITER //
CREATE PROCEDURE test1.wybierzRozmiar(IN rozmiar VARCHAR(10) )
BEGIN
	SELECT * FROM produkt
    WHERE produkt.Rozmiar = rozmiar;
END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE test1.zaufaniKurierzy(IN kod INT )
BEGIN
IF kod = 2137 THEN 
	SELECT * FROM firma_kurierska
    WHERE firma_kurierska.Nazwa_firmy IN('Zuo Industries','Jaff Industries', 'Avenger Industries');
END IF;
END//
DELIMITER ;
