------------------------------------------------------------------------------
--	FILE:	 config.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Config Database adjustment for front-end
------------------------------------------------------------------------------
--==============================================================================================
--******								ADDITIONAL CONFIG								******
--==============================================================================================

UPDATE Parameters SET Visible=0 WHERE Key2 IN ('RULESET_STANDARD', 'RULESET_EXPANSION_1', 'RULESET_EXPANSION_2') AND ConfigurationId='GAME_NO_BARBARIANS';

-- Beta
INSERT INTO Parameters(ParameterId, Name, Description, Domain, DefaultValue, ConfigurationGroup, ConfigurationId, GroupId, SortIndex) VALUES
    ('BETA_FEATURE_TERRAIN', 'LOC_BBG_FRONT_BETA_FEATURE_TERRAIN_NAME', 'LOC_BBG_FRONT_BETA_FEATURE_TERRAIN_DESC', 'bool', '0', 'Game', 'BETA_FEATURE_TERRAIN', 'AdvancedOptions', '20000'),
    ('BETA_LIMES', 'LOC_BBG_FRONT_BETA_LIMES_NAME', 'LOC_BBG_FRONT_BETA_LIMES_DESC', 'bool', '1', 'Game', 'BETA_LIMES', 'AdvancedOptions', '20040'),
    ('BETA_MAX_FORTIFY', 'LOC_BBG_FRONT_BETA_MAX_FORTIFY_NAME', 'LOC_BBG_FRONT_BETA_MAX_FORTIFY_DESC', 'bool', '0', 'Game', 'BETA_MAX_FORTIFY', 'AdvancedOptions', '20010'),
    ('BETA_NAVAL_PROD', 'LOC_BBG_FRONT_BETA_NAVAL_PROD_NAME', 'LOC_BBG_FRONT_BETA_NAVAL_PROD_DESC', 'bool', '0', 'Game', 'BETA_NAVAL_PROD', 'AdvancedOptions', '20050'),
    ('BETA_NO_SUPPORT_RANGE', 'LOC_BBG_FRONT_BETA_NO_SUPPORT_RANGE_NAME', 'LOC_BBG_FRONT_BETA_NO_SUPPORT_RANGE_DESC', 'bool', '1', 'Game', 'BETA_NO_SUPPORT_RANGE', 'AdvancedOptions', '20030'),
    ('BETA_SUPPORT', 'LOC_BBG_FRONT_BETA_SUPPORT_NAME', 'LOC_BBG_FRONT_BETA_SUPPORT_DESC', 'bool', '0', 'Game', 'BETA_SUPPORT', 'AdvancedOptions', '20020');