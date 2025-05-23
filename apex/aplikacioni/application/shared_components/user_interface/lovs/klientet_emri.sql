prompt --application/shared_components/user_interface/lovs/klientet_emri
begin
--   Manifest
--     KLIENTET.EMRI
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.5'
,p_default_workspace_id=>37849804862927571566
,p_default_application_id=>168290
,p_default_id_offset=>0
,p_default_owner=>'WKSP_SISTEMPARKIMI'
);
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(38018849101211953248)
,p_lov_name=>'KLIENTET.EMRI'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'KLIENTET'
,p_return_column_name=>'KLIENT_ID'
,p_display_column_name=>'EMRI'
,p_default_sort_column_name=>'EMRI'
,p_default_sort_direction=>'ASC'
,p_version_scn=>15622182260601
);
wwv_flow_imp.component_end;
end;
/
