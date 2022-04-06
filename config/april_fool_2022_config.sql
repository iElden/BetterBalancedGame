

INSERT INTO Queries(QueryId, SQL) VALUES
    ('DomainOverrides', 'SELECT ParameterId, DomainOverride FROM DomainOverrides WHERE Key1 = ?1 and (Key2 = ?2 or Key2 is null)');

INSERT INTO QueryParameters(QueryId, "Index", ConfigurationGroup, ConfigurationId) VALUES
    ('DomainOverrides', '1', 'Game', 'BBG_GAMEMODE_BABYLON'),
    ('DomainOverrides', '2', 'Player', 'PLAYER_ID');

INSERT INTO DomainOverrides(Key1, Key2, ParameterId, DomainOverride) VALUES
    ('1', NULL, 'PlayerLeader', 'Players:Observer'),
    ('true', NULL, 'PlayerLeader', 'Players:Observer');

INSERT INTO DomainOverrideQueries(QueryId, ParameterIdField, DomainField) VALUES
    ('DomainOverrides', 'ParameterId', 'DomainOverride');