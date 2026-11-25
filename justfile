# Recipes: `just` lists them. Nothing builds here yet (the code lives in HQ until format atlas/1).

# List all recipes
[private]
@default:
    just --list --unsorted --justfile {{ justfile() }}

# The gate: every prek hook on all files; fixers rewrite files, run again until it passes
[group('quality')]
q-check:
    prek run --all-files

# Bulwark static scan (Semgrep, osv, gitleaks); needs `bulwark` on PATH and BULWARK_RULES set to its rules directory
[group('quality')]
q-bulwark:
    BULWARK_SEMGREP="${BULWARK_SEMGREP:-uvx --from semgrep semgrep}" bulwark scan static . --rules "${BULWARK_RULES:?set BULWARK_RULES to the bulwark rules directory}" --fail-on medium
