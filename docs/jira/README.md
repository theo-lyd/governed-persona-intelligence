# Jira Import Notes

## File
- Import CSV: `docs/jira/jira-import.csv`
- Synthetic export sample: `docs/jira/jira-export-sample.csv`
- Board-specific import CSV: `docs/jira/jira-import-board-specific.csv`
- Team-managed import CSV (Parent linkage): `docs/jira/jira-import-team-managed.csv`

## Included Fields
- `Issue Type`
- `Summary`
- `Description`
- `Priority`
- `Labels`
- `Components`
- `Sprint`
- `Epic Name`
- `Epic Link`
- `Story Points`

## Board-Specific Variant Fields
The board-specific CSV uses a common Jira company-managed schema:
- `Project Key`
- `Project Name`
- `Issue Type`
- `Summary`
- `Description`
- `Priority`
- `Labels`
- `Components`
- `Sprint`
- `Epic Name`
- `Epic Link`
- `Story Points`
- `Status`
- `Assignee`
- `Reporter`
- `Parent`

## Team-Managed Variant Behavior
- Uses `Parent` for epic linkage on story rows.
- Does not include `Epic Link` column.
- Keeps `Epic Name` for epic rows only.
- Story rows set `Parent` to the matching epic identifier (for example `EPIC-FOUNDATION`).

## Expected Mapping in Jira CSV Importer
- `Issue Type` -> Issue Type
- `Summary` -> Summary
- `Description` -> Description
- `Priority` -> Priority
- `Labels` -> Labels
- `Components` -> Components
- `Sprint` -> Sprint
- `Epic Name` -> Epic Name (for Epic rows)
- `Epic Link` -> Epic Link (for Story rows)
- `Story Points` -> Story points

## Sprint Names Used in CSV
- `Sprint 1 - Foundation`
- `Sprint 2 - Ingestion`
- `Sprint 3 - Reliability and Locale`
- `Sprint 4 - Semantic Core`
- `Sprint 5 - ML Core`
- `Sprint 6 - Model Operations`
- `Sprint 7 - Persona Consultant`
- `Sprint 8 - Go Live`

## Notes
- If your board uses different sprint names, update the `Sprint` column before import.
- If your Jira project uses Team-managed epics, map parent fields according to project settings.
- Import epics and stories together from the same file to preserve `Epic Link` references.
- The sample export is synthetic and safe to share; replace values with your real project keys if needed.
- For Team-managed import, use `docs/jira/jira-import-team-managed.csv` and map `Parent` directly.
