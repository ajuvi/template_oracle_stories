-- eliminar les taules

DROP TABLE usuari CASCADE CONSTRAINTS;
DROP TABLE missatge CASCADE CONSTRAINTS;
DROP TABLE usuari_missatge CASCADE CONSTRAINTS;
DROP TABLE seguits CASCADE CONSTRAINTS;
DROP TABLE bloquejats CASCADE CONSTRAINTS;

-- crear les taules

CREATE TABLE usuari(
	id NUMBER(11),
	email VARCHAR2(50) NOT NULL UNIQUE,
	contrasenya VARCHAR2(50) NOT NULL,
	pais VARCHAR2(25),
	dataNaix DATE,
	dataAlta DATE DEFAULT SYSDATE,
	actiu NUMBER(1) DEFAULT 1,
	
	CONSTRAINT pk_usuari 
PRIMARY KEY(id),
CONSTRAINT ck_actiu
	CHECK(actiu IN (0,1))
);

CREATE TABLE missatge(
	id NUMBER(11),
	contingut VARCHAR2(100),
	estat NUMBER(1),
	usuari_id NUMBER(11),
	
	CONSTRAINT pk_missatge
		PRIMARY KEY(id),
	CONSTRAINT fk_missatge_usuari_id
		FOREIGN KEY(usuari_id)
		REFERENCES usuari(id)

);

CREATE TABLE usuari_missatge(
	usuari_id NUMBER(11),
	missatge_id NUMBER(11),
	emoticon VARCHAR2(10),

	CONSTRAINT pk_usuari_missatge
		PRIMARY KEY(usuari_id,missatge_id),
	CONSTRAINT fk_usuari_missatge_usuari_id
		FOREIGN KEY(usuari_id)
		REFERENCES usuari(id),
	CONSTRAINT fk_usuari_missatge_missatge_id
		FOREIGN KEY(missatge_id)
		REFERENCES missatge(id)
);

CREATE TABLE seguits(
	u1 NUMBER(11),
	u2 NUMBER(11),

	CONSTRAINT pk_seguits
		PRIMARY KEY(u1,u2),
	CONSTRAINT fk_seguits_u1
		FOREIGN KEY(u1)
		REFERENCES usuari(id),
	CONSTRAINT fk_seguits_u2
		FOREIGN KEY(u2)
		REFERENCES usuari(id)
);

CREATE TABLE bloquejats(
	u1 NUMBER(11),
	u2 NUMBER(11),

	CONSTRAINT pk_bloquejats
		PRIMARY KEY(u1,u2),
	CONSTRAINT fk_bloquejats_u1
		FOREIGN KEY(u1)
		REFERENCES usuari(id),
	CONSTRAINT fk_bloquejats_u2
		FOREIGN KEY(u2)
		REFERENCES usuari(id)
);
