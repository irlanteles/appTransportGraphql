-- DROP SCHEMA transporte;

CREATE SCHEMA transporte AUTHORIZATION "UserGestor";

-- transporte.checklist definição

-- Drop table

-- DROP TABLE transporte.checklist;

CREATE TABLE transporte.checklist (
	id serial4 NOT NULL,
	idsolicitacao varchar NULL,
	limpezaexterior int4 NULL,
	exteriordetalhes varchar NULL,
	limpezainterior int4 NULL,
	interiordetalhes varchar NULL,
	niveloleomotor int4 NULL,
	niveloleodirecao int4 NULL,
	niveloleofreio int4 NULL,
	nivelaguaradiador int4 NULL,
	combustivel int4 NULL,
	lampadas int4 NULL,
	chaveroda int4 NULL,
	macaco int4 NULL,
	triangulo int4 NULL,
	extintor int4 NULL,
	tapetes int4 NULL,
	nivelcombustivel float8 NULL,
	estepe int4 NULL,
	observacoes varchar(500) NULL,
	data_criacao timestamp DEFAULT now() NULL,
	data_atualizacao timestamp DEFAULT now() NULL,
	status int4 NULL,
	buzina int4 NULL,
	placa varchar NULL,
	data_hora_real timestamp NULL,
	tipo int4 NULL,
	setas int4 NULL
);

-- Table Triggers

create trigger t_checklist_bi before
insert
    on
    transporte.checklist for each row execute procedure transporte.f_checklist_bi();
create trigger t_ckecklist_bu before
update
    on
    transporte.checklist for each row execute procedure transporte.f_ckecklist_bu();


-- transporte.checklist chaves estrangeiras

-- transporte.checkout definição

-- Drop table

-- DROP TABLE transporte.checkout;

CREATE TABLE transporte.checkout (
	id serial4 NOT NULL,
	placa varchar NULL,
	nivelcombustivel float8 NULL,
	limpezaexterior int4 NULL,
	niveloleomotor int4 NULL,
	niveloleodirecao int4 NULL,
	niveloleofreio int4 NULL,
	nivelaguaradiador int4 NULL,
	setas int4 NULL,
	lampadas int4 NULL,
	buzina int4 NULL,
	pneus int4 NULL,
	chaveroda int4 NULL,
	macaco int4 NULL,
	triangulo int4 NULL,
	extintor int4 NULL,
	tapetes int4 NULL,
	estepe int4 NULL,
	ocorrencia int4 NULL,
	acidente int4 NULL,
	barulho int4 NULL,
	motor int4 NULL,
	niveisfluidos int4 NULL,
	descricaoincidentes varchar NULL,
	interiordetalhes varchar NULL,
	exteriordetalhes varchar NULL,
	observacoes varchar NULL,
	status int4 NULL,
	idsolicitacao int4 NULL,
	limpezainterior int4 NULL,
	data_hora_real timestamp NULL,
	tipo int4 NULL
);


-- transporte.checkout chaves estrangeiras

-- transporte.deslocamento definição

-- Drop table

-- DROP TABLE transporte.deslocamento;

CREATE TABLE transporte.deslocamento (
	deslocamento_id int2 DEFAULT nextval('transporte.seq_deslocamento'::text::regclass) NOT NULL,
	deslocamento_pessoa_motorista_id int4 NULL,
	deslocamento_solicitacao_obs text NULL,
	deslocamento_criacao timestamptz DEFAULT now() NOT NULL,
	deslocamento_dt_alteracao timestamptz NULL,
	deslocamento_pessoa_gestor_id int4 NULL,
	deslocamento_email int4 NULL,
	deslocamento_emai_envio timestamptz NULL,
	deslocamento_qtde varchar(4) NOT NULL,
	deslocamento_valor int2 DEFAULT 0 NULL,
	deslocamento_empresa_id numeric(1) DEFAULT 0 NULL,
	deslocamento_saldo_valor int2 DEFAULT 0 NULL,
	deslocamento_valor_referencia float8 NULL,
	deslocamento_st int2 DEFAULT 0 NULL,
	deslocamento_solicitacao_id int2 NOT NULL,
	deslocamento_pessoa_id int4 NULL,
	deslocamento_qtd_gest bpchar(1) DEFAULT '0' NULL,
	deslocamento_qtd_calc bpchar(1) DEFAULT '0' NULL,
	deslocamento_pessoa_motorista_complementar int4 DEFAULT 0 NULL,
	deslocamento_pessoa_motorista_complementar_id int4 DEFAULT 0 NULL
);

-- Table Triggers

create constraint trigger "RI_ConstraintTrigger_612964" after
insert
    on
    transporte.deslocamento
from
    transporte.solicitacao not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('fk_solicitacao_id',
    'deslocamento',
    'solicitacao',
    'UNSPECIFIED',
    'deslocamento_solicitacao_id',
    'solicitacao_id');
create constraint trigger "RI_ConstraintTrigger_612965" after
update
    on
    transporte.deslocamento
from
    transporte.solicitacao not deferrable initially immediate for each row execute procedure "RI_FKey_check_upd"('fk_solicitacao_id',
    'deslocamento',
    'solicitacao',
    'UNSPECIFIED',
    'deslocamento_solicitacao_id',
    'solicitacao_id');


-- transporte.deslocamento chaves estrangeiras

-- transporte.motorista_temporario definição

-- Drop table

-- DROP TABLE transporte.motorista_temporario;

CREATE TABLE transporte.motorista_temporario (
	motorista_temporario_id int2 DEFAULT nextval('transporte.seq_motorista_temporario'::text::regclass) NOT NULL,
	motorista_id int4 NOT NULL,
	validade_dt timestamp NULL,
	oficio_numero varchar(20) NULL,
	solicitacao_dt_inicio timestamp NULL,
	solicitacao_td_fim timestamp NULL,
	solicitacao_pessoa_id int4 NOT NULL
);


-- transporte.motorista_temporario chaves estrangeiras

-- transporte.passageiro definição

-- Drop table

-- DROP TABLE transporte.passageiro;

CREATE TABLE transporte.passageiro (
	passageiro_id int4 DEFAULT nextval('transporte.seq_passageiro'::text::regclass) NOT NULL,
	pessoa_id int4 NOT NULL,
	solicitacao_id int4 NOT NULL,
	passageiro_st numeric(1) DEFAULT 0 NULL,
	passageiro_dt_criacao date NULL,
	passageiro_dt_alteracao date NULL
);


-- transporte.passageiro chaves estrangeiras

-- transporte.roteiro definição

-- Drop table

-- DROP TABLE transporte.roteiro;

CREATE TABLE transporte.roteiro (
	roteiro_id int4 DEFAULT nextval('transporte.seq_roteiro'::text::regclass) NOT NULL,
	solicitacao_id int4 NOT NULL,
	roteiro_origem int4 NOT NULL,
	roteiro_destino int4 NOT NULL,
	roteiro_local varchar(30) NULL
);


-- transporte.roteiro chaves estrangeiras

-- transporte.solicitacao definição

-- Drop table

-- DROP TABLE transporte.solicitacao;

CREATE TABLE transporte.solicitacao (
	solicitacao_id int4 DEFAULT nextval('transporte.seq_solicitacao_veiculo'::text::regclass) NOT NULL,
	solicitacao_solicitante int4 NOT NULL,
	solicitacao_qtdpessoa varchar NULL,
	tipo_veiculo_id int4 NOT NULL,
	solicitacao_roteiro_ds text NULL,
	solicitacao_obs text NULL,
	solicitacao_dt date NULL,
	solicitacao_hr varchar NULL,
	solicitacao_saida_dt_prevista timestamp NULL,
	solicitacao_retorno_dt_prevista timestamp NULL,
	solicitacao_motorista int4 NULL,
	veiculo_id int4 NULL,
	solicitacao_saida_dt timestamp NULL,
	solicitacao_retorno_dt timestamp NULL,
	solicitacao_unidadecusto int4 NOT NULL,
	solicitacao_situacao numeric(1) DEFAULT 0 NULL,
	solicitacao_st numeric(1) DEFAULT 0 NULL,
	solicitacao_dt_criacao date NULL,
	solicitacao_dt_alteracao date NULL,
	solicitacao_devolvida numeric(1) DEFAULT 0 NULL,
	solicitacao_kminicial varchar NULL,
	solicitacao_kmfinal varchar NULL,
	solicitacao_obs_gestor varchar(255) NULL,
	solicitacao_infor_pendencia varchar(255) NULL,
	solicitacao_solicitante_est int4 NULL,
	solicitacao_numero varchar(10) NULL,
	projeto_cd int2 DEFAULT 2000 NOT NULL,
	acao_cd int2 DEFAULT 9999 NOT NULL,
	territorio_cd int2 DEFAULT 99 NOT NULL,
	fonte_cd int2 DEFAULT 109 NOT NULL,
	convenio_id int4 DEFAULT 0 NULL,
	socilitacao_numero_diaria int4 DEFAULT 0 NULL,
	socilitacao_endereco_maps varchar(512) DEFAULT '0' NULL,
	endereco_origem_id int4 NULL
);

-- Table Triggers

create constraint trigger "RI_ConstraintTrigger_612951" after
delete
    on
    transporte.solicitacao
from
    transporte.solicitacao_autorizacao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_solicitacao',
    'solicitacao_autorizacao',
    'solicitacao',
    'UNSPECIFIED',
    'solicitacao_id',
    'solicitacao_id');
create constraint trigger "RI_ConstraintTrigger_612952" after
update
    on
    transporte.solicitacao
from
    transporte.solicitacao_autorizacao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_solicitacao',
    'solicitacao_autorizacao',
    'solicitacao',
    'UNSPECIFIED',
    'solicitacao_id',
    'solicitacao_id');
create constraint trigger "RI_ConstraintTrigger_612956" after
delete
    on
    transporte.solicitacao
from
    transporte.solicitacao_autorizacao_gestor not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_solicitacao',
    'solicitacao_autorizacao_gestor',
    'solicitacao',
    'UNSPECIFIED',
    'solicitacao_id',
    'solicitacao_id');
create constraint trigger "RI_ConstraintTrigger_612957" after
update
    on
    transporte.solicitacao
from
    transporte.solicitacao_autorizacao_gestor not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_solicitacao',
    'solicitacao_autorizacao_gestor',
    'solicitacao',
    'UNSPECIFIED',
    'solicitacao_id',
    'solicitacao_id');
create constraint trigger "RI_ConstraintTrigger_612961" after
delete
    on
    transporte.solicitacao
from
    transporte.solicitacao_devolucao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_solicitacao_devolucao',
    'solicitacao_devolucao',
    'solicitacao',
    'UNSPECIFIED',
    'solicitacao_id',
    'solicitacao_id');
create constraint trigger "RI_ConstraintTrigger_612962" after
update
    on
    transporte.solicitacao
from
    transporte.solicitacao_devolucao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_solicitacao_devolucao',
    'solicitacao_devolucao',
    'solicitacao',
    'UNSPECIFIED',
    'solicitacao_id',
    'solicitacao_id');
create constraint trigger "RI_ConstraintTrigger_612966" after
delete
    on
    transporte.solicitacao
from
    transporte.deslocamento not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_solicitacao_id',
    'deslocamento',
    'solicitacao',
    'UNSPECIFIED',
    'deslocamento_solicitacao_id',
    'solicitacao_id');
create constraint trigger "RI_ConstraintTrigger_612967" after
update
    on
    transporte.solicitacao
from
    transporte.deslocamento not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_solicitacao_id',
    'deslocamento',
    'solicitacao',
    'UNSPECIFIED',
    'deslocamento_solicitacao_id',
    'solicitacao_id');


-- transporte.solicitacao chaves estrangeiras

-- transporte.solicitacao_autorizacao definição

-- Drop table

-- DROP TABLE transporte.solicitacao_autorizacao;

CREATE TABLE transporte.solicitacao_autorizacao (
	solicitacao_autorizacao_id int4 DEFAULT nextval('transporte.seq_solicitacao_autorizacao'::text::regclass) NOT NULL,
	solicitacao_id int4 NOT NULL,
	solicitacao_autorizacao_func int4 NOT NULL,
	solicitacao_autorizacao_dt date NOT NULL,
	solicitacao_autorizacao_hr varchar(10) NOT NULL
);

-- Table Triggers

create constraint trigger "RI_ConstraintTrigger_612949" after
insert
    on
    transporte.solicitacao_autorizacao
from
    transporte.solicitacao not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('fk_solicitacao',
    'solicitacao_autorizacao',
    'solicitacao',
    'UNSPECIFIED',
    'solicitacao_id',
    'solicitacao_id');
create constraint trigger "RI_ConstraintTrigger_612950" after
update
    on
    transporte.solicitacao_autorizacao
from
    transporte.solicitacao not deferrable initially immediate for each row execute procedure "RI_FKey_check_upd"('fk_solicitacao',
    'solicitacao_autorizacao',
    'solicitacao',
    'UNSPECIFIED',
    'solicitacao_id',
    'solicitacao_id');


-- transporte.solicitacao_autorizacao chaves estrangeiras

-- transporte.solicitacao_autorizacao_gestor definição

-- Drop table

-- DROP TABLE transporte.solicitacao_autorizacao_gestor;

CREATE TABLE transporte.solicitacao_autorizacao_gestor (
	solicitacao_autorizacao_gestor_id int4 DEFAULT nextval('transporte.seq_solicitacao_gestor'::text::regclass) NOT NULL,
	solicitacao_id int4 NOT NULL,
	solicitacao_autorizacao_gestor_func int4 NOT NULL,
	solicitacao_autorizacao_gestor_dt date NOT NULL,
	solicitacao_autorizacao_gestor_hr varchar(10) NOT NULL,
	solicitacao_autorizacao_gestor_tipo varchar(15) NULL
);

-- Table Triggers

create constraint trigger "RI_ConstraintTrigger_612954" after
insert
    on
    transporte.solicitacao_autorizacao_gestor
from
    transporte.solicitacao not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('fk_solicitacao',
    'solicitacao_autorizacao_gestor',
    'solicitacao',
    'UNSPECIFIED',
    'solicitacao_id',
    'solicitacao_id');
create constraint trigger "RI_ConstraintTrigger_612955" after
update
    on
    transporte.solicitacao_autorizacao_gestor
from
    transporte.solicitacao not deferrable initially immediate for each row execute procedure "RI_FKey_check_upd"('fk_solicitacao',
    'solicitacao_autorizacao_gestor',
    'solicitacao',
    'UNSPECIFIED',
    'solicitacao_id',
    'solicitacao_id');


-- transporte.solicitacao_autorizacao_gestor chaves estrangeiras

-- transporte.solicitacao_autorizador definição

-- Drop table

-- DROP TABLE transporte.solicitacao_autorizador;

CREATE TABLE transporte.solicitacao_autorizador (
	pessoa_id int4 NOT NULL,
	solicitacao_unidadecusto int4 NOT NULL
);


-- transporte.solicitacao_autorizador chaves estrangeiras

-- transporte.solicitacao_devolucao definição

-- Drop table

-- DROP TABLE transporte.solicitacao_devolucao;

CREATE TABLE transporte.solicitacao_devolucao (
	solicitacao_devolucao_id int2 DEFAULT nextval('transporte.seq_solicitacao_devolucao'::text::regclass) NOT NULL,
	solicitacao_id int4 NOT NULL,
	solicitacao_devolucao_func int4 NOT NULL,
	solicitacao_devolucao_ds varchar(1024) NULL,
	solicitacao_devolucao_dt date NOT NULL,
	solicitacao_devolucao_hr varchar(10) NOT NULL,
	tipo_motivo_id int4 NULL
);

-- Table Triggers

create constraint trigger "RI_ConstraintTrigger_612959" after
insert
    on
    transporte.solicitacao_devolucao
from
    transporte.solicitacao not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('fk_solicitacao_devolucao',
    'solicitacao_devolucao',
    'solicitacao',
    'UNSPECIFIED',
    'solicitacao_id',
    'solicitacao_id');
create constraint trigger "RI_ConstraintTrigger_612960" after
update
    on
    transporte.solicitacao_devolucao
from
    transporte.solicitacao not deferrable initially immediate for each row execute procedure "RI_FKey_check_upd"('fk_solicitacao_devolucao',
    'solicitacao_devolucao',
    'solicitacao',
    'UNSPECIFIED',
    'solicitacao_id',
    'solicitacao_id');


-- transporte.solicitacao_devolucao chaves estrangeiras


-- transporte.solicitacao_emergencial definição

-- Drop table

-- DROP TABLE transporte.solicitacao_emergencial;

CREATE TABLE transporte.solicitacao_emergencial (
	solicitacao_emergencial_id int4 DEFAULT nextval('transporte.seq_emergencial'::text::regclass) NOT NULL,
	solicitacao_id int4 NULL,
	solicitacao_emergencial_justificativa varchar(255) NULL,
	solicitacao_dt_emergencial timestamp NULL,
	solicitacao_beneficiario int4 NULL
);


-- transporte.solicitacao_emergencial chaves estrangeiras

-- transporte.tipo_habilitacao definição

-- Drop table

-- DROP TABLE transporte.tipo_habilitacao;

CREATE TABLE transporte.tipo_habilitacao (
	tipo_habilitacao_id int2 DEFAULT nextval('transporte.seq_tipo_habilitacao'::text::regclass) NOT NULL,
	tipo_habilitacao_nome varchar(2) NULL,
	tipo_habilitacao_modalidade varchar(80) NULL,
	tipo_habilitacao_descricao_lei varchar(500) NULL
);


-- transporte.tipo_habilitacao chaves estrangeiras

-- transporte.tipo_motivo definição

-- Drop table

-- DROP TABLE transporte.tipo_motivo;

CREATE TABLE transporte.tipo_motivo (
	tipo_motivo_id int2 DEFAULT nextval('transporte.seq_motivo'::text::regclass) NOT NULL,
	tipo_motivo_ds varchar(100) NOT NULL,
	tipo_motivo_st numeric(1) DEFAULT 0 NULL,
	tipo_motivo_dt_criacao date NULL,
	tipo_motivo_dt_alteracao date NULL
);


-- transporte.tipo_motivo chaves estrangeiras

-- transporte.tipo_veiculo definição

-- Drop table

-- DROP TABLE transporte.tipo_veiculo;

CREATE TABLE transporte.tipo_veiculo (
	tipo_veiculo_id int2 DEFAULT nextval('transporte.seq_tipo_veiculo'::text::regclass) NOT NULL,
	tipo_veiculo_ds varchar(30) NULL,
	tipo_veiculo_st numeric(1) DEFAULT 0 NULL,
	tipo_veiculo_dt_criacao date NULL,
	tipo_veiculo_dt_alteracao date NULL,
	tipo_veiculo_qtd_passageiro int4 DEFAULT 0 NOT NULL,
	tipo_veiculo_custo_km varchar(10) NULL,
	tipo_veiculo_habilitacao_id int2 NULL
);


-- transporte.tipo_veiculo chaves estrangeiras

-- transporte.transporte_log definição

-- Drop table

-- DROP TABLE transporte.transporte_log;

CREATE TABLE transporte.transporte_log (
	transporte_log_id int2 DEFAULT nextval('transporte.seq_transporte_log'::text::regclass) NOT NULL,
	solicitacao_id int4 NOT NULL,
	usuario_id int4 NOT NULL,
	transporte_log_ds varchar(255) NULL,
	transporte_log_dt date NULL,
	transporte_log_hr time NULL
);


-- transporte.transporte_log chaves estrangeiras

-- transporte.veiculo definição

-- Drop table

-- DROP TABLE transporte.veiculo;

CREATE TABLE transporte.veiculo (
	veiculo_id int2 DEFAULT nextval('transporte.seq_veiculo'::text::regclass) NOT NULL,
	veiculo_placa varchar(8) NULL,
	tipo_veiculo_id int4 NOT NULL,
	veiculo_st numeric(1) DEFAULT 0 NULL,
	veiculo_dt_criacao date NULL,
	veiculo_dt_alteracao date NULL,
	veiculo_tag varchar NULL,
	pessoa_id int8 DEFAULT 0 NULL,
	hodometro_inicial int4 NULL,
	hodometro_final int4 NULL
);


-- transporte.veiculo chaves estrangeiras

-- transporte.viagem definição

-- Drop table

-- DROP TABLE transporte.viagem;

CREATE TABLE transporte.viagem (
	id serial4 NOT NULL,
	endereco varchar NULL,
	passageiro_id int4 NULL,
	quantidade_pessoa int4 NULL,
	data_criacao timestamp DEFAULT now() NULL,
	data_alteracao timestamp DEFAULT now() NULL,
	solicitacao_id int4 NULL,
	endereco_st int4 NULL,
	ordem int4 NULL,
	data_hora_real timestamp NULL
);

-- Table Triggers

create trigger t_viagem_au after
update
    on
    transporte.viagem for each row execute procedure transporte.f_viagem_au();
create trigger t_viagem_bu before
update
    on
    transporte.viagem for each row execute procedure transporte.f_viagem_bu();


-- transporte.viagem chaves estrangeiras


-- transporte.vw_transporte fonte

CREATE OR REPLACE VIEW transporte.vw_transporte
AS SELECT b.pessoa_nm AS solicitante, d.est_organizacional_id, e.est_organizacional_sigla AS unidade_solicitante, g.pessoa_nm AS autorizador, h.pessoa_nm AS motorista, i.veiculo_placa, 
        CASE a.solicitacao_st
            WHEN 0 THEN 'AGUARDANDO'::text
            WHEN 1 THEN 'AUTORIZADO'::text
            WHEN 2 THEN 'AGENDADO'::text
            WHEN 3 THEN 'PENDENTE'::text
            WHEN 4 THEN 'EM TRANSITO'::text
            WHEN 5 THEN 'ARQUIVADO'::text
            WHEN 6 THEN 'DEVOLVIDO'::text
            ELSE NULL::text
        END AS status, a.solicitacao_saida_dt_prevista, COALESCE(a.solicitacao_kminicial::integer, 0) AS km_inicial, COALESCE(a.solicitacao_kmfinal::integer, 0) AS km_final, COALESCE(a.solicitacao_kmfinal::integer, 0) - COALESCE(a.solicitacao_kminicial::integer, 0) AS km_rodado
   FROM transporte.solicitacao a
   JOIN dados_unico.pessoa b ON b.pessoa_id = a.solicitacao_solicitante
   LEFT JOIN dados_unico.funcionario c ON c.pessoa_id = b.pessoa_id AND c.funcionario_st = 0
   LEFT JOIN dados_unico.est_organizacional_funcionario d ON d.funcionario_id = c.funcionario_id
   LEFT JOIN dados_unico.est_organizacional e ON e.est_organizacional_id = d.est_organizacional_id AND e.est_organizacional_orgao = 1420
   LEFT JOIN transporte.solicitacao_autorizador f ON f.pessoa_id = b.pessoa_id
   LEFT JOIN dados_unico.pessoa g ON g.pessoa_id = f.pessoa_id
   LEFT JOIN dados_unico.pessoa h ON h.pessoa_id = a.solicitacao_motorista
   LEFT JOIN transporte.veiculo i ON i.veiculo_id = a.veiculo_id
  ORDER BY b.pessoa_nm;



  -- transporte.vw_viagens fonte

CREATE OR REPLACE VIEW transporte.vw_viagens
AS SELECT s.solicitacao_id, s.solicitacao_numero, p2.pessoa_nm AS solicitante, p3.pessoa_nm AS autorizador, s.solicitacao_qtdpessoa, s.solicitacao_saida_dt_prevista, s.solicitacao_saida_dt, p.pessoa_nm AS motorista, tv.tipo_veiculo_ds, v.veiculo_placa, p5.pessoa_nm AS passageiro, pa.passageiro_st AS status_passageiro, vi.endereco AS destino, vi.endereco_st AS status_endereco, v.hodometro_inicial, v.hodometro_final, vi.ordem
   FROM transporte.solicitacao s
   JOIN dados_unico.pessoa p ON p.pessoa_id = s.solicitacao_motorista
   JOIN transporte.solicitacao_autorizacao sa ON sa.solicitacao_id = s.solicitacao_id
   JOIN dados_unico.pessoa p3 ON p3.pessoa_id = sa.solicitacao_autorizacao_func
   JOIN dados_unico.pessoa p2 ON s.solicitacao_solicitante = p2.pessoa_id
   JOIN transporte.tipo_veiculo tv ON tv.tipo_veiculo_id = s.tipo_veiculo_id
   JOIN transporte.veiculo v ON s.veiculo_id = v.veiculo_id
   JOIN transporte.viagem vi ON vi.solicitacao_id = s.solicitacao_id
   JOIN transporte.passageiro pa ON pa.solicitacao_id = s.solicitacao_id
   JOIN dados_unico.pessoa p5 ON p5.pessoa_id = pa.pessoa_id;


-- DROP FUNCTION transporte.f_ckecklist_bu();

CREATE OR REPLACE FUNCTION transporte.f_ckecklist_bu()
	RETURNS trigger
	LANGUAGE plpgsql
	VOLATILE
AS $$
		
BEGIN
    NEW.data_alteracao:= now();
    RETURN NEW;
END;


$$
;   


-- DROP FUNCTION transporte.f_checklist_bi();

CREATE OR REPLACE FUNCTION transporte.f_checklist_bi()
	RETURNS trigger
	LANGUAGE plpgsql
	VOLATILE
AS $$
		
BEGIN
    NEW.data_criacao:= now();
    RETURN NEW;
END;

$$
;


-- DROP FUNCTION transporte.f_inserir_viagem(int4, varchar, int4, _text, text, text, date, varchar, timestamp, timestamp, int4, int4, int4, date, int4, int4, int4, int4, int4, varchar, int4, _int4, int4);

CREATE OR REPLACE FUNCTION transporte.f_inserir_viagem(p_solicitacao_solicitante int4, p_solicitacao_qtdpessoa varchar, p_tipo_veiculo_id int4, p_endereco _text, p_solicitacao_roteiro_ds text, p_solicitacao_obs text, p_solicitacao_dt date, p_solicitacao_hr varchar, p_solicitacao_saida_dt_prevista timestamp, p_solicitacao_retorno_dt_prevista timestamp, p_solicitacao_unidadecusto int4, p_solicitacao_situacao int4, p_solicitacao_st int4, p_solicitacao_dt_criacao date, p_solicitacao_solicitante_est int4, p_projeto_cd int4, p_acao_cd int4, p_territorio_cd int4, p_fonte_cd int4, p_solicitacao_numero varchar, p_quantidade_pessoa int4, p_passageiro_ids _int4, p_ordem int4)
	RETURNS void
	LANGUAGE plpgsql
	VOLATILE
AS $$
	
DECLARE
    v_solicitacao_id INT;
    v_passageiro_id INT;
    v_endereco TEXT;
    idx INT := 1;
    total_enderecos INT;
BEGIN
	total_enderecos := array_upper(p_endereco, 1);
    INSERT INTO transporte.solicitacao(
        solicitacao_solicitante,
        solicitacao_qtdpessoa,
        tipo_veiculo_id,
        solicitacao_roteiro_ds,
        solicitacao_obs,
        solicitacao_dt,
        solicitacao_hr,
        solicitacao_saida_dt_prevista,
        solicitacao_retorno_dt_prevista,
        solicitacao_unidadecusto,
        solicitacao_situacao,
        solicitacao_st,
        solicitacao_dt_criacao,
        solicitacao_solicitante_est,
        projeto_cd,
        acao_cd,
        territorio_cd,
        fonte_cd,
        solicitacao_numero
    ) VALUES (
        p_solicitacao_solicitante,
        p_solicitacao_qtdpessoa,
        p_tipo_veiculo_id,
        p_solicitacao_roteiro_ds,
        p_solicitacao_obs,
        p_solicitacao_dt,
        p_solicitacao_hr,
        p_solicitacao_saida_dt_prevista,
        p_solicitacao_retorno_dt_prevista,
        p_solicitacao_unidadecusto,
        p_solicitacao_situacao,
        p_solicitacao_st,
        p_solicitacao_dt_criacao,
        p_solicitacao_solicitante_est,
        p_projeto_cd,
        p_acao_cd,
        p_territorio_cd,
        p_fonte_cd,
        p_solicitacao_numero
    )
    RETURNING solicitacao_id INTO v_solicitacao_id;

    FOR idx IN 1 .. array_upper(p_passageiro_ids, 1) LOOP
        -- Seleciona o endereço correspondente ou repete o último
		v_passageiro_id := p_passageiro_ids[idx];
        IF total_enderecos IS NULL OR total_enderecos = 0 THEN
            v_endereco := NULL;
        ELSIF total_enderecos = 1 THEN
            v_endereco := p_endereco[1];
        ELSIF idx <= total_enderecos THEN
            v_endereco := p_endereco[idx];
        ELSE
            v_endereco := p_endereco[total_enderecos];
        END IF;

        INSERT INTO transporte.passageiro (
            solicitacao_id, 
            pessoa_id
        ) VALUES (
            v_solicitacao_id, 
            v_passageiro_id
        )
        RETURNING passageiro_id INTO v_passageiro_id;

        INSERT INTO transporte.viagem(
            endereco,
            passageiro_id,
            quantidade_pessoa,
            solicitacao_id,
            endereco_st,
            ordem
        ) VALUES (
            v_endereco,
            v_passageiro_id,
            p_quantidade_pessoa,
            v_solicitacao_id,				
            0,
            p_ordem
        );
        idx := idx + 1;
    END LOOP;
    RETURN;
END;

$$
;

-- DROP FUNCTION transporte.f_viagem_au();

CREATE OR REPLACE FUNCTION transporte.f_viagem_au()
	RETURNS trigger
	LANGUAGE plpgsql
	VOLATILE
AS $$
	
	
DECLARE
    v_viagem_id INT;
    v_destino_atual INT;
    v_proxima_parada_id INT;
	v_ordem_atual int;
BEGIN
	-- função para atualizar_origem_proxima_parada
    -- Verifica se o status foi alterado para 3
    IF NEW.endereco_st = 3 AND OLD.endereco_st IS DISTINCT FROM 3 THEN
        -- Pega dados da parada origem atual tabela solicitação
        SELECT solicitacao_id, endereco_origem_id
        INTO v_viagem_id, v_destino_atual
        FROM transporte.solicitacao s
        WHERE s.solicitacao_id = NEW.solicitacao_id;


        -- Pega a próxima parada da viagem que ainda não foi finalizada
        SELECT endereco_id
        INTO v_proxima_parada_id
        FROM transporte.endereco e
        WHERE e.solicitacao_id = v_viagem_id
          AND e.endereco_st = 3
		order by e.data_alteracao desc
        LIMIT 1;


        -- Atualiza a origem da próxima parada
        IF v_proxima_parada_id IS NOT NULL THEN

			--ataliza o endereco de origem
            UPDATE transporte.solicitacao
            SET endereco_origem_id = v_proxima_parada_id
            WHERE solicitacao_id = v_viagem_id;	
			
        END IF;
    END IF;

    RETURN NEW;
END;


$$
;

-- DROP FUNCTION transporte.f_viagem_bu();

CREATE OR REPLACE FUNCTION transporte.f_viagem_bu()
	RETURNS trigger
	LANGUAGE plpgsql
	VOLATILE
AS $$
		
BEGIN
    NEW.data_alteracao:= now();
    RETURN NEW;
END;


$$
;


-- DROP SCHEMA dados_unico;
