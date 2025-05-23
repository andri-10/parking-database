prompt --application/pages/page_00016
begin
--   Manifest
--     PAGE: 00016
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
 p_id=>16
,p_name=>'Shto Rezervim'
,p_alias=>'SHTO-REZERVIM'
,p_step_title=>'Shto Rezervim'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(38449969495623351054)
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
 p_id=>wwv_flow_imp.id(38449970225294351181)
,p_plug_name=>'Shto Rezervim'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'REZERVIME'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38449977923262351190)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'CHANGE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P16_REZERVIME_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38449976904523351190)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38449978335852351190)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P16_REZERVIME_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38449977507758351190)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_alignment=>'RIGHT'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P16_REZERVIME_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(38449978631928351191)
,p_branch_action=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38449970588418351181)
,p_name=>'P16_REZERVIME_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_item_source_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Rezervime Id'
,p_source=>'REZERVIME_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38449970970138351184)
,p_name=>'P16_KLIENT_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_item_source_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Klient Id'
,p_source=>'KLIENT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'KLIENTET.EMRI'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38449971349718351184)
,p_name=>'P16_PIKA_PARKIMI_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_item_source_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Pika Parkimi Id'
,p_source=>'PIKA_PARKIMI_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'PIKA_PARKIMI.VENDNDODHJA'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38449971722297351185)
,p_name=>'P16_AUTOMJET_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_item_source_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_prompt=>'Automjet Id'
,p_source=>'AUTOMJET_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    a.marka || '' '' || a.modeli || '' ('' || a.targa || '')'' AS display_value,',
'    a.automjet_id AS return_value',
'FROM automjetet a',
'JOIN klientet k ON a.klient_id = k.klient_id',
'ORDER BY k.emri, k.mbiemri, a.marka, a.modeli'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38449972180238351185)
,p_name=>'P16_DATA_REZERVIMIT'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_item_source_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_prompt=>'Data Rezervimit'
,p_format_mask=>'DD-MON-YYYY'
,p_source=>'DATA_REZERVIMIT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38449972592256351186)
,p_name=>'P16_KOHA_FILLIMIT'
,p_source_data_type=>'TIMESTAMP'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_item_source_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_prompt=>'Koha Fillimit'
,p_source=>'KOHA_FILLIMIT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    TO_CHAR(TRUNC(SYSDATE) + (LEVEL-1)/48, ''HH24:MI'') AS display_value,',
'    TO_CHAR(TRUNC(SYSDATE) + (LEVEL-1)/48, ''HH24:MI'') AS return_value',
'FROM dual',
'CONNECT BY LEVEL <= 48'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38449973337316351187)
,p_name=>'P16_KOHA_MBARIMIT'
,p_source_data_type=>'TIMESTAMP'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_item_source_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_prompt=>'Koha Mbarimit'
,p_source=>'KOHA_MBARIMIT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    TO_CHAR(TRUNC(SYSDATE) + (LEVEL-1)/48, ''HH24:MI'') AS display_value,',
'    TO_CHAR(TRUNC(SYSDATE) + (LEVEL-1)/48, ''HH24:MI'') AS return_value',
'FROM dual',
'CONNECT BY LEVEL <= 48'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(38449974120627351188)
,p_name=>'P16_STATUSI_REZERVIMIT'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_item_source_plug_id=>wwv_flow_imp.id(38449970225294351181)
,p_prompt=>'Statusi Rezervimit'
,p_source=>'STATUSI_REZERVIMIT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    ''Aktiv'' AS display_value,',
'    ''Aktiv'' AS return_value',
'FROM dual',
'UNION ALL',
'SELECT ',
'    ''Anuluar'' AS display_value,',
'    ''Anuluar'' AS return_value',
'FROM dual',
'UNION ALL',
'SELECT ',
unistr('    ''P\00EBrfunduar'' AS display_value,'),
unistr('    ''P\00EBrfunduar'' AS return_value'),
'FROM dual'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(38449973001758351187)
,p_validation_name=>'P16_KOHA_FILLIMIT must be timestamp'
,p_validation_sequence=>50
,p_validation=>'P16_KOHA_FILLIMIT'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(38449972592256351186)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(38449973822949351187)
,p_validation_name=>'P16_KOHA_MBARIMIT must be timestamp'
,p_validation_sequence=>60
,p_validation=>'P16_KOHA_MBARIMIT'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(38449973337316351187)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(37974896984498885625)
,p_validation_name=>'Validimi i Pronesise se Automjetit'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  v_klient_id NUMBER;',
'BEGIN',
'  SELECT klient_id INTO v_klient_id',
'  FROM automjetet',
'  WHERE automjet_id = :P9_AUTOMJET_ID;',
'  ',
'  IF v_klient_id != :P9_KLIENT_ID THEN',
unistr('    RETURN ''Automjeti i zgjedhur nuk i p\00EBrket k\00EBtij klienti.'';'),
'  END IF;',
'  ',
'  RETURN NULL;',
'EXCEPTION',
'  WHEN NO_DATA_FOUND THEN',
'    RETURN ''Automjeti i zgjedhur nuk ekziston.'';',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'Automjeti nuk i perket ketij klienti.'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38449979588854351192)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(38449970225294351181)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Shto Rezervim'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>38449979588854351192
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(37974897010432885626)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Krijo Rezervim'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  v_rezervim_id NUMBER;',
'  v_rezultati VARCHAR2(4000);',
'  v_koha_fillimit TIMESTAMP;',
'  v_koha_mbarimit TIMESTAMP;',
'BEGIN',
'  -- Combine date and time',
'  v_koha_fillimit := TO_TIMESTAMP(:P9_KOHA_FILLIMIT_DATE || '' '' || :P9_KOHA_FILLIMIT_TIME, ''DD-MM-YYYY HH24:MI'');',
'  v_koha_mbarimit := TO_TIMESTAMP(:P9_KOHA_MBARIMIT_DATE || '' '' || :P9_KOHA_MBARIMIT_TIME, ''DD-MM-YYYY HH24:MI'');',
'  ',
'  -- Call the procedure',
'  krijo_rezervim(',
'    p_klient_id => :P9_KLIENT_ID,',
'    p_pika_parkimi_id => :P9_PIKA_PARKIMI_ID,',
'    p_automjet_id => :P9_AUTOMJET_ID,',
'    p_koha_fillimit => v_koha_fillimit,',
'    p_koha_mbarimit => v_koha_mbarimit,',
'    p_rezervim_id => v_rezervim_id,',
'    p_rezultati => v_rezultati',
'  );',
'  ',
'  IF v_rezervim_id IS NOT NULL THEN',
'    -- Success',
'    :P9_REZERVIM_ID := v_rezervim_id;',
'    apex_application.g_print_success_message := v_rezultati;',
'    -- Redirect to the report page',
'    apex_util.redirect_url(''f?p='' || :APP_ID || '':8:'' || :APP_SESSION);',
'  ELSE',
'    -- Error',
'    apex_error.add_error(',
'      p_message => v_rezultati,',
'      p_display_location => apex_error.c_inline_in_notification',
'    );',
'  END IF;',
'EXCEPTION',
'  WHEN OTHERS THEN',
'    apex_error.add_error(',
'      p_message => ''Gabim: '' || SQLERRM,',
'      p_display_location => apex_error.c_inline_in_notification',
'    );',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>37974897010432885626
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(38449979170168351191)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(38449970225294351181)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Shto Rezervim'
,p_internal_uid=>38449979170168351191
);
wwv_flow_imp.component_end;
end;
/
