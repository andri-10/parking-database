prompt --application/pages/page_00007
begin
--   Manifest
--     PAGE: 00007
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.5'
,p_default_workspace_id=>37849804862927571566
,p_default_application_id=>168290
,p_default_id_offset=>0
,p_default_owner=>'WKSP_SISTEMPARKIMI'
);
wwv_flow_imp_page.create_page(
 p_id=>7
,p_name=>'Menaxhimi i Rezervimeve'
,p_alias=>'MENAXHIMI-I-REZERVIMEVE'
,p_step_title=>'Menaxhimi i Rezervimeve'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38449037013348048033)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(38005191915980707976)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38449037747787048035)
,p_plug_name=>'Menaxhimi i Rezervimeve'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    r.rezervime_id,',
'    k.emri || '' '' || k.mbiemri AS klienti,',
'    pp.vendndodhja AS pika_parkimit,',
'    a.marka || '' '' || a.modeli || '' ('' || a.targa || '')'' AS automjeti,',
'    TO_CHAR(r.koha_fillimit, ''DD-MM-YYYY HH24:MI'') AS koha_fillimit,',
'    TO_CHAR(r.koha_mbarimit, ''DD-MM-YYYY HH24:MI'') AS koha_mbarimit,',
'    r.statusi_rezervimit',
'FROM rezervime r',
'JOIN klientet k ON r.klient_id = k.klient_id',
'JOIN pika_parkimi pp ON r.pika_parkimi_id = pp.pika_parkimi_id',
'JOIN automjetet a ON r.automjet_id = a.automjet_id',
'ORDER BY r.koha_fillimit DESC'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Menaxhimi i Rezervimeve'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(38449037898753048035)
,p_name=>'Menaxhimi i Rezervimeve'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'A.HALILI2004@GMAIL.COM'
,p_internal_uid=>38449037898753048035
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38449038875163048191)
,p_db_column_name=>'REZERVIME_ID'
,p_display_order=>0
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'Rezervime ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38449041682456048195)
,p_db_column_name=>'STATUSI_REZERVIMIT'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Statusi Rezervimit'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974896369620885619)
,p_db_column_name=>'KLIENTI'
,p_display_order=>18
,p_column_identifier=>'I'
,p_column_label=>'Klienti'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974896427557885620)
,p_db_column_name=>'PIKA_PARKIMIT'
,p_display_order=>28
,p_column_identifier=>'J'
,p_column_label=>'Pika Parkimit'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974896515692885621)
,p_db_column_name=>'AUTOMJETI'
,p_display_order=>38
,p_column_identifier=>'K'
,p_column_label=>'Automjeti'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974896672490885622)
,p_db_column_name=>'KOHA_FILLIMIT'
,p_display_order=>48
,p_column_identifier=>'L'
,p_column_label=>'Koha Fillimit'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974896777925885623)
,p_db_column_name=>'KOHA_MBARIMIT'
,p_display_order=>58
,p_column_identifier=>'M'
,p_column_label=>'Koha Mbarimit'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(38449053127521050574)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'384490532'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'REZERVIME_ID:STATUSI_REZERVIMIT:KLIENTI:PIKA_PARKIMIT:AUTOMJETI:KOHA_FILLIMIT:KOHA_MBARIMIT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37974896898775885624)
,p_button_sequence=>20
,p_button_name=>'Rezervo'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Shto Rezervim'
,p_button_redirect_url=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.:9:9:'
,p_icon_css_classes=>'fa-plus-square'
,p_grid_new_row=>'Y'
);
wwv_flow_imp.component_end;
end;
/
