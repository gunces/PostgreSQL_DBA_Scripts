# Install PostgreSQL FDW

1. Create postgres_fdw on database that you want to create Foreign table on it.

```
CREATE EXTENSION postgres_fdw;
```

2. Create SERVER to connect remote side.

```
CREATE SERVER <change server name>
        FOREIGN DATA WRAPPER postgres_fdw
        OPTIONS (host '<change ip>', port '<change port>', dbname '<change database name>');
```

3. Give local side database user USAGE permission for FOREIGN SERVER

```
GRANT USAGE ON FOREIGN SERVER <server name> TO <local side postgres user>;
```


4. Create USER MAPPING for specific user which is reach tables remote side.

```
CREATE USER MAPPING FOR <change database user>
        SERVER <server name>
        OPTIONS (user '<remote side user>', password '<change user password>');
```

5. Create SCHEMA for FOREIGN TABLEs (it is not necessary but I prefer to use different schema for FOREIGN TABLEs)

```
CREATE SCHEMA <schema name>;
ALTER SCHEMA <schema name> OWNER TO <local side database user>;
```

6. Create FOREIGN TABLEs. I imported all tables under the remote side schema.

```
IMPORT FOREIGN SCHEMA <remote side schema name> 
FROM SERVER <server name> INTO <local side schema name>;
```


If you require remove all FDW object, you can use following SQL scripts.
```
DROP SCHEMA <local side schema name>;
DROP USER MAPPING FOR <local side postgres user> SERVER <server name>;
DROP SERVER <server name>;
```
