CREATE TYPE institution_type AS ENUM('gym','stadium','fitness', 'sports_complex', 'pool');

CREATE TABLE Users (
	user_id SERIAL PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	password VARCHAR(30) NOT NULL,
	contact_phone VARCHAR(13) UNIQUE,
	email VARCHAR(40) NOT NULL UNIQUE,
	CHECK(char_length(email) >= 6),
	CHECK(char_length(password) >= 6),
	CHECK(char_length(contact_phone) = 13)
);
CREATE INDEX user_id_index ON Users (user_id);

CREATE TABLE Institutions (
	institution_id SERIAL PRIMARY KEY,
	user_id INTEGER REFERENCES Users(user_id) NOT NULL,
	name TEXT NOT NULL,
	city TEXT NOT NULL,
	adress TEXT NOT NULL,
	type institution_type NOT NULL DEFAULT 'gym',
	work_shedule TEXT,
	hour_price INTEGER,
	day_price INTEGER,
	subscription_price INTEGER
);
CREATE INDEX institution_id_index ON Institutions (institution_id);
CREATE INDEX institutions_to_users_index ON Institutions (user_id);
CREATE INDEX institution_name_index ON Institutions (name);

CREATE TABLE  Ratings (
	rating_id SERIAL PRIMARY KEY,
	institution_id INTEGER REFERENCES Institutions(institution_id) NOT NULL,
	user_id INTEGER REFERENCES Users(user_id) NOT NULL,
	comment TEXT
);
CREATE INDEX rating_id_index ON Ratings (rating_id);
CREATE INDEX rating_to_users_index ON Ratings (user_id);
CREATE INDEX rating_to_institutions_index ON Ratings (institution_id);

INSERT INTO Users VALUES (DEFAULT, 'Олег', 'Гаврилюк', 'havryk568', 	'+380661578963', 'email1@gmail.com');
INSERT INTO Users VALUES (DEFAULT, 'Іван', 'Петруняк', 'ivan123', 	'+380666578963', 'email2@gmail.com');
INSERT INTO Users VALUES (DEFAULT, 'Петро', 'Коліщук', 'potrothebest', 	'+380662788357', 'email3@gmail.com');
INSERT INTO Users VALUES (DEFAULT, 'Василина', 'Гриців', '23151991', '+380661247791', 'email4@gmail.com');
INSERT INTO Users VALUES (DEFAULT, 'Ігор', 'Лотоцький', 'lotsik234', '+380666666666', 'email5@gmail.com');
INSERT INTO Users VALUES (DEFAULT, 'Андрій', 'Волошин', 'voloshkalol', '+380999999999', 'email6@gmail.com');
INSERT INTO Users VALUES (DEFAULT, 'Орест', 'Кавінський', 'deburbital', '+380668913061', 'email7@gmail.com');

INSERT INTO Institutions VALUES (DEFAULT, 1, 'Фітнес клуб "Леопардова корова"', 'м. Івано-Франківськ', 'вул. Будівельників, 32', 'fitness', 'ПН-ПТ: 12:00-18:00', NULL, NULL, 200);
INSERT INTO Institutions VALUES (DEFAULT, 2, 'Стадіон "Зоря"', 'м. Івано-Франківськ', 'вул. Василіянок, 25а', 'stadium', 'ПН-СБ: 08:00-22:00', 500, 3000, NULL);
INSERT INTO Institutions VALUES (DEFAULT, 3, 'Тренажерний зал "Ко-Ко-Ко"', 'м. Тернопіль', 'вул. Івасюка 666', 'gym', 'ПН-ПТ: 10:00-20:00', NULL, NULL, 400);

INSERT INTO Ratings VALUES (DEFAULT, 1, 4, 'Найкращий фітнес-клуб в місті');
INSERT INTO Ratings VALUES (DEFAULT, 1, 5, 'Відправив туди свою жінку, а вона не худне =(. Не рекомендую');
INSERT INTO Ratings VALUES (DEFAULT, 3, 7, 'Кудкудах-тах-тах, качалочка норм, але шкода, що вейп-шопу поруч нема');
INSERT INTO Ratings VALUES (DEFAULT, 2, 6, 'Непогано, краще місце для проведення змагань складно знайти');

