CREATE SCHEMA IF NOT EXISTS dm;

-- Table: dm.dim_tempo

 DROP TABLE dm.dim_tempo;

CREATE TABLE IF NOT EXISTS dm.dim_tempo
(
  data_sk bigserial NOT NULL,
  int_ano smallint,
  int_mes smallint,
  int_dia smallint,
  int_cod_data double precision,
  int_dia_ano smallint,
  int_dia_semana smallint,
  str_dia_semana_abrev character varying(3),
  int_semana_ano smallint,
  str_nom_dia_semana character varying(30),
  str_nom_mes character varying(30),
  str_mes_abrev character varying(3),
  int_trimestre double precision,
  str_desc_trimestre character varying(2),
  str_ano_trimestre character varying(32),
  char_fim_semana character varying(1),
  str_qtd_dia_mes smallint,
  str_desc_dia text,
  int_cod_semana double precision,
  str_desc_semana character varying(32),
  int_semana_mes double precision,
  str_desc_semana_mes text,
  int_cod_mes double precision,
  int_cod_trimestre double precision,
  int_cod_ano double precision,
  str_desc_dia_semana character varying(60),
  str_data_folha_pagamento character varying(60),
  int_mes_folha_pagamento double precision,
  int_ano_folha_pagamento double precision,
  dt_data timestamp without time zone,
  str_mes_ano VARCHAR(20)
)
WITH (
  OIDS=FALSE
);



  
 -- Table: dm.dim_hora

 DROP TABLE dm.dim_hora;

CREATE TABLE IF NOT EXISTS dm.dim_hora
(
  hora_sk bigserial NOT NULL,
  int_cod_hora double precision,
  int_hora double precision,
  int_minuto double precision,
  str_hora_minuto text,
  str_turno_padrao character varying(255),
  str_turno_programacao character varying(255),
  CONSTRAINT dim_hora_pkey PRIMARY KEY (hora_sk)
)
WITH (
  OIDS=FALSE
);

-- Table: dm.dim_aeronave

 DROP TABLE dm.dim_aeronave;

CREATE TABLE dm.dim_aeronave
(
  aeronave_sk bigserial NOT NULL,
  codigo_aeronave bigint,
  codigo_ocorrencia bigint,
  matricula character varying(7),
  codigo_operador bigint,
  equipamento character varying(12),
  fabricante character varying(24),
  modelo character varying(15),
  tipo_motor character varying(12),
  quantidade_motores character varying(4),
  peso_maximo_decolagem bigint,
  quantidade_assentos character varying(4),
  ano_fabricacao bigint,
  pais_registro character varying(17),
  categoria_registro character varying(6),
  categoria_aviacao character varying(24),
  origem_voo character varying(4),
  destino_voo character varying(4),
  fase_operacao character varying(36),
  tipo_operacao character varying(13),
  nivel_dano character varying(11),
  quantidade_fatalidades character varying(4),
  dia_extracao timestamp without time zone,
  hashcode bigint
)
WITH (
  OIDS=FALSE
);

-- Index: dm.idx_dim_aeronave_lookup

 DROP INDEX dm.idx_dim_aeronave_lookup;

CREATE INDEX idx_dim_aeronave_lookup
  ON dm.dim_aeronave
  USING btree
  (hashcode);

-- Index: dm.idx_dim_aeronave_pk

 DROP INDEX dm.idx_dim_aeronave_pk;

CREATE UNIQUE INDEX idx_dim_aeronave_pk
  ON dm.dim_aeronave
  USING btree
  (aeronave_sk);

-- Table: dm.dim_fator_contribuinte

DROP TABLE dm.dim_fator_contribuinte;

CREATE TABLE dm.dim_fator_contribuinte
(
  fator_contribuinte_sk bigserial NOT NULL,
  codigo_fator bigint,
  codigo_ocorrencia bigint,
  fator character varying(41),
  aspecto character varying(11),
  condicionante character varying(14),
  area character varying(11),
  detalhe_fator character varying(55),
  dia_extracao timestamp without time zone,
  hashcode bigint
)
WITH (
  OIDS=FALSE
);

-- Index: dm.idx_dim_fator_contribuinte_lookup

DROP INDEX dm.idx_dim_fator_contribuinte_lookup;

CREATE INDEX idx_dim_fator_contribuinte_lookup
  ON dm.dim_fator_contribuinte
  USING btree
  (hashcode);

-- Index: dm.idx_dim_fator_contribuinte_pk

DROP INDEX dm.idx_dim_fator_contribuinte_pk;

CREATE UNIQUE INDEX idx_dim_fator_contribuinte_pk
  ON dm.dim_fator_contribuinte
  USING btree
  (fator_contribuinte_sk);

-- Table: dm.dim_ocorrencia

DROP TABLE dm.dim_ocorrencia;

CREATE TABLE dm.dim_ocorrencia
(
  ocorrencia_sk bigserial NOT NULL,
  codigo_ocorrencia bigint,
  classificacao character varying(15),
  tipo character varying(42),
  localidade character varying(32),
  uf character varying(2),
  pais character varying(16),
  aerodromo character varying(4),
  dia_ocorrencia timestamp without time zone,
  horario_utc character varying(8),
  sera_investigada character varying(4),
  comando_investigador character varying(8),
  status_investigacao character varying(10),
  numero_relatorio character varying(22),
  relatorio_publicado character varying(4),
  dia_publicacao character varying(10),
  quantidade_recomendacoes bigint,
  aeronaves_envolvidas bigint,
  saida_pista character varying(4),
  dia_extracao timestamp without time zone,
  hashcode bigint
)
WITH (
  OIDS=FALSE
);

-- Index: dm.idx_dim_ocorrencia_lookup

DROP INDEX dm.idx_dim_ocorrencia_lookup;

CREATE INDEX idx_dim_ocorrencia_lookup
  ON dm.dim_ocorrencia
  USING btree
  (hashcode);

-- Index: dm.idx_dim_ocorrencia_pk

DROP INDEX dm.idx_dim_ocorrencia_pk;

CREATE UNIQUE INDEX idx_dim_ocorrencia_pk
  ON dm.dim_ocorrencia
  USING btree
  (ocorrencia_sk);

-- Table: dm.fato_fator_contribuinte

DROP TABLE dm.fato_fator_contribuinte;

CREATE TABLE dm.fato_fator_contribuinte
(
  aeronave_sk bigint,
  fator_contribuinte_sk bigint,
  ocorrencia_sk bigint,
  data_ocorrencia_sk bigint,
  hora_ocorrencia_sk bigint
)
WITH (
  OIDS=FALSE
);
-- Table: dm.fato_ocorrencia

DROP TABLE dm.fato_ocorrencia;

CREATE TABLE dm.fato_ocorrencia
(
  aeronave_sk bigint,
  fator_contribuinte_sk bigint,
  ocorrencia_sk bigint,
  data_ocorrencia_sk bigint,
  hora_ocorrencia_sk bigint,
  quantidade_recomendacoes bigint,
  aeronaves_envolvidas bigint,
  quantidade_fatalidades smallint,
  quantidade_assentos smallint,
  codigo_aeronave VARCHAR(15)
)
WITH (
  OIDS=FALSE
);
