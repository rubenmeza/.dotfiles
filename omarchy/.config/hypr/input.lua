-- Personal input overrides (ported from the Omarchy 3 input.conf).
-- Everything else in the old input.conf now matches Omarchy 4's defaults:
--   /usr/share/omarchy/default/hypr/input.lua

hl.config({
  input = {
    -- Slower repeat start than Omarchy's 250ms default.
    repeat_delay = 600,

    touchpad = {
      -- Natural (inverse) scrolling.
      natural_scroll = true,
    },
  },
})
