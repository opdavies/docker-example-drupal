default:
  @just --list

composer *args:
  just _exec php composer {{ args }}

drush *args:
  just _exec php drush {{ args }}

_exec +args:
  docker compose exec {{ args }}
