/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     07/08/2017 17:32:27                          */
/*==============================================================*/
CREATE database CAJACHICAESFOT
USE CAJACHICAESFOT
drop table if exists CAB_FACTURA;

drop table if exists CAB_REPOSICION;

drop table if exists CAB_RETENCION;

drop table if exists CAB_SOLICITUD;

drop table if exists CAJA_CHICA;

drop table if exists DET_FACTURA;

drop table if exists DET_REPOSICION;

drop table if exists DET_RETENCION;

drop table if exists DET_SOLICITUD;

drop table if exists INSUMOS;

drop table if exists USUARIOS;

/*==============================================================*/
/* Table: CAB_FACTURA                                           */
/*==============================================================*/
create table CAB_FACTURA
(
   CODCABFACT           numeric(5,0) not null,
   CODCABSOL            numeric(5,0) not null,
   CODCABRET            numeric(5,0),
   FECCABFACT           date not null,
   RUCCABFACT           numeric(13,0) not null,
   BINFACT              longblob,
   primary key (CODCABFACT)
);

/*==============================================================*/
/* Table: CAB_REPOSICION                                        */
/*==============================================================*/
create table CAB_REPOSICION
(
   CODREPO              numeric(5,0) not null,
   CODCACHI             numeric(5,0),
   ENTICABREPO          varchar(25),
   FECCABREPO           varchar(25),
   BINREPO              longblob,
   primary key (CODREPO)
);

/*==============================================================*/
/* Table: CAB_RETENCION                                         */
/*==============================================================*/
create table CAB_RETENCION
(
   CODCABRET            numeric(5,0) not null,
   CODCABFACT           numeric(5,0) not null,
   FECCABRET            date not null,
   NOMCOMCABRET         varchar(25) not null,
   NOMEMICABRET         varchar(25) not null,
   BINRET               longblob,
   primary key (CODCABRET)
);

/*==============================================================*/
/* Table: CAB_SOLICITUD                                         */
/*==============================================================*/
create table CAB_SOLICITUD
(
   CODCABSOL            numeric(5,0) not null,
   CODUSU               numeric(5,0),
   FECCABSOL            date not null,
   NOMCABSOL            varchar(25) not null,
   ESTADOCABSOL         varchar(25) not null,
   RUCCABSOL            numeric(10,0),
   BINSOL               longblob,
   primary key (CODCABSOL)
);

/*==============================================================*/
/* Table: CAJA_CHICA                                            */
/*==============================================================*/
create table CAJA_CHICA
(
   CODCACHI             numeric(5,0) not null,
   CODUSU               numeric(5,0),
   TOTALCACHI           float(10),
   primary key (CODCACHI)
);

/*==============================================================*/
/* Table: DET_FACTURA                                           */
/*==============================================================*/
create table DET_FACTURA
(
   IDDETFACT            numeric(5,0) not null,
   CODCABFACT           numeric(5,0),
   CODPRODDETFACT       numeric(5,0) not null,
   CANPRODDETFACT       numeric(5,0) not null,
   TOTALDETFACT         float(10) not null,
   PREUNIPRODDETFACT    float(10) not null,
   SUBTOTALDETFACT      float(10) not null,
   IVADETFACT           float(10) not null,
   primary key (IDDETFACT)
);

/*==============================================================*/
/* Table: DET_REPOSICION                                        */
/*==============================================================*/
create table DET_REPOSICION
(
   CODDETREPO           numeric(5,0) not null,
   CODREPO              numeric(5,0),
   CANTREPO             float(10),
   primary key (CODDETREPO)
);

/*==============================================================*/
/* Table: DET_RETENCION                                         */
/*==============================================================*/
create table DET_RETENCION
(
   IDDETRET             numeric(5,0) not null,
   CODCABRET            numeric(5,0),
   TIPOCOMDETRET        varchar(25) not null,
   PERIODOFISDETRET     numeric(4,0) not null,
   IMPDETRET            varchar(25) not null,
   PORDETRET            float(5) not null,
   VALORDETRET          float(10) not null,
   FECDOCDETRET         date not null,
   CODDOCDETRET         numeric(10,0) not null,
   BASEDETRET           float(10) not null,
   primary key (IDDETRET)
);

/*==============================================================*/
/* Table: DET_SOLICITUD                                         */
/*==============================================================*/
create table DET_SOLICITUD
(
   CODDETSOL            numeric(5,0) not null,
   CODCABSOL            numeric(5,0),
   PRODETSOL            varchar(25) not null,
   CANDETSOL            varchar(25) not null,
   primary key (CODDETSOL)
);

/*==============================================================*/
/* Table: INSUMOS                                               */
/*==============================================================*/
create table INSUMOS
(
   CODINS               numeric(5,0) not null,
   IDDETFACT            numeric(5,0) not null,
   CODDETSOL            numeric(5,0),
   NOMINS               varchar(25) not null,
   CANINS               varchar(25) not null,
   PRECIOINS            float(25,0),
   primary key (CODINS)
);

/*==============================================================*/
/* Table: USUARIOS                                              */
/*==============================================================*/
create table USUARIOS
(
   CODUSU               numeric(5,0) not null,
   NOMUSU               varchar(25),
   APELLUSU             varchar(25),
   NICKUSU              varchar(25),
   PASSUSU              varchar(25),
   CATEUSU              varchar(25),
   IDUSU                numeric(10,0),
   primary key (CODUSU)
);

alter table CAB_FACTURA add constraint FK_ASIGNA foreign key (CODCABRET)
      references CAB_RETENCION (CODCABRET);

alter table CAB_FACTURA add constraint FK_LIGADO foreign key (CODCABSOL)
      references CAB_SOLICITUD (CODCABSOL);

alter table CAB_REPOSICION add constraint FK_TENDRA foreign key (CODCACHI)
      references CAJA_CHICA (CODCACHI);

alter table CAB_RETENCION add constraint FK_ASIGNA2 foreign key (CODCABFACT)
      references CAB_FACTURA (CODCABFACT);

alter table CAB_SOLICITUD add constraint FK_REALIZAN foreign key (CODUSU)
      references USUARIOS (CODUSU);

alter table CAJA_CHICA add constraint FK_ACCEDEN foreign key (CODUSU)
      references USUARIOS (CODUSU);

alter table DET_FACTURA add constraint FK_COMPONE foreign key (CODCABFACT)
      references CAB_FACTURA (CODCABFACT);

alter table DET_REPOSICION add constraint FK_CORRESPONDE foreign key (CODREPO)
      references CAB_REPOSICION (CODREPO);

alter table DET_RETENCION add constraint FK_AGREGAN foreign key (CODCABRET)
      references CAB_RETENCION (CODCABRET);

alter table DET_SOLICITUD add constraint FK_TIENE foreign key (CODCABSOL)
      references CAB_SOLICITUD (CODCABSOL);

alter table INSUMOS add constraint FK_ANADEN foreign key (CODDETSOL)
      references DET_SOLICITUD (CODDETSOL);

alter table INSUMOS add constraint FK_OBTIENEN foreign key (IDDETFACT)
      references DET_FACTURA (IDDETFACT);

