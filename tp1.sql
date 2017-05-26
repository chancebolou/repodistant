/*******************************************************************/
/*                                                                 */
/* Script TP1                                                      */
/*                                                                 */
/* réalisé par O. Teste                                            */
/*                                                                 */
/*******************************************************************/

-- destruction des tables

DROP TABLE Parcelles;
DROP TABLE Bornes;

-- destruction des types
-- ordre inverse de création

DROP TYPE ty_parcelles FORCE;
DROP TYPE ty_nt_ref_bornes;
DROP TYPE ty_ref_bornes;
DROP TYPE ty_nt_ref_parcelles;
DROP TYPE ty_ref_parcelles;
DROP TYPE ty_bornes;
DROP TYPE ty_coordonnees;

-- création des types
-- pour chaque arbre "de bas en haut"
--   x --> AS OBJECT
--   * --> AS TABLE OF

CREATE TYPE ty_coordonnees AS OBJECT 
(
 lat NUMBER,
 lon NUMBER
)
/

CREATE TYPE ty_bornes AS OBJECT
(
 idb         VARCHAR(5),
 coordonnees ty_coordonnees
)
/

CREATE TYPE ty_parcelles
/

CREATE TYPE ty_ref_bornes AS OBJECT
(
 idb     VARCHAr(5),
 ref_idb REF ty_bornes,
 pos     NUMBER
)
/

CREATE TYPE ty_nt_ref_bornes AS TABLE OF ty_ref_bornes
/

CREATE TYPE ty_ref_parcelles AS OBJECT
(
 idp     VARCHAR(5),
 ref_idp REF ty_parcelles
)
/

CREATE TYPE ty_nt_ref_parcelles AS TABLE OF ty_ref_parcelles/

CREATE TYPE ty_parcelles AS OBJECT
(
 idp      VARCHAR(5),
 limiter  ty_nt_ref_bornes,
 typ      VARCHAR(5),
 composer ty_nt_ref_parcelles
)
/

-- création des tables 

CREATE TABLE Bornes    OF ty_bornes
(CONSTRAINT pk_bornes PRIMARY KEY (idb));

CREATE TABLE Parcelles OF ty_parcelles
(CONSTRAINT pk_parcelles PRIMARY KEY (idp))
NESTED TABLE limiter  STORE AS sp_limiter
NESTED TABLE composer STORE AS sp_composer;

-- insertion des objets (Bornes)

INSERT INTO Bornes VALUES (ty_bornes('B1',  ty_coordonnees(43.597798, 01.953889)));
INSERT INTO Bornes VALUES (ty_bornes('B2',  ty_coordonnees(43.599911, 01.955370)));
INSERT INTO Bornes VALUES (ty_bornes('B3',  ty_coordonnees(43.600175, 01.955692)));
INSERT INTO Bornes VALUES (ty_bornes('B4',  ty_coordonnees(43.600066, 01.955992)));
INSERT INTO Bornes VALUES (ty_bornes('B5',  ty_coordonnees(43.599694, 01.955713)));
INSERT INTO Bornes VALUES (ty_bornes('B6',  ty_coordonnees(43.599072, 01.957151)));
INSERT INTO Bornes VALUES (ty_bornes('B7',  ty_coordonnees(43.599025, 01.958267)));
INSERT INTO Bornes VALUES (ty_bornes('B8',  ty_coordonnees(43.597953, 01.957516)));
INSERT INTO Bornes VALUES (ty_bornes('B9',  ty_coordonnees(43.597875, 01.958052)));
INSERT INTO Bornes VALUES (ty_bornes('B10', ty_coordonnees(43.597285, 01.958546)));
INSERT INTO Bornes VALUES (ty_bornes('B11', ty_coordonnees(43.596151, 01.958117)));
INSERT INTO Bornes VALUES (ty_bornes('B12', ty_coordonnees(43.595809, 01.958846)));
INSERT INTO Bornes VALUES (ty_bornes('B13', ty_coordonnees(43.596182, 01.960091)));
INSERT INTO Bornes VALUES (ty_bornes('B14', ty_coordonnees(43.598124, 01.960241)));
INSERT INTO Bornes VALUES (ty_bornes('B15', ty_coordonnees(43.598295, 01.959533)));
INSERT INTO Bornes VALUES (ty_bornes('B16', ty_coordonnees(43.598171, 01.959082)));
INSERT INTO Bornes VALUES (ty_bornes('B17', ty_coordonnees(43.598311, 01.952280)));
INSERT INTO Bornes VALUES (ty_bornes('B18', ty_coordonnees(43.599818, 01.953353)));
INSERT INTO Bornes VALUES (ty_bornes('B19', ty_coordonnees(43.599538, 01.953997)));
INSERT INTO Bornes VALUES (ty_bornes('B20', ty_coordonnees(43.599849, 01.954297)));
INSERT INTO Bornes VALUES (ty_bornes('B21', ty_coordonnees(43.599616, 01.955048)));
COMMIT;

-- insertion des objets (Parcelles)

INSERT INTO Parcelles VALUES (
   ty_parcelles('PA1',
                ty_nt_ref_bornes(
                   ty_ref_bornes('B1', (SELECT REF(b) FROM Bornes b WHERE idb='B1'), 1),
                   ty_ref_bornes('B21',(SELECT REF(b) FROM Bornes b WHERE idb='B21'),2),
                   ty_ref_bornes('B2', (SELECT REF(b) FROM Bornes b WHERE idb='B2'), 3),
                   ty_ref_bornes('B3', (SELECT REF(b) FROM Bornes b WHERE idb='B3'), 4),
                   ty_ref_bornes('B4', (SELECT REF(b) FROM Bornes b WHERE idb='B4'), 5),
                   ty_ref_bornes('B5', (SELECT REF(b) FROM Bornes b WHERE idb='B5'), 6),
                   ty_ref_bornes('B6', (SELECT REF(b) FROM Bornes b WHERE idb='B6'), 7),
                   ty_ref_bornes('B7', (SELECT REF(b) FROM Bornes b WHERE idb='B7'), 8),
                   ty_ref_bornes('B8', (SELECT REF(b) FROM Bornes b WHERE idb='B8'), 9)),
                'AC',
                ty_nt_ref_parcelles()));
INSERT INTO Parcelles VALUES (
   ty_parcelles('PA2',
                ty_nt_ref_bornes(
                   ty_ref_bornes('B17',(SELECT REF(b) FROM Bornes b WHERE idb='B17'),1),
                   ty_ref_bornes('B18',(SELECT REF(b) FROM Bornes b WHERE idb='B18'),2),
                   ty_ref_bornes('B19',(SELECT REF(b) FROM Bornes b WHERE idb='B19'),3),
                   ty_ref_bornes('B20',(SELECT REF(b) FROM Bornes b WHERE idb='B20'),4),
                   ty_ref_bornes('B21',(SELECT REF(b) FROM Bornes b WHERE idb='B21'),5),
                   ty_ref_bornes('B1', (SELECT REF(b) FROM Bornes b WHERE idb='B1'), 6)),
                'AP',
                ty_nt_ref_parcelles()));
INSERT INTO Parcelles VALUES (
   ty_parcelles('PA3',
                ty_nt_ref_bornes(
                   ty_ref_bornes('B11',(SELECT REF(b) FROM Bornes b WHERE idb='B11'),1),
                   ty_ref_bornes('B10',(SELECT REF(b) FROM Bornes b WHERE idb='B10'),2),
                   ty_ref_bornes('B16',(SELECT REF(b) FROM Bornes b WHERE idb='B16'),3),
                   ty_ref_bornes('B15',(SELECT REF(b) FROM Bornes b WHERE idb='B15'),4),
                   ty_ref_bornes('B14',(SELECT REF(b) FROM Bornes b WHERE idb='B14'),5),
                   ty_ref_bornes('B13',(SELECT REF(b) FROM Bornes b WHERE idb='B13'),6),
                   ty_ref_bornes('B12',(SELECT REF(b) FROM Bornes b WHERE idb='B12'),7)),
                'AP',
                ty_nt_ref_parcelles()));
INSERT INTO Parcelles VALUES (
   ty_parcelles('PA4',
                ty_nt_ref_bornes(
                   ty_ref_bornes('B1', (SELECT REF(b) FROM Bornes b WHERE idb='B1'), 1),
                   ty_ref_bornes('B8', (SELECT REF(b) FROM Bornes b WHERE idb='B8'), 2),
                   ty_ref_bornes('B9', (SELECT REF(b) FROM Bornes b WHERE idb='B9'), 3),
                   ty_ref_bornes('B10',(SELECT REF(b) FROM Bornes b WHERE idb='B10'),4),
                   ty_ref_bornes('B11',(SELECT REF(b) FROM Bornes b WHERE idb='B11'),5)),
                'AC',
                ty_nt_ref_parcelles()));
COMMIT;

-- mises à jour des objets

-- fusion PA1/PA4
INSERT INTO Parcelles VALUES (
   ty_parcelles('PA5',
                ty_nt_ref_bornes(
                   ty_ref_bornes('B1', (SELECT REF(b) FROM Bornes b WHERE idb='B1'), 1),
                   ty_ref_bornes('B21',(SELECT REF(b) FROM Bornes b WHERE idb='B21'),2),
                   ty_ref_bornes('B2', (SELECT REF(b) FROM Bornes b WHERE idb='B2'), 3),
                   ty_ref_bornes('B3', (SELECT REF(b) FROM Bornes b WHERE idb='B3'), 4),
                   ty_ref_bornes('B4', (SELECT REF(b) FROM Bornes b WHERE idb='B4'), 5),
                   ty_ref_bornes('B5', (SELECT REF(b) FROM Bornes b WHERE idb='B5'), 6),
                   ty_ref_bornes('B6', (SELECT REF(b) FROM Bornes b WHERE idb='B6'), 7),
                   ty_ref_bornes('B7', (SELECT REF(b) FROM Bornes b WHERE idb='B7'), 8),
                   ty_ref_bornes('B8', (SELECT REF(b) FROM Bornes b WHERE idb='B8'), 9),
                   ty_ref_bornes('B9', (SELECT REF(b) FROM Bornes b WHERE idb='B9'), 10),
                   ty_ref_bornes('B10',(SELECT REF(b) FROM Bornes b WHERE idb='B10'),11),
                   ty_ref_bornes('B11',(SELECT REF(b) FROM Bornes b WHERE idb='B11'),12)),
                'AC',
                ty_nt_ref_parcelles(
                   ty_ref_parcelles('PA1',(SELECT REF(p) FROM Parcelles p WHERE idp='PA1')),
                   ty_ref_parcelles('PA4',(SELECT REF(p) FROM Parcelles p WHERE idp='PA4')))));

COMMIT;

-- division PA3
INSERT INTO Parcelles VALUES (
   ty_parcelles('PA8',
                ty_nt_ref_bornes(
                   ty_ref_bornes('B10',(SELECT REF(b) FROM Bornes b WHERE idb='B10'),1),
                   ty_ref_bornes('B16',(SELECT REF(b) FROM Bornes b WHERE idb='B16'),2),
                   ty_ref_bornes('B15',(SELECT REF(b) FROM Bornes b WHERE idb='B15'),3),
                   ty_ref_bornes('B14',(SELECT REF(b) FROM Bornes b WHERE idb='B14'),4),
                   ty_ref_bornes('B13',(SELECT REF(b) FROM Bornes b WHERE idb='B13'),5)),
                'AP',
                ty_nt_ref_parcelles()));

INSERT INTO Parcelles VALUES (
   ty_parcelles('PA9',
                ty_nt_ref_bornes(
                   ty_ref_bornes('B11',(SELECT REF(b) FROM Bornes b WHERE idb='B11'),1),
                   ty_ref_bornes('B10',(SELECT REF(b) FROM Bornes b WHERE idb='B10'),2),
                   ty_ref_bornes('B13',(SELECT REF(b) FROM Bornes b WHERE idb='B13'),3),
                   ty_ref_bornes('B12',(SELECT REF(b) FROM Bornes b WHERE idb='B12'),4)),
                'AP',
                ty_nt_ref_parcelles()));

INSERT INTO TABLE(SELECT p.composer FROM Parcelles p WHERE idp='PA3') VALUES (
   ty_ref_parcelles('PA8',(SELECT REF(p) FROM Parcelles p WHERE idp='PA8')));

INSERT INTO TABLE(SELECT p.composer FROM Parcelles p WHERE idp='PA3') VALUES (
   ty_ref_parcelles('PA9',(SELECT REF(p) FROM Parcelles p WHERE idp='PA9')));

COMMIT;

-- division PA5
INSERT INTO Bornes VALUES (ty_bornes('B22', ty_coordonnees(43.596718, 01.956917)));

INSERT INTO Parcelles VALUES (
   ty_parcelles('PA6',
                ty_nt_ref_bornes(
                   ty_ref_bornes('B1', (SELECT REF(b) FROM Bornes b WHERE idb='B1'), 1),
                   ty_ref_bornes('B21',(SELECT REF(b) FROM Bornes b WHERE idb='B21'),2),
                   ty_ref_bornes('B2', (SELECT REF(b) FROM Bornes b WHERE idb='B2'), 3),
                   ty_ref_bornes('B3', (SELECT REF(b) FROM Bornes b WHERE idb='B3'), 4),
                   ty_ref_bornes('B4', (SELECT REF(b) FROM Bornes b WHERE idb='B4'), 5),
                   ty_ref_bornes('B5', (SELECT REF(b) FROM Bornes b WHERE idb='B5'), 6),
                   ty_ref_bornes('B6', (SELECT REF(b) FROM Bornes b WHERE idb='B6'), 7),
                   ty_ref_bornes('B7', (SELECT REF(b) FROM Bornes b WHERE idb='B7'), 8),
                   ty_ref_bornes('B8', (SELECT REF(b) FROM Bornes b WHERE idb='B8'), 9),
                   ty_ref_bornes('B22',(SELECT REF(b) FROM Bornes b WHERE idb='B22'),10)),
                'AC',
                ty_nt_ref_parcelles()));

INSERT INTO Parcelles VALUES (
   ty_parcelles('PA7',
                ty_nt_ref_bornes(
                   ty_ref_bornes('B22',(SELECT REF(b) FROM Bornes b WHERE idb='B22'),1),
                   ty_ref_bornes('B8', (SELECT REF(b) FROM Bornes b WHERE idb='B8'), 2),
                   ty_ref_bornes('B9', (SELECT REF(b) FROM Bornes b WHERE idb='B9'), 3),
                   ty_ref_bornes('B10',(SELECT REF(b) FROM Bornes b WHERE idb='B10'),4),
                   ty_ref_bornes('B11',(SELECT REF(b) FROM Bornes b WHERE idb='B11'),5)),
                'AC',
                ty_nt_ref_parcelles()));

INSERT INTO TABLE(SELECT p.composer FROM Parcelles p WHERE idp='PA5') VALUES (
   ty_ref_parcelles('PA6',(SELECT REF(p) FROM Parcelles p WHERE idp='PA6')));

INSERT INTO TABLE(SELECT p.composer FROM Parcelles p WHERE idp='PA5') VALUES (
   ty_ref_parcelles('PA7',(SELECT REF(p) FROM Parcelles p WHERE idp='PA7')));

COMMIT;

-- modification de la BD objet

ALTER TYPE ty_bornes
ADD ATTRIBUTE delimiter ty_nt_ref_parcelles CASCADE
/

UPDATE Bornes b
SET delimiter = CAST(
                  MULTISET(SELECT p.idp, REF(p)
                           FROM Parcelles p, TABLE(p.limiter) l
                           WHERE l.ref_idb = REF(b)) AS ty_nt_ref_parcelles);

COMMIT;
