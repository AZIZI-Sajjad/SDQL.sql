*** Se loguer au MySQL :
mysql -u root -p


***   Création une Table :
mysql> CREATE DATABASE BookDB;


les types de données :

1-    Numérique :
  Boolean :   0 --> false
              1 --> True
  TINYIT   :
              Avec "Signed"   -->   -128          --   127                      par-Défaut
              Sans "Signed"   -->    0            --   255

  STALLINT :  Avec "Signed"   -->   -32768        --    32767                   par-Défaut
              Sans "Signed"   -->   0             --    65535

  INT :       "UNSIGNED"      -->   0             --    4294967295
              sinon           -->   -2147483648   --    2147483647              par-Défaut



*****          Clé Première :
                        TYPE -->  INT
                        unique dans chaque table pour séparer les "Unité" par les autres



*****          Clé Etrangaire :
                        TYPE -->   INT
                        C'est pour relier les données de 2 tables différetes
.
mysql> CREATE DATABASE BookstoreDB;
mysql> USE BookstoreDB;
mysql> CREATE TABLE AuthorsTBL (
AuthorID INT NOT NULL AUTO_INCREMENT,
AuthorName VARCHAR(100),
PRIMARY KEY (AuthorID)
);

#########################
#########################                           Dans les commandes de MySQL :
#########################    Quand on voulais interroger les infos d'une table, il ne faudrait pas oublier
######################### la commande de choisir la BDD "USE <DATABASE_NAME>" avent la comnnade d'interrogation

mysql> USE BookstoreDB;
mysql> CREATE TABLE BooksTBL (
BookID INT NOT NULL AUTO_INCREMENT,
BookName VARCHAR(100) NOT NULL,
AuthorID INT NOT NULL,
BookPrice DECIMAL(6,2) NOT NULL,
BookLastUpdated TIMESTAMP,
BookIsAvailable BOOLEAN,
PRIMARY KEY(BookID),
FOREIGN KEY (AuthorID) REFERENCES AuthorsTBL(AuthorID)
);

***Insérer les données à une table :
mysql> USE BookstoreDB;
mysql> INSERT INTO AuthorsTBL (AuthorName) VALUES ('Sajjad Azizi'), ('Nazanin Tahmasebi'), ('Grégory Rassel');


********************
****    WHERE   ****
********************
* C'est pour trouver un enregistrement avec un Mot Clé :
mysql> SELECT * FROM AuthorsTBL  WHERE AuthorName='Sajaad Azizi';


* Pour afficher la totalité d'une table entirèrement :
mysql> USE BookstoreDB;
mysql> SELECT * FROM AuthorsTBL;



mysql> USE BookstoreDB;
mysql> INSERT INTO  BooksTBL (BookName, AuthorID, BookPrice, BookIsAvailable)
VALUES ('THIS IS SD', 1, 29.99, 1),
('THIS IS LINUX' , 1, 39.99, 1),
('THIS IS LINUX-2', 1, 39.99, 1),
('LA Cuisine', 2, 25.99, 0),
('Les fleures', 2, 20.99, 1),
('le Vélo', 3, 19.99, 1),
('DP-TSRIT', 3, 21.99, 1);
('DP-TSRIT', 2, 21.99, 1)
('Les Fleurs', 2, 25.99, 0),
('La Cuisine', 3, 20.99, 0);



**  UPDATE
mysql> UPDATE BooksTBL SET BookIsAvailable=0 WHERE BookID=7;

*****     Quand on veut mettre à jour une entité, c'est une bonne idée de faire "SELECT", avant des mettre à jour
*****     Normalement après "WHERE", On utilise une Clé Première,

*** SELECT :
**************    A Chaque fois on utilise "SELECT", pour vérifier et être sur qu'on "SELECT" des bonne entités, et des bons enregistrements.
mysql> SELECT * FROM BooksTBL;
mysql> UPDATE BooksTBL SET BookPrice=15.99 WHERE BookID=6;
mysql> SELECT * FROM BooksTBL WHERE BookID=6;




***   DELETE :
mysql> DELETE FROM BooksTBL WHERE BookID=6;




******    Relier des entités ensemble :
*****     Quand on veut relier 2 ou plusieurs onject exitenats sur les différents TABLE, Pour les Concatiner, on utilise "CONCAT"
mysql> SELECT CONCAT(BooksTBL.BookName, ' (', AuthorsTBL.AuthorName, ')') AS Description, BooksTBL.BookPrice FROM AuthorsTBL JOIN BooksTBL ON AuthorsTBL.AuthorID = BooksTBL.AuthorID;
mysql> SELECT CONCAT(BooksTBL.BookName, ' (', AuthorsTBL.AuthorName, ')') AS Description, BooksTBL.BookPrice FROM AuthorsTBL JOIN BooksTBL ON AuthorsTBL.AuthorID = BooksTBL.AuthorID;
mysql> SELECT CONCAT(BooksTBL.BookName, ' (', AuthorsTBL.AuthorID, ')') AS Commentaire, BooksTBL.BookPrice FROM AuthorsTBL JOIN BooksTBL ON AuthorsTBL.AuthorID = BooksTBL.AuthorID;


mysql> SELECT BookName, BookPrice FROM BooksTBL



******    SELECT DISTINCT :
***********   POUR :      NE PAS AFFICHER LES Répétitifs ;
mysql> SELECT DISTINCT AuthorID FROM AuthorsTBL;

**        SI :    On met deux collumn, il va afficher aussi les répétitifs
mysql> SELECT DISTINCT AuthorID, BookName FROM BooksTBL;
mysql> SELECT DISTINCT BookIsAvailable, BookName FROM BooksTBL;


*******     COUNT :
***********     POUR :    Compter les nombre des entités :
mysql> SELECT COUNT(DISTINC BookName) FROM BooksTBL;


*******   WHERE :
***********     POUR :    Préciser la condition du résultat de la recherche :
mysql> SELECT * FROM BooksTBL WHERE AuthorID=1;
mysql> SELECT * FROM BooksTBL WHERE BookID BETWEEN 2 AND 5;


*******   AND  / OR  / NOT
************      POUR :
                          On peut combiner "WHERE" avec les opérateurs logique comme AND  / OR  / NOT, pour pouvoir préciser le résultat de la recherche.

                          AND / OR :
                                    Pour Filtrer des enregistrements précisant plusieurs conditions (Plus q'une Condition).
                                    AND   -->   Afficher le résultat, si toutes les conditions sont accordées.
                                    OR    -->   Afficher  chaqu'unes des conditins accordées :
                                    NOT   -->   Afficher toutes les résultats contraires de la (des) condition(s) précisée(s).
.
mysql> SELECT * FROM BooksTBL WHERE NOT BookName='DP-TSRIT';
mysql> SELECT * FROM BooksTBL WHERE BookPrice='25.99' OR BookName='THIS IS LINUX' OR (NOT BookName='DP-TSRIT');
mysql> SELECT * FROM BooksTBL WHERE BookPrice='25.99' OR (NOT BookName='THIS IS LINUX' AND BookName='DP-TSRIT');
mysql> SELECT * FROM BooksTBL WHERE NOT BookName='Dp-TSRIT' OR (NOT BookName='THIS IS LINUX' AND BookName='DP-TSRIT');


*******     ORDER :
                POUR :
                      Utilisé pour ranger le résultat de la recherche par l'ordre donné (Numériquer   /    Alphabétique) :
                      On peut ranger le résultat avec plusieur ordres.
.
mysql> SELECT * FROM BooksTBL WHERE NOT BookName='Dp-TSRIT' OR (NOT BookName='THIS IS LINUX' AND BookName='DP-TSRIT') ORDER BY BookName;
mysql> SELECT * FROM BooksTBL WHERE BookPrice='25.99' OR (NOT BookName='THIS IS LINUX' AND BookName='DP-TSRIT') ORDER BY BookName;
mysql> SELECT * FROM BooksTBL WHERE BookPrice='25.99' OR (NOT BookName='THIS IS LINUX' AND BookName='DP-TSRIT') ORDER BY BookName ASC, BookIsAvailable DESC;
                                                                                                                                  ASC   --> Montatnt
                                                                                                                                  DESC  --> Descendant
mysql> SELECT * FROM BooksTBL WHERE BookPrice='25.99' OR (NOT BookName='THIS IS LINUX' AND BookName='DP-TSRIT') ORDER BY BookIsAvailable ASC, BookName DESC;
mysql> SELECT * FROM BooksTBL WHERE BookPrice='25.99' OR (NOT BookName='THIS IS LINUX' AND BookName='DP-TSRIT') ORDER BY BookIsAvailable DESC, BookName ASC;
.

*******     INSERT :
                  POUR :
                          Ajouter les contnus aux tables de la base de données.
.

*****     VALEUR "NULL" :
                  POUR :
                        Veut dire ce champ-là n'a aucune valeur, On l'utilise pour les champs optionnels.
                        Valeur NULL n'est pas pareil que la valeur 0 ou la valeur " " (Espace);

                        Pour Filtrer les résultas de la recherche, pour les champs avec les valeur "NULL" :
                            On ne oeut pas utilier les opérateur logiques comme  < >   <>    =   >=    <=
                            Pour ça on va utiliser les opérateurs :
                                                                    IS NULL
                                                                    IS NOT NULL
              ######### TIP :
                              Clé Etrangère :
                                              Quand on Ajoute les données à la table, si on ne précise pas une valeur pour la clé etrangère, comme on l'a déclarée "NOT NULL",
                                              Elle prendra la valeur "0".
.
mysql> INSERT INTO BooksTBL (BookName, BookPrice, BookIsAvailable)
VALUES ('SAM-BOOK', 25.60, 1);

mysql> INSERT INTO BooksTBL (BookName, BookPrice, BookIsAvailable)
VALUES ('SAM-BOOK-1', 25.60, 1);

mysql> INSERT INTO BooksTBL (BookName, AuthorID, BookPrice)
VALUES ('SAM-LIVRE', 3, 10.00);

mysql> INSERT INTO BooksTBL (BookName, AuthorID, BookPrice)
VALUES ('SAM-LIVRE-1', 3, 10.00);
.
                              SELECT * FROM BooksTBL;
+--------+-----------------+----------+-----------+---------------------+-----------------+
| BookID | BookName        | AuthorID | BookPrice | BookLastUpdated     | BookIsAvailable |
+--------+-----------------+----------+-----------+---------------------+-----------------+
|      1 | THIS IS SD      |        1 |     29.99 | 2017-12-05 02:24:00 |               1 |
|      2 | THIS IS LINUX   |        1 |     39.99 | 2017-12-05 02:24:00 |               1 |
|      3 | THIS IS LINUX-2 |        1 |     39.99 | 2017-12-05 02:24:00 |               1 |
|      4 | LA Cuisine      |        2 |     25.99 | 2017-12-05 02:24:00 |               0 |
|      5 | Les fleures     |        2 |     20.99 | 2017-12-05 02:24:00 |               1 |
|      6 | le Vélo        |        3 |     15.99 | 2017-12-06 00:12:19 |               1 |
|      7 | DP-TSRIT        |        3 |     21.99 | 2017-12-05 17:26:47 |               0 |
|      8 | DP-TSRIT        |        2 |     21.99 | 2017-12-07 00:45:57 |               1 |
|      9 | Les Fleurs      |        2 |     25.99 | 2017-12-07 00:45:57 |               0 |
|     10 | La Cuisine      |        3 |     20.99 | 2017-12-07 00:45:57 |               0 |
|     11 | SAM-BOOK        |        0 |     25.60 | 2017-12-10 01:27:05 |               1 |
|     12 | SAM-BOOK-1      |        0 |     25.60 | 2017-12-10 01:27:12 |               1 |
|     13 | SAM-LIVRE       |        3 |     10.00 | 2017-12-10 01:27:28 |            NULL |
|     14 | SAM-LIVRE-1     |        3 |     10.00 | 2017-12-10 01:27:35 |            NULL |
+--------+-----------------+----------+-----------+---------------------+-----------------+

mysql> SELECT * FROM BooksTBL BookIsAvailable IS NULL OR AuthorID='0';
mysql> SELECT * FROM BooksTBL BookIsAvailable IS NULL OR AuthorID<>'0';



*******   UPDATE :
                POUR :
                      Mettre à jour une (des) valeur(s) dans une table.

              TIP :
            ********    Si on ne déclare pas les conditions avec "WHERE", la commande va changer le column entier   *********
.
mysql> UPDATE BooksTBL SET AuthorID='1' WHERE BookName='SAM-BOOK';
mysql> UPDATE BooksTBL SET AuthorID='1' WHERE BookName='SAM-BOOK' AND BookID='11';
mysql> UPDATE BooksTBL SET BookPrice='20.00', AuthorID='1' WHERE BookName='SAM-BOOK';


*********     DELETE :
                    POUR :
                          Permettant de Supprimer
                              TABLE
                              Enregistrement

mysql> DELETE FROM BooksTBL WHERE BookName='DP-TSRIT' AND BookIsAvailable='0';

####    Pour Supprimer tous les enregistrements d'une table :
mysql> DELETET * FROM <Nom_De_La_Table>
mysql> DELETET FROM <Nom_De_La_Table>

mysql> DELETET * FROM AuthorsTBL;
mysql> DELETET FROM AuthorsTBL;




********    LIMIT (MYSQL)
                POUR :
                      Utilisé pour limiter le nombre de résultats,
                      Par Example :       Afficher les 6 Premier enregistrements d'une Table qui portent des conditions :

mysql> SELECT * FROM BooksTBL WHERE AuthorID='1' LIMIT 2;


pour la même chose chez "ORACLE", "SQL" et "MS Access" il y des commandes différentes :

ORACLE> SELECT * FROM BooksTBL WHERER AuthorID='1' ROWNUM<=2;

SQL> SELECT TO 50 PERCENT * FROM BooksTBL WHERE AuthorID='1';
***********************************************************************



*******   MIN() / MAX() :
                  POUR :
                          MIN() :   Afficher la Valeur la plus inférieur conercreée à la requête.
                          MAX() :   Afficher la Valeur la plus Supérieur conercreée à la requête.
.
mysql> SELECT MAX(BookPrice) AS MAX_Prix FROM BooksTBL;
mysql> SELECT MIN(BookPrice) AS MIN_Prix FROM BooksTBL;
mysql> SELECT MAX(BookName) AS Dernier_Livre FROM BooksTBL;
mysql> SELECT MIN(BookName) AS Premier_Livre FROM BooksTBL;
.



*******     COUNT()   /   AVG()   /   SUM() :
                        POUR :
                              COUNT() :     Afficher le nombres des enregistrements concernés aux conditions de la requête :           -->   Pour les Culonnes Numériques.
                              AVG() :       Afficher le Moyen des enregistrements concernés aux condistions de la requête :            -->   Pour les Culonnes Numériques.
                              SUM() :       Afficher l'addition des valueurs des collones concernés aux conditions de la requêtes :    -->   Pour les Culonnes Numériques.

.
mysql> SELECT COUNT(BookID) FROM BooksTBL;
mysql> SELECT AVG(BookID) FROM BooksTBL;
mysql> SELECT SUM
mysql>





https://www.w3schools.com/sql/sql_count_avg_sum.asp


mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>
mysql>




Quelques Commandes importates et plus utilisées

SELECT - extracts data from a database
UPDATE - updates data in a database
DELETE - deletes data from a database
INSERT INTO - inserts new data into a database
CREATE DATABASE - creates a new database
ALTER DATABASE - modifies a database
CREATE TABLE - creates a new table
ALTER TABLE - modifies a table
DROP TABLE - deletes a table
CREATE INDEX - creates an index (search key)
DROP INDEX - deletes an index
******************************************************************************************************************************************************

SELECT CustomerID, Country FROM [Customers]
SELECT SupplierName, Address, Phone FROM Suppliers;

SELECT DISTINCT column1, column2, ...
FROM table_name;
