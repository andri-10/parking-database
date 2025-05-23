prompt --application/pages/page_00010
begin
--   Manifest
--     PAGE: 00010
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
 p_id=>10
,p_name=>'Raportet e Parkimit'
,p_alias=>'RAPORTET-E-PARKIMIT'
,p_step_title=>'Raportet e Parkimit'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38453220800896171154)
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
 p_id=>wwv_flow_imp.id(38453221565432171155)
,p_plug_name=>'Statusi Aktual i Parkimit'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    vendndodhja,',
'    vende_total,',
'    vende_zene,',
'    vende_lire,',
'    automjete_aktive,',
'    sot_te_hyra',
'FROM vw_dashboard_parkimi',
'ORDER BY vendndodhja'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(37974897103304885627)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'A.HALILI2004@GMAIL.COM'
,p_internal_uid=>37974897103304885627
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974897279092885628)
,p_db_column_name=>'VENDNDODHJA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Vendndodhja'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974897370102885629)
,p_db_column_name=>'VENDE_TOTAL'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Vende Total'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974897429032885630)
,p_db_column_name=>'VENDE_ZENE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Vende Zene'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974897599983885631)
,p_db_column_name=>'VENDE_LIRE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Vende Lire'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974897699871885632)
,p_db_column_name=>'AUTOMJETE_AKTIVE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Automjete Aktive'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38453419531421189707)
,p_db_column_name=>'SOT_TE_HYRA'
,p_display_order=>60
,p_column_identifier=>'H'
,p_column_label=>'Sot Te Hyra'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(38453424555631190135)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'384534246'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'VENDNDODHJA:VENDE_TOTAL:VENDE_ZENE:VENDE_LIRE:AUTOMJETE_AKTIVE'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38453224218202171158)
,p_plug_name=>'Permbledhje Financiare'
,p_title=>'Permbledhje Financiare'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    muaji,',
'    SUM(te_hyrat_totale) AS te_hyrat_totale,',
'    SUM(numri_transaksioneve) AS transaksione_totale,',
'    SUM(automjete_unik) AS automjete_unik',
'FROM vw_raporti_financiar',
'GROUP BY muaji',
'ORDER BY muaji DESC'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Permbledhje Financiare'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(37974897891526885634)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'A.HALILI2004@GMAIL.COM'
,p_internal_uid=>37974897891526885634
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974897985623885635)
,p_db_column_name=>'MUAJI'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Muaji'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974898044629885636)
,p_db_column_name=>'TE_HYRAT_TOTALE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Te Hyrat Totale'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974898158126885637)
,p_db_column_name=>'TRANSAKSIONE_TOTALE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Transaksione Totale'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974898205138885638)
,p_db_column_name=>'AUTOMJETE_UNIK'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Automjete Unik'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(38453425002102190158)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'384534251'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'MUAJI:TE_HYRAT_TOTALE:TRANSAKSIONE_TOTALE:AUTOMJETE_UNIK'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38453225713542171159)
,p_plug_name=>'Permbledhje Financiare sipas vendndodhjes'
,p_title=>'Permbledhje Financiare sipas vendndodhjes'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_escape_on_http_output=>'Y'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>30
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    vendndodhja,',
'    SUM(te_hyrat_totale) AS te_hyrat_totale',
'FROM vw_raporti_financiar',
'WHERE muaji = TO_CHAR(SYSDATE, ''YYYY-MM'')',
'GROUP BY vendndodhja',
'ORDER BY te_hyrat_totale DESC'))
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(37974898990177885645)
,p_region_id=>wwv_flow_imp.id(38453225713542171159)
,p_chart_type=>'pie'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_value_format_type=>'decimal'
,p_value_decimal_places=>0
,p_value_format_scaling=>'none'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(37974899087588885646)
,p_chart_id=>wwv_flow_imp.id(37974898990177885645)
,p_seq=>10
,p_name=>'Permbledhje Financiare sipas vendndodhjes'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    vendndodhja,',
'    SUM(te_hyrat_totale) AS te_hyrat_totale',
'FROM vw_raporti_financiar',
'WHERE muaji = TO_CHAR(SYSDATE, ''YYYY-MM'')',
'GROUP BY vendndodhja',
'ORDER BY te_hyrat_totale DESC'))
,p_items_value_column_name=>'TE_HYRAT_TOTALE'
,p_items_label_column_name=>'VENDNDODHJA'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'LABEL'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38453228424078171161)
,p_plug_name=>'Performanca e Stafit'
,p_title=>'Performanca e Stafit'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    emri_mbiemri,',
'    vendndodhja,',
'    transaksione,',
'    te_hyra_totale,',
'    dite_pune,',
'    te_hyra_per_dite',
'FROM vw_performanca_punonjes',
'ORDER BY te_hyra_totale DESC'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Performanca e Stafit'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(37974899377284885649)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'A.HALILI2004@GMAIL.COM'
,p_internal_uid=>37974899377284885649
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974899487309885650)
,p_db_column_name=>'EMRI_MBIEMRI'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Emri Mbiemri'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38453418928334189701)
,p_db_column_name=>'VENDNDODHJA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Vendndodhja'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38453419089975189702)
,p_db_column_name=>'TRANSAKSIONE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Transaksione'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38453419112161189703)
,p_db_column_name=>'TE_HYRA_TOTALE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Te Hyra Totale'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38453419272777189704)
,p_db_column_name=>'DITE_PUNE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Dite Pune'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(38453419321868189705)
,p_db_column_name=>'TE_HYRA_PER_DITE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Te Hyra Per Dite'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(38453425784568190177)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'384534258'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMRI_MBIEMRI:VENDNDODHJA:TRANSAKSIONE:TE_HYRA_TOTALE:DITE_PUNE:TE_HYRA_PER_DITE'
);
wwv_flow_imp.component_end;
end;
/
