CREATE SCHEMA dados_unico AUTHORIZATION "UserGestor";


-- dados_unico.pessoa definição

-- Drop table

-- DROP TABLE dados_unico.pessoa;

CREATE TABLE dados_unico.pessoa (
	pessoa_id int4 DEFAULT nextval('dados_unico.seq_pessoa'::text::regclass) NOT NULL,
	pessoa_nm varchar(200) NULL,
	pessoa_tipo bpchar(1) NOT NULL,
	pessoa_email varchar(200) NULL,
	pessoa_st numeric(1) DEFAULT 0 NULL,
	pessoa_dt_criacao date DEFAULT now() NULL,
	pessoa_dt_alteracao date DEFAULT now() NULL,
	pessoa_usuario_criador int4 DEFAULT 0 NOT NULL,
	pessoa_fornecedor_passagens int4 DEFAULT 0 NULL,
	tipo_vinculo_pj_id int4 DEFAULT 0 NULL,
	newsletter numeric(1) DEFAULT 0 NULL
);

-- Table Triggers

create trigger trigger_pessoa_bi before
insert
    on
    dados_unico.pessoa for each row execute procedure dados_unico.trigger_pessoa_bi();
create constraint trigger "RI_ConstraintTrigger_608846" after
delete
    on
    dados_unico.pessoa
from
    agenda.evento_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_alteracao_pessoa_id',
    'evento_historico',
    'pessoa',
    'UNSPECIFIED',
    'evento_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_608847" after
update
    on
    dados_unico.pessoa
from
    agenda.evento_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_alteracao_pessoa_id',
    'evento_historico',
    'pessoa',
    'UNSPECIFIED',
    'evento_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_608851" after
delete
    on
    dados_unico.pessoa
from
    agenda.evento not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_cadastro_pessoa_id',
    'evento',
    'pessoa',
    'UNSPECIFIED',
    'evento_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_608852" after
update
    on
    dados_unico.pessoa
from
    agenda.evento not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_cadastro_pessoa_id',
    'evento',
    'pessoa',
    'UNSPECIFIED',
    'evento_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_608891" after
delete
    on
    dados_unico.pessoa
from
    agenda.evento_participantes not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'evento_participantes',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_608892" after
update
    on
    dados_unico.pessoa
from
    agenda.evento_participantes not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'evento_participantes',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_608896" after
delete
    on
    dados_unico.pessoa
from
    agenda.evento not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_responsavel_id',
    'evento',
    'pessoa',
    'UNSPECIFIED',
    'responsavel_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_608897" after
update
    on
    dados_unico.pessoa
from
    agenda.evento not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_responsavel_id',
    'evento',
    'pessoa',
    'UNSPECIFIED',
    'responsavel_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609021" after
delete
    on
    dados_unico.pessoa
from
    agua_doce.lote not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'lote',
    'pessoa',
    'UNSPECIFIED',
    'lote_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609022" after
update
    on
    dados_unico.pessoa
from
    agua_doce.lote not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'lote',
    'pessoa',
    'UNSPECIFIED',
    'lote_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609026" after
delete
    on
    dados_unico.pessoa
from
    agua_doce.lote_anexo not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'lote_anexo',
    'pessoa',
    'UNSPECIFIED',
    'lote_anexo_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609027" after
update
    on
    dados_unico.pessoa
from
    agua_doce.lote_anexo not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'lote_anexo',
    'pessoa',
    'UNSPECIFIED',
    'lote_anexo_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609031" after
delete
    on
    dados_unico.pessoa
from
    agua_doce.lote_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'lote_historico',
    'pessoa',
    'UNSPECIFIED',
    'lote_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609032" after
update
    on
    dados_unico.pessoa
from
    agua_doce.lote_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'lote_historico',
    'pessoa',
    'UNSPECIFIED',
    'lote_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609216" after
delete
    on
    dados_unico.pessoa
from
    auditoria.operacoes_usuario not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('operacoes_usuario_pessoa_id_fkey',
    'operacoes_usuario',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609217" after
update
    on
    dados_unico.pessoa
from
    auditoria.operacoes_usuario not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('operacoes_usuario_pessoa_id_fkey',
    'operacoes_usuario',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609371" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica.artigo not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_artigo_cadastro_pessoa_id',
    'artigo',
    'pessoa',
    'UNSPECIFIED',
    'artigo_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609372" after
update
    on
    dados_unico.pessoa
from
    consulta_publica.artigo not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_artigo_cadastro_pessoa_id',
    'artigo',
    'pessoa',
    'UNSPECIFIED',
    'artigo_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609386" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica.comite not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_comite_cadastro_pessoa_id',
    'comite',
    'pessoa',
    'UNSPECIFIED',
    'comite_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609387" after
update
    on
    dados_unico.pessoa
from
    consulta_publica.comite not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_comite_cadastro_pessoa_id',
    'comite',
    'pessoa',
    'UNSPECIFIED',
    'comite_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609401" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica.comite_pessoa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_comite_pessoa_cadastro_pessoa_id',
    'comite_pessoa',
    'pessoa',
    'UNSPECIFIED',
    'comite_pessoa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609402" after
update
    on
    dados_unico.pessoa
from
    consulta_publica.comite_pessoa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_comite_pessoa_cadastro_pessoa_id',
    'comite_pessoa',
    'pessoa',
    'UNSPECIFIED',
    'comite_pessoa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609406" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica.contribuicao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_contribuicao_cadastro_pessoa_id',
    'contribuicao',
    'pessoa',
    'UNSPECIFIED',
    'contribuicao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609407" after
update
    on
    dados_unico.pessoa
from
    consulta_publica.contribuicao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_contribuicao_cadastro_pessoa_id',
    'contribuicao',
    'pessoa',
    'UNSPECIFIED',
    'contribuicao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609411" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica.minuta_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_minuta_alteracao_pessoa_id',
    'minuta_historico',
    'pessoa',
    'UNSPECIFIED',
    'minuta_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609412" after
update
    on
    dados_unico.pessoa
from
    consulta_publica.minuta_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_minuta_alteracao_pessoa_id',
    'minuta_historico',
    'pessoa',
    'UNSPECIFIED',
    'minuta_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609416" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica.minuta_anexo not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_minuta_anexo_cadastro_pessoa_id',
    'minuta_anexo',
    'pessoa',
    'UNSPECIFIED',
    'minuta_anexo_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609417" after
update
    on
    dados_unico.pessoa
from
    consulta_publica.minuta_anexo not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_minuta_anexo_cadastro_pessoa_id',
    'minuta_anexo',
    'pessoa',
    'UNSPECIFIED',
    'minuta_anexo_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609421" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica.minuta not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_minuta_cadastro_pessoa_id',
    'minuta',
    'pessoa',
    'UNSPECIFIED',
    'minuta_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609422" after
update
    on
    dados_unico.pessoa
from
    consulta_publica.minuta not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_minuta_cadastro_pessoa_id',
    'minuta',
    'pessoa',
    'UNSPECIFIED',
    'minuta_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609426" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica.minuta_comite not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_minuta_comite_cadastro_pessoa_id',
    'minuta_comite',
    'pessoa',
    'UNSPECIFIED',
    'minuta_comite_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609427" after
update
    on
    dados_unico.pessoa
from
    consulta_publica.minuta_comite not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_minuta_comite_cadastro_pessoa_id',
    'minuta_comite',
    'pessoa',
    'UNSPECIFIED',
    'minuta_comite_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609451" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica.comite_pessoa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'comite_pessoa',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609452" after
update
    on
    dados_unico.pessoa
from
    consulta_publica.comite_pessoa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'comite_pessoa',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609456" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica.seccao_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_seccao_alteracao_pessoa_id',
    'seccao_historico',
    'pessoa',
    'UNSPECIFIED',
    'seccao_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609457" after
update
    on
    dados_unico.pessoa
from
    consulta_publica.seccao_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_seccao_alteracao_pessoa_id',
    'seccao_historico',
    'pessoa',
    'UNSPECIFIED',
    'seccao_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609461" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica.seccao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_seccao_cadastro_pessoa_id',
    'seccao',
    'pessoa',
    'UNSPECIFIED',
    'seccao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609462" after
update
    on
    dados_unico.pessoa
from
    consulta_publica.seccao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_seccao_cadastro_pessoa_id',
    'seccao',
    'pessoa',
    'UNSPECIFIED',
    'seccao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609481" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica.tipo_contribuicao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_tipo_contribuicao_cadastro_pessoa_id',
    'tipo_contribuicao',
    'pessoa',
    'UNSPECIFIED',
    'tipo_contribuicao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609482" after
update
    on
    dados_unico.pessoa
from
    consulta_publica.tipo_contribuicao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_tipo_contribuicao_cadastro_pessoa_id',
    'tipo_contribuicao',
    'pessoa',
    'UNSPECIFIED',
    'tipo_contribuicao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609491" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.artigo not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_artigo_cadastro_pessoa_id',
    'artigo',
    'pessoa',
    'UNSPECIFIED',
    'artigo_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609492" after
update
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.artigo not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_artigo_cadastro_pessoa_id',
    'artigo',
    'pessoa',
    'UNSPECIFIED',
    'artigo_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609506" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.comite not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_comite_cadastro_pessoa_id',
    'comite',
    'pessoa',
    'UNSPECIFIED',
    'comite_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609507" after
update
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.comite not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_comite_cadastro_pessoa_id',
    'comite',
    'pessoa',
    'UNSPECIFIED',
    'comite_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609521" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.comite_pessoa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_comite_pessoa_cadastro_pessoa_id',
    'comite_pessoa',
    'pessoa',
    'UNSPECIFIED',
    'comite_pessoa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609522" after
update
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.comite_pessoa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_comite_pessoa_cadastro_pessoa_id',
    'comite_pessoa',
    'pessoa',
    'UNSPECIFIED',
    'comite_pessoa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609526" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.contribuicao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_contribuicao_cadastro_pessoa_id',
    'contribuicao',
    'pessoa',
    'UNSPECIFIED',
    'contribuicao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609527" after
update
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.contribuicao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_contribuicao_cadastro_pessoa_id',
    'contribuicao',
    'pessoa',
    'UNSPECIFIED',
    'contribuicao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609531" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.minuta_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_minuta_alteracao_pessoa_id',
    'minuta_historico',
    'pessoa',
    'UNSPECIFIED',
    'minuta_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609532" after
update
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.minuta_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_minuta_alteracao_pessoa_id',
    'minuta_historico',
    'pessoa',
    'UNSPECIFIED',
    'minuta_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609536" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.minuta_anexo not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_minuta_anexo_cadastro_pessoa_id',
    'minuta_anexo',
    'pessoa',
    'UNSPECIFIED',
    'minuta_anexo_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609537" after
update
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.minuta_anexo not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_minuta_anexo_cadastro_pessoa_id',
    'minuta_anexo',
    'pessoa',
    'UNSPECIFIED',
    'minuta_anexo_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609541" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.minuta not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_minuta_cadastro_pessoa_id',
    'minuta',
    'pessoa',
    'UNSPECIFIED',
    'minuta_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609542" after
update
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.minuta not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_minuta_cadastro_pessoa_id',
    'minuta',
    'pessoa',
    'UNSPECIFIED',
    'minuta_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609546" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.minuta_comite not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_minuta_comite_cadastro_pessoa_id',
    'minuta_comite',
    'pessoa',
    'UNSPECIFIED',
    'minuta_comite_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609547" after
update
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.minuta_comite not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_minuta_comite_cadastro_pessoa_id',
    'minuta_comite',
    'pessoa',
    'UNSPECIFIED',
    'minuta_comite_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609571" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.comite_pessoa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'comite_pessoa',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609572" after
update
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.comite_pessoa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'comite_pessoa',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609576" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.seccao_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_seccao_alteracao_pessoa_id',
    'seccao_historico',
    'pessoa',
    'UNSPECIFIED',
    'seccao_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609577" after
update
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.seccao_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_seccao_alteracao_pessoa_id',
    'seccao_historico',
    'pessoa',
    'UNSPECIFIED',
    'seccao_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609581" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.seccao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_seccao_cadastro_pessoa_id',
    'seccao',
    'pessoa',
    'UNSPECIFIED',
    'seccao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609582" after
update
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.seccao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_seccao_cadastro_pessoa_id',
    'seccao',
    'pessoa',
    'UNSPECIFIED',
    'seccao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609601" after
delete
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.tipo_contribuicao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_tipo_contribuicao_cadastro_pessoa_id',
    'tipo_contribuicao',
    'pessoa',
    'UNSPECIFIED',
    'tipo_contribuicao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609602" after
update
    on
    dados_unico.pessoa
from
    consulta_publica_m0520242024.tipo_contribuicao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_tipo_contribuicao_cadastro_pessoa_id',
    'tipo_contribuicao',
    'pessoa',
    'UNSPECIFIED',
    'tipo_contribuicao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609711" after
delete
    on
    dados_unico.pessoa
from
    contrato.controle_tipo_acao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_controle_tipo_acao_cadastro_pessoa_id',
    'controle_tipo_acao',
    'pessoa',
    'UNSPECIFIED',
    'controle_tipo_acao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609712" after
update
    on
    dados_unico.pessoa
from
    contrato.controle_tipo_acao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_controle_tipo_acao_cadastro_pessoa_id',
    'controle_tipo_acao',
    'pessoa',
    'UNSPECIFIED',
    'controle_tipo_acao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609756" after
delete
    on
    dados_unico.pessoa
from
    contrato.controle_fluxo_etapa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'controle_fluxo_etapa',
    'pessoa',
    'UNSPECIFIED',
    'controle_fluxo_etapa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609757" after
update
    on
    dados_unico.pessoa
from
    contrato.controle_fluxo_etapa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'controle_fluxo_etapa',
    'pessoa',
    'UNSPECIFIED',
    'controle_fluxo_etapa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609876" after
delete
    on
    dados_unico.pessoa
from
    contrato_092020.controle_tipo_acao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_controle_tipo_acao_cadastro_pessoa_id',
    'controle_tipo_acao',
    'pessoa',
    'UNSPECIFIED',
    'controle_tipo_acao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609877" after
update
    on
    dados_unico.pessoa
from
    contrato_092020.controle_tipo_acao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_controle_tipo_acao_cadastro_pessoa_id',
    'controle_tipo_acao',
    'pessoa',
    'UNSPECIFIED',
    'controle_tipo_acao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609921" after
delete
    on
    dados_unico.pessoa
from
    contrato_092020.controle_fluxo_etapa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'controle_fluxo_etapa',
    'pessoa',
    'UNSPECIFIED',
    'controle_fluxo_etapa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_609922" after
update
    on
    dados_unico.pessoa
from
    contrato_092020.controle_fluxo_etapa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'controle_fluxo_etapa',
    'pessoa',
    'UNSPECIFIED',
    'controle_fluxo_etapa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610046" after
delete
    on
    dados_unico.pessoa
from
    contrato_d03012022.controle_tipo_acao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_controle_tipo_acao_cadastro_pessoa_id',
    'controle_tipo_acao',
    'pessoa',
    'UNSPECIFIED',
    'controle_tipo_acao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610047" after
update
    on
    dados_unico.pessoa
from
    contrato_d03012022.controle_tipo_acao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_controle_tipo_acao_cadastro_pessoa_id',
    'controle_tipo_acao',
    'pessoa',
    'UNSPECIFIED',
    'controle_tipo_acao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610091" after
delete
    on
    dados_unico.pessoa
from
    contrato_d03012022.controle_fluxo_etapa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'controle_fluxo_etapa',
    'pessoa',
    'UNSPECIFIED',
    'controle_fluxo_etapa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610092" after
update
    on
    dados_unico.pessoa
from
    contrato_d03012022.controle_fluxo_etapa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'controle_fluxo_etapa',
    'pessoa',
    'UNSPECIFIED',
    'controle_fluxo_etapa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610216" after
delete
    on
    dados_unico.pessoa
from
    contrato_d06122021.controle_tipo_acao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_controle_tipo_acao_cadastro_pessoa_id',
    'controle_tipo_acao',
    'pessoa',
    'UNSPECIFIED',
    'controle_tipo_acao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610217" after
update
    on
    dados_unico.pessoa
from
    contrato_d06122021.controle_tipo_acao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_controle_tipo_acao_cadastro_pessoa_id',
    'controle_tipo_acao',
    'pessoa',
    'UNSPECIFIED',
    'controle_tipo_acao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610261" after
delete
    on
    dados_unico.pessoa
from
    contrato_d06122021.controle_fluxo_etapa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'controle_fluxo_etapa',
    'pessoa',
    'UNSPECIFIED',
    'controle_fluxo_etapa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610262" after
update
    on
    dados_unico.pessoa
from
    contrato_d06122021.controle_fluxo_etapa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'controle_fluxo_etapa',
    'pessoa',
    'UNSPECIFIED',
    'controle_fluxo_etapa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610391" after
delete
    on
    dados_unico.pessoa
from
    contrato_d092020.controle_tipo_acao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_controle_tipo_acao_cadastro_pessoa_id',
    'controle_tipo_acao',
    'pessoa',
    'UNSPECIFIED',
    'controle_tipo_acao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610392" after
update
    on
    dados_unico.pessoa
from
    contrato_d092020.controle_tipo_acao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_controle_tipo_acao_cadastro_pessoa_id',
    'controle_tipo_acao',
    'pessoa',
    'UNSPECIFIED',
    'controle_tipo_acao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610436" after
delete
    on
    dados_unico.pessoa
from
    contrato_d092020.controle_fluxo_etapa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'controle_fluxo_etapa',
    'pessoa',
    'UNSPECIFIED',
    'controle_fluxo_etapa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610437" after
update
    on
    dados_unico.pessoa
from
    contrato_d092020.controle_fluxo_etapa not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'controle_fluxo_etapa',
    'pessoa',
    'UNSPECIFIED',
    'controle_fluxo_etapa_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610541" after
delete
    on
    dados_unico.pessoa
from
    controle_acesso.visita_imagem not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('pessoa_id',
    'visita_imagem',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610542" after
update
    on
    dados_unico.pessoa
from
    controle_acesso.visita_imagem not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('pessoa_id',
    'visita_imagem',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610591" after
delete
    on
    dados_unico.pessoa
from
    dados_unico.feriado not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('FK_pessoa_id',
    'feriado',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610592" after
update
    on
    dados_unico.pessoa
from
    dados_unico.feriado not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('FK_pessoa_id',
    'feriado',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610671" after
delete
    on
    dados_unico.pessoa
from
    dados_unico.funcionario_evento_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_funcionario_evento_historico_alteracao_pessoa_id',
    'funcionario_evento_historico',
    'pessoa',
    'UNSPECIFIED',
    'funcionario_evento_historico_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610672" after
update
    on
    dados_unico.pessoa
from
    dados_unico.funcionario_evento_historico not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_funcionario_evento_historico_alteracao_pessoa_id',
    'funcionario_evento_historico',
    'pessoa',
    'UNSPECIFIED',
    'funcionario_evento_historico_alteracao_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610731" after
delete
    on
    dados_unico.pessoa
from
    dados_unico.profissional_externo not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'profissional_externo',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_610732" after
update
    on
    dados_unico.pessoa
from
    dados_unico.profissional_externo not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'profissional_externo',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612206" after
delete
    on
    dados_unico.pessoa
from
    redebio.atividade_renasem not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_atividade_renasem_cadastro_pessoa_id',
    'atividade_renasem',
    'pessoa',
    'UNSPECIFIED',
    'atividade_renasem_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612207" after
update
    on
    dados_unico.pessoa
from
    redebio.atividade_renasem not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_atividade_renasem_cadastro_pessoa_id',
    'atividade_renasem',
    'pessoa',
    'UNSPECIFIED',
    'atividade_renasem_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612221" after
delete
    on
    dados_unico.pessoa
from
    redebio.autor not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_autor_cadastro_pessoa_id',
    'autor',
    'pessoa',
    'UNSPECIFIED',
    'autor_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612222" after
update
    on
    dados_unico.pessoa
from
    redebio.autor not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_autor_cadastro_pessoa_id',
    'autor',
    'pessoa',
    'UNSPECIFIED',
    'autor_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612236" after
delete
    on
    dados_unico.pessoa
from
    redebio.classifica_vegetacao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_classifica_vegetacao_cadastro_pessoa_id',
    'classifica_vegetacao',
    'pessoa',
    'UNSPECIFIED',
    'classifica_vegetacao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612237" after
update
    on
    dados_unico.pessoa
from
    redebio.classifica_vegetacao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_classifica_vegetacao_cadastro_pessoa_id',
    'classifica_vegetacao',
    'pessoa',
    'UNSPECIFIED',
    'classifica_vegetacao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612256" after
delete
    on
    dados_unico.pessoa
from
    redebio.especie_autor not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_especie_autor_cadastro_pessoa_id',
    'especie_autor',
    'pessoa',
    'UNSPECIFIED',
    'especie_autor_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612257" after
update
    on
    dados_unico.pessoa
from
    redebio.especie_autor not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_especie_autor_cadastro_pessoa_id',
    'especie_autor',
    'pessoa',
    'UNSPECIFIED',
    'especie_autor_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612261" after
delete
    on
    dados_unico.pessoa
from
    redebio.especie not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_especie_cadastro_pessoa_id',
    'especie',
    'pessoa',
    'UNSPECIFIED',
    'especie_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612262" after
update
    on
    dados_unico.pessoa
from
    redebio.especie not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_especie_cadastro_pessoa_id',
    'especie',
    'pessoa',
    'UNSPECIFIED',
    'especie_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612266" after
delete
    on
    dados_unico.pessoa
from
    redebio.especie_classifica_vegetacao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_especie_classifica_vegetacao_cadastro_pessoa_id',
    'especie_classifica_vegetacao',
    'pessoa',
    'UNSPECIFIED',
    'especie_classifica_vegetacao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612267" after
update
    on
    dados_unico.pessoa
from
    redebio.especie_classifica_vegetacao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_especie_classifica_vegetacao_cadastro_pessoa_id',
    'especie_classifica_vegetacao',
    'pessoa',
    'UNSPECIFIED',
    'especie_classifica_vegetacao_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612296" after
delete
    on
    dados_unico.pessoa
from
    redebio.especie_nome_popular not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_especie_nome_popular_cadastro_pessoa_id',
    'especie_nome_popular',
    'pessoa',
    'UNSPECIFIED',
    'especie_nome_popular_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612297" after
update
    on
    dados_unico.pessoa
from
    redebio.especie_nome_popular not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_especie_nome_popular_cadastro_pessoa_id',
    'especie_nome_popular',
    'pessoa',
    'UNSPECIFIED',
    'especie_nome_popular_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612301" after
delete
    on
    dados_unico.pessoa
from
    redebio.especie_tipo_uso not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_especie_tipo_uso_cadastro_pessoa_id',
    'especie_tipo_uso',
    'pessoa',
    'UNSPECIFIED',
    'especie_tipo_uso_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612302" after
update
    on
    dados_unico.pessoa
from
    redebio.especie_tipo_uso not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_especie_tipo_uso_cadastro_pessoa_id',
    'especie_tipo_uso',
    'pessoa',
    'UNSPECIFIED',
    'especie_tipo_uso_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612306" after
delete
    on
    dados_unico.pessoa
from
    redebio.familia not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_familia_cadastro_pessoa_id',
    'familia',
    'pessoa',
    'UNSPECIFIED',
    'familia_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612307" after
update
    on
    dados_unico.pessoa
from
    redebio.familia not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_familia_cadastro_pessoa_id',
    'familia',
    'pessoa',
    'UNSPECIFIED',
    'familia_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612321" after
delete
    on
    dados_unico.pessoa
from
    redebio.genero not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_genero_cadastro_pessoa_id',
    'genero',
    'pessoa',
    'UNSPECIFIED',
    'genero_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612322" after
update
    on
    dados_unico.pessoa
from
    redebio.genero not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_genero_cadastro_pessoa_id',
    'genero',
    'pessoa',
    'UNSPECIFIED',
    'genero_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612326" after
delete
    on
    dados_unico.pessoa
from
    redebio.nome_popular not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_nome_popular_cadastro_pessoa_id',
    'nome_popular',
    'pessoa',
    'UNSPECIFIED',
    'nome_popular_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612327" after
update
    on
    dados_unico.pessoa
from
    redebio.nome_popular not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_nome_popular_cadastro_pessoa_id',
    'nome_popular',
    'pessoa',
    'UNSPECIFIED',
    'nome_popular_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612361" after
delete
    on
    dados_unico.pessoa
from
    redebio.tipo_comunidade not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_tipo_comunidade_cadastro_pessoa_id',
    'tipo_comunidade',
    'pessoa',
    'UNSPECIFIED',
    'tipo_comunidade_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612362" after
update
    on
    dados_unico.pessoa
from
    redebio.tipo_comunidade not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_tipo_comunidade_cadastro_pessoa_id',
    'tipo_comunidade',
    'pessoa',
    'UNSPECIFIED',
    'tipo_comunidade_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612376" after
delete
    on
    dados_unico.pessoa
from
    redebio.tipo_ameaca not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_tipo_de_ameaca_cadastro_pessoa_id',
    'tipo_ameaca',
    'pessoa',
    'UNSPECIFIED',
    'tipo_ameaca_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612377" after
update
    on
    dados_unico.pessoa
from
    redebio.tipo_ameaca not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_tipo_de_ameaca_cadastro_pessoa_id',
    'tipo_ameaca',
    'pessoa',
    'UNSPECIFIED',
    'tipo_ameaca_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612396" after
delete
    on
    dados_unico.pessoa
from
    redebio.tipo_parceria not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_tipo_parceria_cadastro_pessoa_id',
    'tipo_parceria',
    'pessoa',
    'UNSPECIFIED',
    'tipo_parceria_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612397" after
update
    on
    dados_unico.pessoa
from
    redebio.tipo_parceria not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_tipo_parceria_cadastro_pessoa_id',
    'tipo_parceria',
    'pessoa',
    'UNSPECIFIED',
    'tipo_parceria_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612411" after
delete
    on
    dados_unico.pessoa
from
    redebio.tipo_uso not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_tipo_uso_cadastro_pessoa_id',
    'tipo_uso',
    'pessoa',
    'UNSPECIFIED',
    'tipo_uso_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612412" after
update
    on
    dados_unico.pessoa
from
    redebio.tipo_uso not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_tipo_uso_cadastro_pessoa_id',
    'tipo_uso',
    'pessoa',
    'UNSPECIFIED',
    'tipo_uso_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612436" after
delete
    on
    dados_unico.pessoa
from
    redebio.viveiro not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_viveiro_cadastro_pessoa_id',
    'viveiro',
    'pessoa',
    'UNSPECIFIED',
    'viveiro_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612437" after
update
    on
    dados_unico.pessoa
from
    redebio.viveiro not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_viveiro_cadastro_pessoa_id',
    'viveiro',
    'pessoa',
    'UNSPECIFIED',
    'viveiro_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612441" after
delete
    on
    dados_unico.pessoa
from
    redebio.viveiro_especie not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_viveiro_especie_cadastro_pessoa_id',
    'viveiro_especie',
    'pessoa',
    'UNSPECIFIED',
    'viveiro_especie_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612442" after
update
    on
    dados_unico.pessoa
from
    redebio.viveiro_especie not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_viveiro_especie_cadastro_pessoa_id',
    'viveiro_especie',
    'pessoa',
    'UNSPECIFIED',
    'viveiro_especie_cadastro_pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612551" after
delete
    on
    dados_unico.pessoa
from
    seguranca.bloqueio_usuario not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('bloqueio_usuario_pessoa_id_fkey',
    'bloqueio_usuario',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612552" after
update
    on
    dados_unico.pessoa
from
    seguranca.bloqueio_usuario not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('bloqueio_usuario_pessoa_id_fkey',
    'bloqueio_usuario',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612556" after
delete
    on
    dados_unico.pessoa
from
    seguranca.controle_acesso not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'controle_acesso',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612557" after
update
    on
    dados_unico.pessoa
from
    seguranca.controle_acesso not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'controle_acesso',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612611" after
delete
    on
    dados_unico.pessoa
from
    solicitacao.acompanhamento_solicitacao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('FK_acompanhamento_solicitacao_pessoa',
    'acompanhamento_solicitacao',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612612" after
update
    on
    dados_unico.pessoa
from
    solicitacao.acompanhamento_solicitacao not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('FK_acompanhamento_solicitacao_pessoa',
    'acompanhamento_solicitacao',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612796" after
delete
    on
    dados_unico.pessoa
from
    sustentabilidade.usuario not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'usuario',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612797" after
update
    on
    dados_unico.pessoa
from
    sustentabilidade.usuario not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'usuario',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612801" after
delete
    on
    dados_unico.pessoa
from
    sustentabilidade.usuario_profissional not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('fk_pessoa_id',
    'usuario_profissional',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612802" after
update
    on
    dados_unico.pessoa
from
    sustentabilidade.usuario_profissional not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('fk_pessoa_id',
    'usuario_profissional',
    'pessoa',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_621634" after
delete
    on
    dados_unico.pessoa
from
    contrato.log_notificacao_vigencia not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('log_notificacao_vigencia_interessado_id_fkey',
    'log_notificacao_vigencia',
    'pessoa',
    'UNSPECIFIED',
    'interessado_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_621635" after
update
    on
    dados_unico.pessoa
from
    contrato.log_notificacao_vigencia not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('log_notificacao_vigencia_interessado_id_fkey',
    'log_notificacao_vigencia',
    'pessoa',
    'UNSPECIFIED',
    'interessado_id',
    'pessoa_id');


-- dados_unico.pessoa chaves estrangeiras

-- dados_unico.pessoa_fisica definição

-- Drop table

-- DROP TABLE dados_unico.pessoa_fisica;

CREATE TABLE dados_unico.pessoa_fisica (
	pessoa_id int4 NOT NULL,
	pessoa_fisica_sexo bpchar(1) NULL,
	pessoa_fisica_cpf varchar(20) NOT NULL,
	pessoa_fisica_dt_nasc varchar(10) DEFAULT '0' NULL,
	pessoa_fisica_rg varchar(20) DEFAULT '0' NULL,
	pessoa_fisica_rg_orgao varchar(50) DEFAULT '0' NULL,
	pessoa_fisica_rg_uf bpchar(2) DEFAULT '0' NULL,
	pessoa_fisica_rg_dt varchar(10) DEFAULT '0' NULL,
	pessoa_fisica_passaporte varchar(50) DEFAULT '0' NULL,
	pessoa_fisica_nm_pai varchar(255) DEFAULT '0' NULL,
	pessoa_fisica_nm_mae varchar(255) DEFAULT '0' NULL,
	pessoa_fisica_grupo_sanguineo varchar(3) DEFAULT '0' NULL,
	pessoa_fisica_nacionalidade varchar(50) DEFAULT '0' NULL,
	pessoa_fisica_naturalidade varchar(10) DEFAULT '0' NULL,
	pessoa_fisica_naturalidade_uf bpchar(2) DEFAULT '0' NULL,
	pessoa_fisica_clt varchar(20) DEFAULT '0' NULL,
	pessoa_fisica_clt_serie varchar(10) DEFAULT '0' NULL,
	pessoa_fisica_clt_uf bpchar(2) DEFAULT '0' NULL,
	pessoa_fisica_titulo varchar(20) DEFAULT '0' NULL,
	pessoa_fisica_titulo_zona varchar(20) DEFAULT '0' NULL,
	pessoa_fisica_titulo_secao varchar(20) DEFAULT '0' NULL,
	pessoa_fisica_titulo_cidade varchar(10) DEFAULT '0' NULL,
	pessoa_fisica_titulo_uf bpchar(2) DEFAULT '0' NULL,
	pessoa_fisica_cnh varchar(20) DEFAULT '0' NULL,
	pessoa_fisica_cnh_categoria varchar(2) DEFAULT '0' NULL,
	pessoa_fisica_cnh_validade varchar(10) DEFAULT '0' NULL,
	pessoa_fisica_reservista varchar(20) DEFAULT '0' NULL,
	pessoa_fisica_reservista_ministerio varchar(20) DEFAULT '0' NULL,
	pessoa_fisica_reservista_uf bpchar(2) DEFAULT '0' NULL,
	pessoa_fisica_pis varchar(50) DEFAULT '0' NULL,
	estado_civil_id int2 DEFAULT 0 NULL,
	nivel_escolar_id int2 DEFAULT 0 NULL,
	pessoa_fisica_funcionario numeric(1) DEFAULT 0 NULL,
	pessoa_fisica_cnh_lente_corretiva varchar(1) DEFAULT '0' NULL,
	pessoa_fisica_filho varchar(2) DEFAULT '0' NULL,
	pessoa_fisica_filha varchar(2) DEFAULT '0' NULL,
	pessoa_apelido varchar(70) DEFAULT '0' NULL,
	pessoa_fisica_foto int4 DEFAULT 0 NULL,
	pessoa_fisica_st_site int4 DEFAULT 0 NULL,
	pessoa_fisica_ano_ingresso varchar(4) DEFAULT '0' NULL,
	pessoa_fisica_represen varchar(10) DEFAULT '0' NULL,
	pessoa_fisica_represen_desc bpchar(150) DEFAULT '0' NULL,
	area_profissional_id int2 DEFAULT 51 NULL,
	cpf_valido bool DEFAULT false NULL,
	pessoa_fisica_raca_cor varchar(2) DEFAULT '0' NOT NULL,
	pessoa_fisica_grupo varchar(2) DEFAULT '0' NOT NULL,
	pessoa_fisica_delegado_eleito varchar(2) DEFAULT '0' NULL
);

-- Table Triggers

create constraint trigger "RI_ConstraintTrigger_610599" after
insert
    on
    dados_unico.pessoa_fisica
from
    curriculo.area_profissional not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('fk_area_profissional_id',
    'pessoa_fisica',
    'area_profissional',
    'UNSPECIFIED',
    'area_profissional_id',
    'area_profissional_id');
create constraint trigger "RI_ConstraintTrigger_610600" after
update
    on
    dados_unico.pessoa_fisica
from
    curriculo.area_profissional not deferrable initially immediate for each row execute procedure "RI_FKey_check_upd"('fk_area_profissional_id',
    'pessoa_fisica',
    'area_profissional',
    'UNSPECIFIED',
    'area_profissional_id',
    'area_profissional_id');
create constraint trigger "RI_ConstraintTrigger_610719" after
insert
    on
    dados_unico.pessoa_fisica
from
    dados_unico.estado_civil not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('fk_pessoa_fisica_estado_civil',
    'pessoa_fisica',
    'estado_civil',
    'UNSPECIFIED',
    'estado_civil_id',
    'estado_civil_id');
create constraint trigger "RI_ConstraintTrigger_610720" after
update
    on
    dados_unico.pessoa_fisica
from
    dados_unico.estado_civil not deferrable initially immediate for each row execute procedure "RI_FKey_check_upd"('fk_pessoa_fisica_estado_civil',
    'pessoa_fisica',
    'estado_civil',
    'UNSPECIFIED',
    'estado_civil_id',
    'estado_civil_id');
create constraint trigger "RI_ConstraintTrigger_610724" after
insert
    on
    dados_unico.pessoa_fisica
from
    dados_unico.nivel_escolar not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('fk_pessoa_fisica_nivel_escolar',
    'pessoa_fisica',
    'nivel_escolar',
    'UNSPECIFIED',
    'nivel_escolar_id',
    'nivel_escolar_id');
create constraint trigger "RI_ConstraintTrigger_610725" after
update
    on
    dados_unico.pessoa_fisica
from
    dados_unico.nivel_escolar not deferrable initially immediate for each row execute procedure "RI_FKey_check_upd"('fk_pessoa_fisica_nivel_escolar',
    'pessoa_fisica',
    'nivel_escolar',
    'UNSPECIFIED',
    'nivel_escolar_id',
    'nivel_escolar_id');
create constraint trigger "RI_ConstraintTrigger_612491" after
delete
    on
    dados_unico.pessoa_fisica
from
    rppn.procurador not deferrable initially immediate for each row execute procedure "RI_FKey_cascade_del"('procurador_id_procurado_pf_fkey',
    'procurador',
    'pessoa_fisica',
    'UNSPECIFIED',
    'id_procurado_pf',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612492" after
update
    on
    dados_unico.pessoa_fisica
from
    rppn.procurador not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('procurador_id_procurado_pf_fkey',
    'procurador',
    'pessoa_fisica',
    'UNSPECIFIED',
    'id_procurado_pf',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612496" after
delete
    on
    dados_unico.pessoa_fisica
from
    rppn.procurador not deferrable initially immediate for each row execute procedure "RI_FKey_cascade_del"('procurador_id_procurador_pf_fkey',
    'procurador',
    'pessoa_fisica',
    'UNSPECIFIED',
    'id_procurador_pf',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612497" after
update
    on
    dados_unico.pessoa_fisica
from
    rppn.procurador not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('procurador_id_procurador_pf_fkey',
    'procurador',
    'pessoa_fisica',
    'UNSPECIFIED',
    'id_procurador_pf',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612511" after
delete
    on
    dados_unico.pessoa_fisica
from
    rppn.proprietario not deferrable initially immediate for each row execute procedure "RI_FKey_setdefault_del"('proprietario_id_pessoa_fkey',
    'proprietario',
    'pessoa_fisica',
    'UNSPECIFIED',
    'id_pessoa',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612512" after
update
    on
    dados_unico.pessoa_fisica
from
    rppn.proprietario not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('proprietario_id_pessoa_fkey',
    'proprietario',
    'pessoa_fisica',
    'UNSPECIFIED',
    'id_pessoa',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612521" after
delete
    on
    dados_unico.pessoa_fisica
from
    rppn.representante_legal not deferrable initially immediate for each row execute procedure "RI_FKey_cascade_del"('representante_legal_id_pessoa_fisica_fkey',
    'representante_legal',
    'pessoa_fisica',
    'UNSPECIFIED',
    'id_pessoa_fisica',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_612522" after
update
    on
    dados_unico.pessoa_fisica
from
    rppn.representante_legal not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('representante_legal_id_pessoa_fisica_fkey',
    'representante_legal',
    'pessoa_fisica',
    'UNSPECIFIED',
    'id_pessoa_fisica',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_657173" after
delete
    on
    dados_unico.pessoa_fisica
from
    processo_sei_bahia.processo_sei_usuario not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('processo_sei_usuario_usuario_id_fkey',
    'processo_sei_usuario',
    'pessoa_fisica',
    'UNSPECIFIED',
    'usuario_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_657174" after
update
    on
    dados_unico.pessoa_fisica
from
    processo_sei_bahia.processo_sei_usuario not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('processo_sei_usuario_usuario_id_fkey',
    'processo_sei_usuario',
    'pessoa_fisica',
    'UNSPECIFIED',
    'usuario_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_741456" after
delete
    on
    dados_unico.pessoa_fisica
from
    contato.config not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('config_created_by_fkey',
    'config',
    'pessoa_fisica',
    'UNSPECIFIED',
    'created_by',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_741457" after
update
    on
    dados_unico.pessoa_fisica
from
    contato.config not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('config_created_by_fkey',
    'config',
    'pessoa_fisica',
    'UNSPECIFIED',
    'created_by',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_741461" after
delete
    on
    dados_unico.pessoa_fisica
from
    contato.config not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('config_deleted_by_fkey',
    'config',
    'pessoa_fisica',
    'UNSPECIFIED',
    'deleted_by',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_741462" after
update
    on
    dados_unico.pessoa_fisica
from
    contato.config not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('config_deleted_by_fkey',
    'config',
    'pessoa_fisica',
    'UNSPECIFIED',
    'deleted_by',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_751446" after
delete
    on
    dados_unico.pessoa_fisica
from
    dados_unico.pessoa_fisica_foto not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_del"('pessoa_fisica_foto_pessoa_id_fkey',
    'pessoa_fisica_foto',
    'pessoa_fisica',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_751447" after
update
    on
    dados_unico.pessoa_fisica
from
    dados_unico.pessoa_fisica_foto not deferrable initially immediate for each row execute procedure "RI_FKey_noaction_upd"('pessoa_fisica_foto_pessoa_id_fkey',
    'pessoa_fisica_foto',
    'pessoa_fisica',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create trigger t_pessoa_fisica_ai after
insert
    on
    dados_unico.pessoa_fisica for each row execute procedure dados_unico.f_pessoa_fisica_ai();
create trigger t_pessoa_fisica_bi before
insert
    on
    dados_unico.pessoa_fisica for each row execute procedure dados_unico.t_pessoa_fisica_bi();


-- dados_unico.pessoa_fisica chaves estrangeiras

-- dados_unico.pessoa_fisica_foto definição

-- Drop table

-- DROP TABLE dados_unico.pessoa_fisica_foto;

CREATE TABLE dados_unico.pessoa_fisica_foto (
	pessoa_fisica_foto_id serial4 NOT NULL,
	pessoa_id int8 NOT NULL,
	foto varchar DEFAULT ''::character varying NULL,
	foto_hash varchar DEFAULT ''::character varying NULL,
	created_at timestamptz DEFAULT now() NULL,
	deleted_at timestamptz NULL,
	created_by int8 DEFAULT 9 NULL,
	deleted_by int8 NULL
);

-- Table Triggers

create constraint trigger "RI_ConstraintTrigger_751444" after
insert
    on
    dados_unico.pessoa_fisica_foto
from
    dados_unico.pessoa_fisica not deferrable initially immediate for each row execute procedure "RI_FKey_check_ins"('pessoa_fisica_foto_pessoa_id_fkey',
    'pessoa_fisica_foto',
    'pessoa_fisica',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');
create constraint trigger "RI_ConstraintTrigger_751445" after
update
    on
    dados_unico.pessoa_fisica_foto
from
    dados_unico.pessoa_fisica not deferrable initially immediate for each row execute procedure "RI_FKey_check_upd"('pessoa_fisica_foto_pessoa_id_fkey',
    'pessoa_fisica_foto',
    'pessoa_fisica',
    'UNSPECIFIED',
    'pessoa_id',
    'pessoa_id');


-- dados_unico.pessoa_fisica_foto chaves estrangeiras