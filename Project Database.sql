CREATE TYPE institution_type AS ENUM('gym','stadium','fitness', 'sports_complex', 'pool');
CREATE TYPE account_permissions AS ENUM('admin','moderator', 'account');

CREATE TABLE account (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	password VARCHAR(30) NOT NULL,
	contact_phone VARCHAR(13) UNIQUE,
	email VARCHAR(40) NOT NULL UNIQUE,
	permissions account_permissions NOT NULL DEFAULT 'account',
	created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
	updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
	CHECK(char_length(email) >= 6),
	CHECK(char_length(password) >= 6),
	CHECK(char_length(contact_phone) = 13)
);
CREATE INDEX account_id_index ON account (id);
CREATE INDEX account_email_index ON account (email);
CREATE INDEX account_password_index ON account (password);

CREATE TABLE institution (
	id SERIAL PRIMARY KEY,
	account_id INTEGER REFERENCES account(id) NOT NULL,
	name TEXT NOT NULL,
	city TEXT NOT NULL,
	adress TEXT NOT NULL,
	type institution_type NOT NULL DEFAULT 'gym',
	work_shedule TEXT,
	hour_price INTEGER,
	day_price INTEGER,
	subscription_price INTEGER,
	created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
	updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);
CREATE INDEX institution_id_index ON institution (id);
CREATE INDEX institutions_to_accounts_index ON institution (id);
CREATE INDEX institution_name_index ON institution (name);

CREATE TABLE post (
	id SERIAL PRIMARY KEY,
	institution_id INTEGER REFERENCES institution (id) NOT NULL,
	account_id INTEGER REFERENCES account (id) NOT NULL,
	post TEXT NOT NULL,
	created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
	updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);
CREATE INDEX post_id_index ON post (id);
CREATE INDEX post_to_accounts_index ON post (account_id);
CREATE INDEX post_to_institutions_index ON post (institution_id);



CREATE TABLE  rating (
	id SERIAL PRIMARY KEY,
	institution_id INTEGER REFERENCES institution (id) NOT NULL,
	account_id INTEGER REFERENCES account (id) NOT NULL,
	comment TEXT,
	created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
	updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);
CREATE INDEX rating_id_index ON rating (id);
CREATE INDEX rating_to_accounts_index ON rating (account_id);
CREATE INDEX rating_to_institutions_index ON rating (institution_id);

INSERT INTO account VALUES (DEFAULT, 'Олег', 'Гаврилюк', 'havryk568', 	'+380661578963', 'email1@gmail.com');
INSERT INTO account VALUES (DEFAULT, 'Іван', 'Петруняк', 'ivan123', 	'+380666578963', 'email2@gmail.com');
INSERT INTO account VALUES (DEFAULT, 'Петро', 'Коліщук', 'potrothebest', 	'+380662788357', 'email3@gmail.com');
INSERT INTO account VALUES (DEFAULT, 'Василина', 'Гриців', '23151991', '+380661247791', 'email4@gmail.com');
INSERT INTO account VALUES (DEFAULT, 'Ігор', 'Лотоцький', 'lotsik234', '+380666666666', 'email5@gmail.com');
INSERT INTO account VALUES (DEFAULT, 'Андрій', 'Волошин', 'voloshkalol', '+380999999999', 'email6@gmail.com');
INSERT INTO account VALUES (DEFAULT, 'Орест', 'Кавінський', 'deburbital', '+380668913061', 'email7@gmail.com');

INSERT INTO institution VALUES (DEFAULT, 1, 'Фітнес клуб "Леопардова корова"', 'м. Івано-Франківськ', 'вул. Будівельників, 32', 'fitness', 'ПН-ПТ: 12:00-18:00', NULL, NULL, 200);
INSERT INTO institution VALUES (DEFAULT, 2, 'Стадіон "Зоря"', 'м. Івано-Франківськ', 'вул. Василіянок, 25а', 'stadium', 'ПН-СБ: 08:00-22:00', 500, 3000, NULL);
INSERT INTO institution VALUES (DEFAULT, 3, 'Тренажерний зал "Ко-Ко-Ко"', 'м. Тернопіль', 'вул. Івасюка 666', 'gym', 'ПН-ПТ: 10:00-20:00', NULL, NULL, 400);

INSERT INTO rating VALUES (DEFAULT, 1, 4, 'Найкращий фітнес-клуб в місті');
INSERT INTO rating VALUES (DEFAULT, 1, 5, 'Відправив туди свою жінку, а вона не худне =(. Не рекомендую');
INSERT INTO rating VALUES (DEFAULT, 3, 7, 'Кудкудах-тах-тах, качалочка норм, але шкода, що вейп-шопу поруч нема');
INSERT INTO rating VALUES (DEFAULT, 2, 6, 'Непогано, краще місце для проведення змагань складно знайти');

