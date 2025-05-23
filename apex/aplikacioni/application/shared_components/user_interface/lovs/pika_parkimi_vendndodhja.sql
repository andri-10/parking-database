prompt --application/shared_components/user_interface/lovs/pika_parkimi_vendndodhja
begin
--   Manifest
--     PIKA_PARKIMI.VENDNDODHJA
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
 p_id=>wwv_flow_imp.id(38324836772357802505)
,p_lov_name=>'PIKA_PARKIMI.VENDNDODHJA'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'PIKA_PARKIMI'
,p_return_column_name=>'PIKA_PARKIMI_ID'
,p_display_column_name=>'VENDNDODHJA'
,p_default_sort_column_name=>'VENDNDODHJA'
,p_default_sort_direction=>'ASC'
,p_version_scn=>15622335582435
);
wwv_flow_imp.component_end;
end;
/
