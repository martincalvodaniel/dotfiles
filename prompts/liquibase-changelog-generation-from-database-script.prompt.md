---
name: liquibase-changelog-generation-from-database-script
description: Generate Liquibase changelogs from a database script
argument-hint: Optional: source script and database type (mongo|sql)
tools: [ 'edit', 'search' ]
---

Generate a Liquibase changelog from a database script (the selected or provided), generalized for different projects and technologies.

Instructions:
- Detect the database type of the script (MongoDB vs relational SQL).
- For MongoDB, use the Liquibase extension for MongoDB (`ext`) and generate `changeSet`s with `ext:createCollection`, `ext:createIndex`, etc. Include the appropriate namespaces and `schemaLocation`.
- For relational SQL, use standard tags (`createTable`, `createIndex`, `addColumn`, etc.) with the classic `databaseChangeLog`.
- Convert each statement in the script into an independent `changeSet` with incremental `id` and configurable `author`.

Index naming rules (important):
- Derive the index `name` from its keys in order, concatenating `field_direction` per key.
  - Ascending → `field_1`; descending → `field_-1`.
  - Do not include the collection/table name in the index `name`.
  - For TTL (MongoDB), keep `expireAfterSeconds` but do NOT add suffixes like `_ttl` to the `name`.
- Preserve the exact key order as in the source script.
- If the index is unique/sparse/partial, add the corresponding options in `ext:options` (Mongo) or `createIndex` attributes (SQL).

Output structure:
- XML file with correct header and namespaces.
- Suggested location: `db/{type}/changelog/changes/{NNN.description}.xml` and include it in the root `changelog.xml` when appropriate.
- Optional: add `preConditions` for collection/table creations (e.g., `collectionExists`/`tableExists`) with `onFail="MARK_RAN"`.

Example (MongoDB input):
```
use('mi_db')
db.alerts.createIndex({ channel:1, brand:1, categories:1, impact:1, actionType:1 })
db.alerts.createIndex({ modificationDate:1 }, { expireAfterSeconds:7776000 })
```

Example (Liquibase MongoDB output):
```xml
<changeSet id="1" author="${author}">
  <ext:createIndex collectionName="alerts">
    <ext:keys>
      { channel: 1, brand: 1, categories: 1, impact: 1, actionType: 1 }
    </ext:keys>
    <ext:options>
      { name: "channel_1_brand_1_categories_1_impact_1_actionType_1" }
    </ext:options>
  </ext:createIndex>
</changeSet>

<changeSet id="2" author="${author}">
  <ext:createIndex collectionName="alerts">
    <ext:keys>
      { modificationDate: 1 }
    </ext:keys>
    <ext:options>
      { name: "modificationDate_1", expireAfterSeconds: 7776000 }
    </ext:options>
  </ext:createIndex>
  </changeSet>
```

Delivery:
- Return the generated file and, if applicable, the update to the root `changelog.xml`.
- Verify index names comply with the rules and `changeSet`s are idempotent.
