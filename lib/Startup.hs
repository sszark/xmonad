--------------------------------------------------------------------------------
-- |
-- Module       : Autostart
-- Copyright    : (c) sszark@protonmail.com
-- License      : BSD3-style (see LICENSE)
--
-- Maintainer   : sszark@protonmail.com
-- Stability    : unstable
-- Portability  : unportable
--
-- Autostart for Sszark's XMonad configuration
--
--------------------------------------------------------------------------------

module Startup
     ( myStartupHook ) where

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------
-- Core
import XMonad

-- Utilities
import XMonad.Util.SpawnOnce (spawnOnce)

--------------------------------------------------------------------------------
-- Startup Hook (Autostart)
--------------------------------------------------------------------------------
myStartupHook :: X ()
myStartupHook = do
  -- Sets the correct resolution (XEPHYR Testing)
  spawnOnce "xrandr -s 1440x900 && xrandr --dpi 96"
  -- Enables the most recently set wallpaper
  spawnOnce "~/.fehbg"
  -- Enables X11 cursor
  spawnOnce "xsetroot -cursor_name left_ptr"
  -- Enables notification daemon
  spawnOnce "dunst"
