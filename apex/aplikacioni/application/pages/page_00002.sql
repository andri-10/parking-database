prompt --application/pages/page_00002
begin
--   Manifest
--     PAGE: 00002
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
 p_id=>2
,p_name=>'Parking Dashboard'
,p_alias=>'PARKING-DASHBOARD'
,p_step_title=>'Parking Dashboard'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'23'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37898633162105887203)
,p_plug_name=>'Aktvitetet e Parkimit'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(37898633278832887204)
,p_region_id=>wwv_flow_imp.id(37898633162105887203)
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
 p_id=>wwv_flow_imp.id(37898633356498887205)
,p_chart_id=>wwv_flow_imp.id(37898633278832887204)
,p_seq=>10
,p_name=>'Llojet e aktiviteteve'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
unistr('    ''Automjete n\00EB parkim'' AS kategoria,'),
'    COUNT(*) AS vlera',
'FROM aktiviteti_parkimit',
'WHERE koha_daljes IS NULL',
'UNION ALL',
'SELECT ',
unistr('    ''Dalje t\00EB sotme'' AS kategoria,'),
'    COUNT(*) AS vlera',
'FROM aktiviteti_parkimit',
'WHERE koha_daljes IS NOT NULL ',
'AND TRUNC(koha_daljes) = TRUNC(SYSDATE)',
'UNION ALL',
'SELECT ',
'    ''Rezervime aktive'' AS kategoria,',
'    COUNT(*) AS vlera',
'FROM rezervime',
'WHERE statusi_rezervimit = ''Aktiv''',
'UNION ALL',
'SELECT ',
unistr('    ''Klient\00EB me abonim'' AS kategoria,'),
'    COUNT(*) AS vlera',
'FROM abonimet',
'WHERE statusi = ''Aktiv'''))
,p_items_value_column_name=>'VLERA'
,p_items_label_column_name=>'KATEGORIA'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'LABEL'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38005315561527713425)
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
 p_id=>wwv_flow_imp.id(38005316249926713426)
,p_plug_name=>'Statusi i Parkimit'
,p_title=>'Statusi i Parkimit'
,p_region_template_options=>'#DEFAULT#:t-CardsRegion--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2072724515482255512
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    pika_parkimi_id,',
'    vendndodhja,',
'    vende_total,',
'    vende_zene,',
'    vende_lire,',
unistr('    vende_lire || '' vende t\00EB lira nga '' || vende_total || '' gjithsej'' as info_vendeve'),
'FROM pika_parkimi',
'WHERE is_active = ''Y''',
'ORDER BY vendndodhja'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CARDS'
,p_plug_query_num_rows_type=>'SCROLL'
,p_show_total_row_count=>false
);
wwv_flow_imp_page.create_card(
 p_id=>wwv_flow_imp.id(37974895128442885607)
,p_region_id=>wwv_flow_imp.id(38005316249926713426)
,p_layout_type=>'GRID'
,p_title_adv_formatting=>false
,p_title_column_name=>'VENDNDODHJA'
,p_sub_title_adv_formatting=>false
,p_sub_title_column_name=>'INFO_VENDEVE'
,p_body_adv_formatting=>false
,p_second_body_adv_formatting=>false
,p_icon_source_type=>'STATIC_CLASS'
,p_icon_css_classes=>'fa-car'
,p_icon_position=>'START'
,p_badge_column_name=>'VENDE_LIRE'
,p_media_adv_formatting=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38005320470401713430)
,p_plug_name=>'Statistikat e Klienteve'
,p_title=>'Statistikat e Klienteve'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc:t-Form--leftLabels'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>30
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    k.emri || '' '' || k.mbiemri AS klienti,',
'    COUNT(ap.aktiviteti_id) AS numri_vizitave,',
'    TO_CHAR(MAX(ap.koha_hyrjes), ''DD-MM-YYYY'') AS vizita_fundit,',
'    SUM(NVL(ap.pagesa_total, 0)) AS shuma_totale,',
'    COUNT(DISTINCT a.automjet_id) AS numri_automjeteve',
'FROM klientet k',
'LEFT JOIN aktiviteti_parkimit ap ON k.klient_id = ap.klient_id',
'LEFT JOIN automjetet a ON k.klient_id = a.klient_id',
'GROUP BY k.klient_id, k.emri, k.mbiemri',
'ORDER BY numri_vizitave DESC'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Statistikat e Klienteve'
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
 p_id=>wwv_flow_imp.id(37974895216398885608)
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
,p_internal_uid=>37974895216398885608
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974895332180885609)
,p_db_column_name=>'KLIENTI'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Klienti'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974895483341885610)
,p_db_column_name=>'NUMRI_VIZITAVE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Numri Vizitave'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37974895505599885611)
,p_db_column_name=>'VIZITA_FUNDIT'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Vizita Fundit'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37898633631265887208)
,p_db_column_name=>'SHUMA_TOTALE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Shuma Totale'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37898633757721887209)
,p_db_column_name=>'NUMRI_AUTOMJETEVE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Numri Automjeteve'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(38013565311609571524)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'380135654'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'KLIENTI:NUMRI_VIZITAVE:VIZITA_FUNDIT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38005323135475713432)
,p_plug_name=>'Te ardhurat e fundit'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    k.emri || '' '' || k.mbiemri AS klienti,',
'    COUNT(ap.aktiviteti_id) AS numri_vizitave,',
'    TO_CHAR(MAX(ap.koha_hyrjes), ''DD-MM-YYYY'') AS vizita_fundit',
'FROM klientet k',
'LEFT JOIN aktiviteti_parkimit ap ON k.klient_id = ap.klient_id',
'GROUP BY k.klient_id, k.emri, k.mbiemri',
'ORDER BY COUNT(ap.aktiviteti_id) DESC NULLS LAST',
'FETCH FIRST 5 ROWS ONLY'))
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(38005323584040713432)
,p_region_id=>wwv_flow_imp.id(38005323135475713432)
,p_chart_type=>'bar'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'off'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(38005325226876713433)
,p_chart_id=>wwv_flow_imp.id(38005323584040713432)
,p_seq=>10
,p_name=>'Te ardhurat ditore'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    TO_CHAR(t.data_transaksionit, ''DD-MM'') AS dita,',
'    SUM(t.shuma) AS shuma_totale,',
'    COUNT(DISTINCT t.aktiviteti_id) AS numri_transaksioneve,',
'    COUNT(DISTINCT k.klient_id) AS numri_klienteve,',
'    ROUND(AVG(t.shuma), 2) AS mesatarja_transaksionit,',
'    MAX(pp.vendndodhja) AS pika_me_shume_te_ardhura',
'FROM transaksionet t',
'JOIN aktiviteti_parkimit ap ON t.aktiviteti_id = ap.aktiviteti_id',
'JOIN klientet k ON ap.klient_id = k.klient_id',
'JOIN pika_parkimi pp ON t.pika_parkimi_id = pp.pika_parkimi_id',
'WHERE t.data_transaksionit > SYSDATE - 7',
'GROUP BY TO_CHAR(t.data_transaksionit, ''DD-MM'')',
'ORDER BY MIN(t.data_transaksionit)'))
,p_max_row_count=>20
,p_items_value_column_name=>'SHUMA_TOTALE'
,p_items_label_column_name=>'DITA'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(38005324000903713433)
,p_chart_id=>wwv_flow_imp.id(38005323584040713432)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title=>'Ditet e Muajit'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(38005324613699713433)
,p_chart_id=>wwv_flow_imp.id(38005323584040713432)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title=>'Totali i te ardhurave (Lek)'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp.component_end;
end;
/
