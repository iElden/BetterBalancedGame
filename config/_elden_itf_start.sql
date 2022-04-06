-- Create Table to
CREATE TABLE EldenITFGameParameterDomainOverride (
    SourceGroup TEXT,
    SourceId TEXT,
    SourceValue TEXT,
    TargetParameter TEXT,
    Domain TEXT
);

INSERT INTO Parameters(ParameterId, Name, Domain, ConfigurationGroup, ConfigurationId, GroupId, Visible) VALUES
    ('ELDEN_ITF_PLAYER_LEADER_DOMAIN', 'ELDEN_ITF_PLAYER_LEADER_DOMAIN', 'text', 'Game', 'ELDEN_ITF_PLAYER_LEADER_DOMAIN', 'AdvancedOptions', 1);

INSERT INTO Queries(QueryId, SQL) VALUES
    ('EldenITFGameParameterDomainOverride',
    'SELECT TargetParameter, Domain FROM EldenITFGameParameterDomainOverride WHERE Key1 = ?1 and (Key2 = ?2 or Key2 is null)');

INSERT INTO QueryParameters(QueryId, "Index", ConfigurationGroup, ConfigurationId) VALUES
    ('EldenITFGameParameterDomainOverride', '1', 'Game', 'ELDEN_ITF_PLAYER_LEADER_DOMAIN'),
    ('EldenITFGameParameterDomainOverride', '2', 'Player', 'PLAYER_ID');

INSERT INTO DomainOverrideQueries(QueryId, ParameterIdField, DomainField) VALUES
    ('EldenITFGameParameterDomainOverride', 'TargetParameter', 'Domain');

INSERT INTO ConfigurationUpdates(SourceGroup, SourceId, SourceValue, TargetGroup, TargetId, TargetValue)
    SELECT SourceGroup, SourceId, SourceValue, 'Game', 'ELDEN_ITF_PLAYER_LEADER_DOMAIN', Domain
    FROM EldenITFGameParameterDomainOverride;