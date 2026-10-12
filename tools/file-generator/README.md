# Satellite-Sim Multi-File Generator

The generator converts the staffing model into a reproducible planning package.

## Run

```bash
python tools/file-generator/generate.py
```

Or:

```bash
python tools/file-generator/generate.py --output generated/planning
```

## Generated files

- `program-summary.json`
- `program-summary.md`
- `budget-summary.csv`
- `hiring-schedule.md`
- `staffing-generated.json`
- `manifest.json`

The source inputs are `config/project-scenarios.yaml` and `docs/staffing-costs.csv`.
