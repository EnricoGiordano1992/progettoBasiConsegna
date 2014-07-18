DROP TABLE SPEC_DEL_MEDICO;
DROP TABLE SPECIALIZZAZIONI;
DROP TABLE CONTRADDIZIONI;
DROP TABLE CONFERME;
DROP TABLE DIAGNOSI;
DROP TABLE MEDICO;
DROP TABLE SINTOMI;
DROP TABLE RISCHI_PAZIENTE;
DROP TABLE FATTORI_RISCHIO;
DROP TABLE TERAPIE;
DROP TABLE CARTELLA_CLINICA;
DROP TABLE PAZIENTE;

drop function controlla_data (date, varchar(30));
drop function controlla_data_cartella ( DATE, VARCHAR(30) );
drop function controlla_data_cartella_ricoverodimissioni ( DATE, DATE );
drop function controlla_data_terapie ( DATE, DATE, VARCHAR(30) );
drop function controlla_sovrapposizione_cartelle ( VARCHAR(30), DATE, DATE );

----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
-------------------------------------              PAZIENTE             ----------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE PAZIENTE (

    CODSAN              VARCHAR(30)     NOT NULL,
    NOME                VARCHAR(30)     NOT NULL,
    COGNOME             VARCHAR(30)     NOT NULL,
    NASCITA				DATE            NOT NULL,
    PSW                 VARCHAR(30)     NOT NULL,
    CITTA               VARCHAR(60)     NOT NULL,
    VIA                 VARCHAR(30)     NOT NULL,
    PROV                VARCHAR(30)     NOT NULL,
    CAP                 INT             NOT NULL,
    -- varchar per gestire i civici tipo 10/b
    CIVICO              VARCHAR(10)     NOT NULL,
    
    PRIMARY KEY(CODSAN)
);





----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
-------------------------------------        CARTELLA CLINICA           ----------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE CARTELLA_CLINICA (

    ID                  VARCHAR(30)     NOT NULL,
    DATA_RICOVERO       DATE            NOT NULL,
    DATA_DIMISSIONE     DATE            	,
    MOTIVO              VARCHAR(200)     NOT NULL,
    PROGNOSI            VARCHAR(200)             ,
    CODSAN              VARCHAR(30)     REFERENCES PAZIENTE(CODSAN) ON DELETE CASCADE ON UPDATE CASCADE,

    PRIMARY KEY(ID)
);


CREATE FUNCTION controlla_sovrapposizione_cartelle ( id_paz VARCHAR(30), data_in DATE, data_fin DATE )
RETURNS VARCHAR(5)
AS
$BODY$
BEGIN
	--controllo che ci sia almeno una cartella clinica
	IF EXISTS ( select id from cartella_clinica) then
		IF EXISTS (select id from cartella_clinica as c where codsan = id_paz and data_in < data_dimissione ) then
	    		return 'True';
	    	end IF; 
	end if;
	
	    return 'False';
    
END;$BODY$ LANGUAGE 'plpgsql';

ALTER TABLE CARTELLA_CLINICA ADD CONSTRAINT check_sovrapposizione CHECK (controlla_sovrapposizione_cartelle(CODSAN, DATA_RICOVERO, DATA_DIMISSIONE) = 'False');



CREATE FUNCTION controlla_data_cartella ( data_c DATE, codsan_q VARCHAR(30) )
RETURNS VARCHAR(5)
AS
$BODY$
BEGIN
	IF EXISTS (select nascita from paziente as p where p.codsan = codsan_q and p.nascita <= data_c ) then
	    return 'True';
	    end IF; 
	    return 'False';
    
END;$BODY$ LANGUAGE 'plpgsql';


CREATE FUNCTION controlla_data_cartella_ricoverodimissioni (data_r DATE, data_d DATE )
RETURNS VARCHAR(5)
AS
$BODY$
BEGIN
	IF data_d <> null then
		IF data_r < data_d then

	    		return 'True';
	    	else
	    		return 'False';
	    	end IF;
	else 
	    	return 'True';
	    	
    	end IF;

    
END;$BODY$ LANGUAGE 'plpgsql';


ALTER TABLE CARTELLA_CLINICA ADD CONSTRAINT check_dataRicovero CHECK (controlla_data_cartella(DATA_RICOVERO, CODSAN) = 'True');
ALTER TABLE CARTELLA_CLINICA ADD CONSTRAINT check_ricoverodimissioni CHECK (controlla_data_cartella_ricoverodimissioni(DATA_RICOVERO, DATA_DIMISSIONE) = 'True');

----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
-------------------------------------             TERAPIE               ----------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE TERAPIE (

    ID_CARTELLA         VARCHAR(30)     NOT NULL,
    INIZIO              DATE            NOT NULL,
    FINE                DATE            NOT NULL,
    FREQUENZA           INT             NOT NULL,
    DOSE                FLOAT(5)        NOT NULL,
    FARMACO             VARCHAR(100)     NOT NULL,
    
    FOREIGN KEY(ID_CARTELLA) REFERENCES CARTELLA_CLINICA(ID) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE FUNCTION controlla_data_terapie ( data_ter_in DATE, data_ter_fin DATE, id_cartella VARCHAR(30) )
RETURNS VARCHAR(5)
AS
$BODY$
BEGIN
	--se esiste la data dimissione la controllo dopo
	IF EXISTS (select data_dimissione from cartella_clinica as c where c.id = id_cartella ) then
	    IF EXISTS (select data_ricovero from cartella_clinica as c where c.id = id_cartella and c.data_ricovero <= data_ter_in and c.data_dimissione >= data_ter_fin ) then
	    return 'True';
	    end IF; 
	    return 'False';
    else
	    IF EXISTS (select data_ricovero from cartella_clinica as c where c.id = id_cartella and c.data_ricovero <= data_ter_in ) then
	    return 'True';
	    end IF; 
	    return 'False';
		    	
    end IF;
    
END;$BODY$ LANGUAGE 'plpgsql';


ALTER TABLE TERAPIE ADD CONSTRAINT check_data_terapie CHECK (controlla_data_terapie(INIZIO, FINE, ID_CARTELLA) = 'True');
ALTER TABLE TERAPIE ADD CONSTRAINT check_data_inizi_fine_terapie CHECK (INIZIO <= FINE);



----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
-------------------------------------        FATTORI_RISCHIO            ----------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE FATTORI_RISCHIO (

    NOME                VARCHAR(100)     PRIMARY KEY

);



----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
-------------------------------------        RISCHI_PAZIENTE            ----------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE RISCHI_PAZIENTE (

    ID_PAZIENTE         VARCHAR(30)     NOT NULL,
    NOME_FATTORE        VARCHAR(100)     NOT NULL, 

    FOREIGN KEY(ID_PAZIENTE) REFERENCES PAZIENTE(CODSAN) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(NOME_FATTORE) REFERENCES FATTORI_RISCHIO(NOME) ON DELETE CASCADE ON UPDATE CASCADE
);



----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
-------------------------------------             SINTOMI               ----------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE SINTOMI (

    ID_CARTELLA         VARCHAR(30)     REFERENCES CARTELLA_CLINICA(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    NOME                VARCHAR(200)     NOT NULL,
    INTENSITA           VARCHAR(10)     NOT NULL,
    DATA		DATE		NOT NULL,
    DURATA		INT		,


    PRIMARY KEY         (NOME, ID_CARTELLA),
    CHECK(INTENSITA IN  ('bassa', 'media', 'alta'))

);



----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
-------------------------------------             MEDICO                ----------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE MEDICO (

    ID                  VARCHAR(30)     NOT NULL,
    NOME                VARCHAR(30)     NOT NULL,
    COGNOME             VARCHAR(30)     NOT NULL,
    PRIMARIO            VARCHAR(2)     NOT NULL,
    PSW                 VARCHAR(30)     NOT NULL,
    INIZIO_ATTIVITA     DATE            NOT NULL,

    PRIMARY KEY(ID)
);



----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
-------------------------------------            DIAGNOSI               ----------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE DIAGNOSI (

    ID_PAZIENTE         VARCHAR(30)     REFERENCES PAZIENTE(CODSAN) ON DELETE CASCADE ON UPDATE CASCADE,
    ID_CARTELLA         VARCHAR(30)     REFERENCES CARTELLA_CLINICA(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    DATA                DATE            NOT NULL,
    ICD10               VARCHAR(30)     NOT NULL,
    PATOLOGIA           VARCHAR(200)     NOT NULL,
    ID_MEDICO           VARCHAR(30)     REFERENCES MEDICO(ID) ON DELETE CASCADE ON UPDATE CASCADE,

    PRIMARY KEY (ID_PAZIENTE, DATA, ID_CARTELLA, ID_MEDICO)

    
);

CREATE FUNCTION controlla_data ( data_c DATE, id_cartella VARCHAR(30) )
RETURNS VARCHAR(5)
AS
$BODY$
BEGIN
	--se esiste la data dimissione la controllo dopo
	IF EXISTS (select data_dimissione from cartella_clinica as c where c.id = id_cartella ) then
	    IF EXISTS (select data_ricovero from cartella_clinica as c where c.id = id_cartella and c.data_ricovero <= data_c and c.data_dimissione >= data_c ) then
	    return 'True';
	    end IF; 
	    return 'False';
    else
	    IF EXISTS (select data_ricovero from cartella_clinica as c where c.id = id_cartella and c.data_ricovero < data_c ) then
	    return 'True';
	    end IF; 
	    return 'False';
		    	
    end IF;
    
END;$BODY$ LANGUAGE 'plpgsql';


ALTER TABLE DIAGNOSI ADD CONSTRAINT check_data CHECK (controlla_data(DATA, ID_CARTELLA) = 'True');

----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
-------------------------------------            CONFERME               ----------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE CONFERME (

    ID_SINTOMO          VARCHAR(30)     NOT NULL,
    N_SINT              VARCHAR(200)     NOT NULL,
    ID_PAZIENTE         VARCHAR(30)     NOT NULL,
    DATA                DATE            NOT NULL,
    ID_CARTELLA         VARCHAR(30)     NOT NULL,
    ID_MEDICO		VARCHAR(30)	NOT NULL,

    FOREIGN KEY(ID_SINTOMO, N_SINT) REFERENCES SINTOMI(ID_CARTELLA, NOME) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(ID_PAZIENTE, DATA, ID_CARTELLA, ID_MEDICO) REFERENCES DIAGNOSI(ID_PAZIENTE, DATA, ID_CARTELLA, ID_MEDICO) ON DELETE CASCADE ON UPDATE CASCADE

);




----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
-------------------------------------          CONTRADDIZIONI           ----------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE CONTRADDIZIONI (

    ID_SINTOMO          VARCHAR(30)     NOT NULL,
    N_SINT              VARCHAR(200)     NOT NULL,
    ID_PAZIENTE         VARCHAR(30)     NOT NULL,
    DATA                DATE            NOT NULL,
    ID_CARTELLA         VARCHAR(30)     NOT NULL,
    ID_MEDICO		VARCHAR(30)	NOT NULL,

    FOREIGN KEY(ID_SINTOMO, N_SINT) REFERENCES SINTOMI(ID_CARTELLA, NOME) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(ID_PAZIENTE, DATA, ID_CARTELLA, ID_MEDICO) REFERENCES DIAGNOSI(ID_PAZIENTE, DATA, ID_CARTELLA, ID_MEDICO) ON DELETE CASCADE ON UPDATE CASCADE

);


----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
-------------------------------------         SPECIALIZZAZIONI          ----------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE SPECIALIZZAZIONI (

    NOME                VARCHAR(30)     PRIMARY KEY   

);



----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
-------------------------------------          SPEC_DEL_MEDICO          ----------------------------------------------------------------
-------------------------------------                                   ----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE SPEC_DEL_MEDICO (

    ID_MEDICO               VARCHAR(30)     NOT NULL,
    NOME_SPECIALIZZAZIONE   VARCHAR(30)     NOT NULL,

    FOREIGN KEY(ID_MEDICO) REFERENCES MEDICO(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(NOME_SPECIALIZZAZIONE) REFERENCES SPECIALIZZAZIONI(NOME) ON DELETE CASCADE ON UPDATE CASCADE
);
