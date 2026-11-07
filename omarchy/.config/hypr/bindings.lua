-- Personal keybinding overrides (ported from the Omarchy 3 bindings.conf).
-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- Workspaces move from SUPER to ALT ------------------------------------------
-- SUPER + SHIFT + ALT + <n> (move window silently) is left on SUPER.
for workspace = 1, 10 do
  local key = "code:" .. tostring(workspace + 9)

  hl.unbind("SUPER + " .. key)
  hl.unbind("SUPER + SHIFT + " .. key)

  -- o.workspaces maps n to the focused monitor's own block (Omarchy 4.5 per-monitor workspaces).
  o.bind("ALT + " .. key, "Switch to workspace " .. workspace, o.workspaces.focus(workspace))
  o.bind("ALT + SHIFT + " .. key, "Move window to workspace " .. workspace, o.workspaces.move_window(workspace))
end

-- Window management moves from SUPER to ALT ----------------------------------
hl.unbind("SUPER + RETURN")
o.bind("ALT + RETURN", "Terminal", { omarchy = "terminal" })

hl.unbind("SUPER + W")
o.bind("ALT + Q", "Close window", hl.dsp.window.close())

-- Apps menu also on ALT + D (SUPER + ALT + SPACE stays bound too).
-- SUPER + SPACE is left alone so the root Omarchy menu keeps working.
o.bind("ALT + D", "Launch apps", "omarchy-menu toggle apps")

o.bind("ALT + H", "Move window focus left", hl.dsp.focus({ direction = "l" }))
o.bind("ALT + L", "Move window focus right", hl.dsp.focus({ direction = "r" }))
o.bind("ALT + K", "Move window focus up", hl.dsp.focus({ direction = "u" }))
o.bind("ALT + J", "Move window focus down", hl.dsp.focus({ direction = "d" }))

o.bind("ALT + B", "Browser", { omarchy = "browser" })

-- Screenshot like macOS (SUPER + SHIFT + 4) ----------------------------------
o.bind("SUPER + SHIFT + code:13", "Screenshot", "omarchy-capture-screenshot")

-- Apps -----------------------------------------------------------------------
-- Omarchy 4 moved Activity to SUPER + CTRL + T; keep the old key working too.
o.bind("SUPER + SHIFT + T", "Activity", { tui = "btop" })

-- Typora instead of Omawrite.
hl.unbind("SUPER + SHIFT + W")
o.bind("SUPER + SHIFT + W", "Typora", { launch = "typora --enable-wayland-ime" })
