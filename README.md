# prokop-skills

Публичная библиотека личных скилов агента **Прокопий** (github.com/yaugust939/prokop).
Скилы соответствуют схеме навыков `prokop/skills`: каталог `SKILL.md` + опциональные
`references/ templates/ scripts/ assets/`. Секретов нет (ключи только плейсхолдерами).

## Состав

| Скил | Назначение | Файлы |
|---|---|---|
| `direktolog` | Яндекс.Директ + click.ru: бриф, семантика, KPI, стратегия МСП, кампании, оптимизация, маркировка, отчётность. Самодостаточный. | `skills/direktolog/` |
| `gui-automation` | Управление десктоп-интерфейсом через `computer_use` (SOM/vision/ax, клики, ввод, окна, focus). | `skills/gui-automation/` |

## Установка в скилы Прокопия

Требование: механизм навыков `prokop` (`C:\Users\<user>\.prokop\skills\`).

### Windows — скриптом
```powershell
.\scripts\install.ps1                # в $env:USERPROFILE\.prokop\skills
.\scripts\install.ps1 -Target C:\path\to\skills
```

### Вручную
Скопировать содержимое `skills/<name>/` в каталог навыков:
```
~/.prokop/skills/direktolog/
~/.prokop/skills/gui-automation/
```
Проверка установки: `prokop_skills list` (или `view <name>`).

## Как добавить скил в репозиторий

1. Готовый скил (валидный `SKILL.md`, связанные файлы только в
   `references/templates/scripts/assets`) кладём в `skills/<name>/`.
2. Перед публикацией — проверка на секреты (ключи только плейсхолдерами `[TOKEN]`).
3. Добавляем строку в таблицу README, пушим.

## Лицензия

MIT — см. `LICENSE`. Скилы: каждый сохраняет свой `author` в frontmatter.

## Связанное

- Пакет/ядро Прокопия: https://github.com/yaugust939/prokop
- Механизм навыков: `src/prokop/skills` (model/access/discovery/curator/index).
