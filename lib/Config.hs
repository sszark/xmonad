--------------------------------------------------------------------------------
-- |
-- Module       : Config
-- Copyright    : (c) sszark@protonmail.com
-- License      : BSD3-style (see LICENSE)
--
-- Maintainer   : sszark@protonmail.com
-- Stability    : unstable
-- Portability  : unportable
--
-- Variables for Sszark's XMonad configuration
--
--------------------------------------------------------------------------------


module Config
     ( myModMask
     , myBorderWidth
     , myColors
     , myColors'
     , myNormalColor
     , myFocusColor
     , myFocusFollowsMouse
     , myFont
     , myFont'
     , myBar'
     , myWorkspaces
     , myTerminal
     , myRunner
     , myFiles
     , myFiles'
     , myBrowser
     , myBrowser'
     ) where

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------
-- Base
import XMonad

-- Modules ---------------------------------------------------------------------
import ColorScheme

--------------------------------------------------------------------------------
-- Config
--------------------------------------------------------------------------------
-- Mod Key
myModMask = mod4Mask

-- Windows
myBorderWidth :: Dimension
myBorderWidth = 1

-- Color Scheme
myColors      = gruvboxDarkVoid
myColors'     = gruvboxDarkHard

myNormalColor = brightBlack myColors
myFocusColor  = white myColors

-- Mouse
myFocusFollowsMouse = False

-- Fonts
myFont  = "xft:Fira Code:bold:size=13:antialias=true:hinting=true"
myFont' = "xft:xos4 Terminus:regular:size=10:antialias=false:hinting=true"

-- Xmobar
myBar = "xmobar"
myBarRc = "~/.xmonad/xmobarrc"

myBar' = myBar ++ " " ++ myBarRc

-- Workspaces
myWorkspaces = ["dev", "doc", "chat", "media", "ssh"]

-- Applications
myTerminal = "alacritty -t \"bash\""
myEditor   = myTerminal ++ " -e nvim"
myRunner   = "rofi -show run"
myFiles    = "pcmanfm"
myFiles'   = myTerminal ++ " -e ranger"
myBrowser  = "firefox || iceweasel"
myBrowser' = myTerminal ++ " -e lynx"
