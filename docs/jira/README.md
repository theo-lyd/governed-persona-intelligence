# Jira Import Notes

## File
- Import CSV: `docs/jira/jira-import.csv`

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
