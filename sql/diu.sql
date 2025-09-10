-- INSERT
-- cameras insert
INSERT INTO cameras (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK) VALUES
                                                                  ('img/minolta-srt-101.png', 'SLR', 'Minolta SRT 101', 180.00, 0),
                                                                  ('img/minolta-xe1.png', 'SLR', 'Minolta XE1', 180.00, 0),
                                                                  ('img/canon-ae-1.png', 'SLR', 'Canon AE1', 200.00, 0),
                                                                  ('img/canon-av-1.png', 'SLR', 'Canon AV1', 150.00, 0),
                                                                  ('img/yashica-tl-electro-x.png', 'SLR', 'Yashica TL Electro X', 130.00, 0),
                                                                  ('img/yashica-electro35-gsn.png', 'Rangefinder', 'Yashica Electro 35 GSN', 125.00, 0),
                                                                  ('img/olympus-xa2.png', 'Point & Shoot', 'Olympus XA2', 80.00, 0),
                                                                  ('img/pentax-67.png', 'Medium Format', 'Pentax 67', 750.00, 0),
                                                                  ('img/polaroid-supercolor1000.png', 'Instant Camera', 'Polaroid Supercolor 1000', 75.00, 0),
                                                                  ('img/fujifilm-finepix-jv100.png', 'Digital Camera', 'Fujifilm FinePix JV100', 69.00, 0);

-- lenses insert
INSERT INTO lenses (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK) VALUES
                                                                           ('img/minolta-md-rokkor-28mm-f28.png', 'Wide', '28mm f2.8', 'Minolta MD Rokkor', 90.00, 0),
                                                                           ('img/minolta-md-rokkor-50mm-f14.png', 'Standard', '50mm f1.4', 'Minolta MD Rokkor', 100.00, 0),
                                                                           ('img/canon-ef-28-105mm-f35-45.png', 'Wide / Standard / Telephoto', '28-105mm f3.5-4.5', 'Canon EF Ultrasonic', 120.00, 0),
                                                                           ('img/canon-ef-50mm-f18.png', 'Standard', '50mm f1.8', 'Canon EF', 125.00, 0),
                                                                           ('img/nikon-nikkor-43-86mm-f35.png', 'Standard / Telephoto', '43-86mm f3.5', 'Nikon NIKKOR', 150.00, 0),
                                                                           ('img/revuenon-auto-mc-135mm-f28.png', 'Telephoto', '135mm f2.8', 'Revuenon Auto MC', 150.00, 0),
                                                                           ('img/minolta-md-135mm-f35.png', 'Telephoto', '135mm f3.5', 'Minolta MD Tele Rokkor', 110.00, 0),
                                                                           ('img/pentax-smc-50mm-f14.png', 'Standard', '50mm f1.4', 'Pentax SMC 50mm', 130.00, 0),
                                                                           ('img/olympus-zuiko-28mm-f35.png', 'Wide', '28mm f3.5', 'Olympus Zuiko Wide', 95.00, 0),
                                                                           ('img/yashica-50mm-f18.png', 'Standard', '50mm f1.8', 'Yashica ML 50mm', 85.00, 0);

-- equipment insert
INSERT INTO equipment (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK) VALUES
                                                                    ('img/vivitar283.png', 'Bjeskalica', 'Vivitar 283', 50.00, 0),
                                                                    ('img/vivitar285.png', 'Bjeskalica', 'Vivitar 285', 70.00, 0),
                                                                    ('img/cullmann-alpha-stativ.png', 'Stativ', 'Cullmann Alpha 1800', 40.00, 0),
                                                                    ('img/shutter-release-cable.png', 'Okidac', 'Okidac za fotoaparat 1m', 10.00, 0),
                                                                    ('img/lomography-scanner.png', 'Skener', 'Lomography skener za 35mm film', 40.00, 0),
                                                                    ('img/yongnuo-yn560iii.png', 'Bjeskalica', 'Yongnuo YN560III', 60.00, 0),
                                                                    ('img/manfrotto-tripod.png', 'Stativ', 'Manfrotto Compact Tripod', 85.00, 0),
                                                                    ('img/hoya-uv-filter.png', 'Filter', 'Hoya UV Filter 52mm', 18.00, 0),
                                                                    ('img/paterson-tank.png', 'Razvijac', 'Paterson Developing Tank', 35.00, 0),
                                                                    ('img/energizer-aa-battery.png', 'Baterija', 'Energizer AA 4-pack', 7.00, 0);

-- films insert
INSERT INTO films (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK) VALUES
                                                                ('img/kodak-gold-200-36-exp.png', '35mm', 'Kodak Gold 200', 15.00, 0),
                                                                ('img/agfa-apx-100-36-exp.png', '35mm', 'Agfa APX 100', 12.00, 0),
                                                                ('img/candido400.png', '35mm', 'Candido 400', 17.00, 0),
                                                                ('img/candido800.png', '35mm', 'Candido 800', 20.00, 0),
                                                                ('img/wolfen-nc500.png', '35mm', 'Wolfen NC 500', 25.00, 0),
                                                                ('img/ilford-hp5.png', '35mm', 'Ilford HP5 Plus 400', 16.00, 0),
                                                                ('img/fujifilm-superia.png', '35mm', 'Fujifilm Superia X-TRA 400', 14.00, 0),
                                                                ('img/kodak-portra.png', '120mm', 'Kodak Portra 160', 22.00, 0),
                                                                ('img/ilford-delta.png', '120mm', 'Ilford Delta 3200', 24.00, 0),
                                                                ('img/polaroid-color600.png', 'Instant Film', 'Polaroid Color 600', 30.00, 0);

-- UPDATE
-- cameras
UPDATE cameras SET STOCK = 25 WHERE CATEGORY = 'SLR';
UPDATE cameras SET STOCK = 3 WHERE CATEGORY = 'Rangefinder';
UPDATE cameras SET STOCK = 6 WHERE CATEGORY = 'Point & Shoot';
UPDATE cameras SET STOCK = 2 WHERE CATEGORY = 'Medium Format';
UPDATE cameras SET STOCK = 3 WHERE CATEGORY = 'Instant Camera';
UPDATE cameras SET STOCK = 6 WHERE CATEGORY = 'Digital Camera';
UPDATE cameras SET STOCK = 1 WHERE CATEGORY = 'Medium Format';
UPDATE cameras SET PRICE = 185.00 WHERE NAME = 'Minolta SRT 101';
UPDATE cameras SET STOCK = 8 WHERE NAME = 'Canon AV1';
UPDATE cameras SET PRICE = 135.00 WHERE CATEGORY = 'Rangefinder';

-- lenses
UPDATE lenses SET PRICE = 112.00, STOCK = 12 WHERE NAME = 'Minolta MD Rokkor' AND APERTURE = '28mm f2.8';
UPDATE lenses SET PRICE = 135.00, STOCK = 20 WHERE NAME = 'Minolta MD Rokkor' AND CATEGORY = 'Standard';
UPDATE lenses SET PRICE = 155.00, STOCK = 8 WHERE NAME = 'Canon EF Ultrasonic';
UPDATE lenses SET PRICE = 145.00, STOCK = 10 WHERE NAME = 'Canon EF' AND CATEGORY = 'Standard';
UPDATE lenses SET PRICE = 180.00, STOCK = 5 WHERE APERTURE = '43-86mm f3.5';
UPDATE lenses SET PRICE = 170.00, STOCK = 10 WHERE CATEGORY = 'Telephoto';
UPDATE lenses SET STOCK = 18 WHERE NAME = 'Pentax SMC 50mm';
UPDATE lenses SET PRICE = 120.00 WHERE CATEGORY = 'Wide';
UPDATE lenses SET STOCK = 9 WHERE NAME = 'Olympus Zuiko Wide';
UPDATE lenses SET STOCK = 7 WHERE NAME = 'Yashica ML 50mm';

-- equipment
UPDATE equipment SET STOCK = 20 WHERE CATEGORY = 'Bjeskalica';
UPDATE equipment SET STOCK = 10 WHERE NAME = 'Cullmann Alpha 1800';
UPDATE equipment SET STOCK = 35, PRICE = 65.00 WHERE PRICE = 40.00;
UPDATE equipment SET STOCK = 150, PRICE = 15.00 WHERE CATEGORY = 'Okidac';
UPDATE equipment SET STOCK = 12 WHERE NAME = 'Vivitar 285';
UPDATE equipment SET PRICE = 45.00 WHERE CATEGORY = 'Stativ';
UPDATE equipment SET STOCK = 3 WHERE NAME = 'Manfrotto Compact Tripod';
UPDATE equipment SET PRICE = 20.00 WHERE NAME = 'Hoya UV Filter 52mm';
UPDATE equipment SET PRICE = 38.00 WHERE NAME = 'Paterson Developing Tank';
UPDATE equipment SET STOCK = 30 WHERE CATEGORY = 'Baterija';

-- films
UPDATE films SET STOCK = 777 WHERE CATEGORY = '35mm';
UPDATE films SET STOCK = 27 WHERE CATEGORY = 'Instant Film';
UPDATE films SET STOCK = 271 WHERE STOCK = 777;
UPDATE films SET STOCK = 77, PRICE = 18.00 WHERE NAME LIKE '% APX 100';
UPDATE films SET STOCK = 170 WHERE NAME LIKE 'Candido%';
UPDATE films SET STOCK = 120 WHERE NAME = 'Wolfen NC 500' AND CATEGORY = '35mm';
UPDATE films SET STOCK = 15 WHERE NAME = 'Kodak Portra 160';
UPDATE films SET PRICE = 26.00 WHERE NAME = 'Wolfen NC 500';
UPDATE films SET STOCK = 19 WHERE NAME = 'Ilford HP5 Plus 400';
UPDATE films SET PRICE = 16.00 WHERE NAME = 'Fujifilm Superia X-TRA 400';

-- DELETE
-- cameras delete
DELETE FROM cameras WHERE NAME = 'Fujifilm FinePix JV100';
DELETE FROM cameras WHERE CATEGORY = 'Instant Camera';
DELETE FROM cameras WHERE PRICE < 100;
DELETE FROM cameras WHERE STOCK = 0 AND CATEGORY = 'Medium Format';
DELETE FROM cameras WHERE NAME = 'Canon AV1';
DELETE FROM cameras WHERE CATEGORY = 'Rangefinder';
DELETE FROM cameras WHERE NAME LIKE '%Minolta%';
DELETE FROM cameras WHERE STOCK = 1;
DELETE FROM cameras WHERE CATEGORY = 'Digital Camera';
DELETE FROM cameras WHERE NAME = 'Olympus XA2';

-- lenses delete
DELETE FROM lenses WHERE NAME = 'Revuenon Auto MC';
DELETE FROM lenses WHERE CATEGORY = 'Telephoto';
DELETE FROM lenses WHERE STOCK = 0;
DELETE FROM lenses WHERE PRICE > 140;
DELETE FROM lenses WHERE NAME = 'Canon EF';
DELETE FROM lenses WHERE APERTURE = '28mm f2.8';
DELETE FROM lenses WHERE CATEGORY = 'Wide';
DELETE FROM lenses WHERE NAME LIKE '%NIKKOR%';
DELETE FROM lenses WHERE STOCK = 7;
DELETE FROM lenses WHERE NAME = 'Olympus Zuiko Wide';

-- equipment delete
DELETE FROM equipment WHERE NAME = 'Vivitar 283';
DELETE FROM equipment WHERE CATEGORY = 'Okidac';
DELETE FROM equipment WHERE PRICE < 20;
DELETE FROM equipment WHERE STOCK = 0 AND CATEGORY = 'Razvijac';
DELETE FROM equipment WHERE NAME = 'Manfrotto Compact Tripod';
DELETE FROM equipment WHERE NAME = 'Hoya UV Filter 52mm';
DELETE FROM equipment WHERE CATEGORY = 'Bjeskalica';
DELETE FROM equipment WHERE CATEGORY LIKE 'Baterija';
DELETE FROM equipment WHERE STOCK = 3;
DELETE FROM equipment WHERE NAME = 'Paterson Developing Tank';

-- films delete
DELETE FROM films WHERE NAME = 'Candido 400';
DELETE FROM films WHERE CATEGORY = 'Instant Film';
DELETE FROM films WHERE PRICE > 25;
DELETE FROM films WHERE STOCK = 0 AND CATEGORY = '35mm';
DELETE FROM films WHERE NAME = 'Wolfen NC 500';
DELETE FROM films WHERE NAME = 'Kodak Portra 160';
DELETE FROM films WHERE CATEGORY = '120mm';
DELETE FROM films WHERE NAME LIKE '%Ilford%';
DELETE FROM films WHERE STOCK = 19;
DELETE FROM films WHERE PRICE < 16.00;