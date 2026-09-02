---
name: gui-automation
description: Управление десктоп-интерфейсом через computer_use.
version: 0.1.0
author: hermes
license: MIT
platforms: [windows, macos, linux]
metadata:
  hermes:
    tags: [gui, automation, computer-use, desktop]
    category: automation
    related_skills: []
---

# GUI Automation Skill

Скил для работы с графическим интерфейсом через инструмент
`computer_use`: скриншоты, клики, ввод текста, клавиши, окна и фокус.
Не заменяет браузерную автоматизацию (для веба — `playwright`).

## When to Use

- нужно посмотреть, что сейчас на экране / в окне приложения;
- кликнуть, ввести текст, нажать клавиши, прокрутить окно;
- найти окно приложения и перевести на него ввод;
- прочитать accessibility-дерево элемента (кнопки, поля, списки).

## Prerequisites

- Инструмент `computer_use` доступен (MCP-сервер prokop или реестр ядра).
- Бэкенд: cua-driver в PATH или локальный Windows-стек
  (`pip install prokop[gui]` — mss, pyautogui, pywinauto, Pillow).
- Действия, меняющие состояние, требуют подтверждения
  (MCP-permission `prokop_computer_use: ask`).

## How to Run

Вызов инструмента: `computer_use(action=..., ...)`. Захват безопасен;
действия — под подтверждением.

## Quick Reference

| Шаг | Вызов |
|---|---|
| Посмотреть экран | `capture(mode="vision")` |
| Элементы с номерами | `capture(mode="som")` |
| Дерево доступности | `capture(mode="ax")` |
| Кликнуть элемент №5 | `click(element=5)` |
| Клик по координатам | `click(coordinate=[120, 40])` |
| Ввести текст | `type(text="Привет")` |
| Клавиши | `key(keys="ctrl+s")` |
| Прокрутить | `scroll(direction="down", amount=3)` |
| Список окон | `list_windows()` |
| Фокус на приложение | `focus_app(app="Notepad")` |

## Procedure

1. **Захват.** Вызови `capture(mode="som")` — получишь скриншот с
   номерами элементов и AX-дерево.
2. **Таргетинг.** Выбирай индекс элемента из захвата (`element=N`),
   а не координаты — надёжнее. Координаты используй, если элемента нет
   в дереве.
3. **Действие.** `click`/`type`/`key`/`scroll`. При необходимости
   `delivery_mode="foreground"` — но по умолчанию работай в фоне.
4. **Проверка.** После действия вызови `capture(mode="som", capture_after
   не нужно — просто повторный захват)` или используй
   `capture_after=true` в действии, чтобы получить свежий скриншот.
5. **Окна.** Если захват не тот — `list_windows()` → `capture(window_id=...)`
   или `focus_app(app=...)`.

## Pitfalls

- **Захват целого экрана на мультимониторной конфигурации** — по одному
  окну/экрану за раз (`app=`/`window_id=`).
- **Элементы без accessibility-дерева** (canvas, игры) — переходи на
  `mode="vision"` + координаты.
- **Большие скриншоты раздувают контекст** — не зови `capture` в цикле;
  используй `max_elements` и `capture_after`.
- **Скролл на Windows** — `pyautogui.scroll` работает с колёсиком;
  для тачпада может не сработать.
- **Не поднимай окна без нужды** — `raise_window`/`foreground`
  перехватывают фокус пользователя.

## Verification

- `computer_use(action="list_windows")` возвращает `ok: true` и список окон.
- После `capture(mode="ax")` в сводке есть элементы с индексами.
- Живая проверка: захвати экран (`vision`), кликни по кнопке приложения
  (например, «Пуск»), введи текст в поле блокнота.
