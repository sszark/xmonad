--------------------------------------------------------------------------------
-- |
-- Module       : Layout
-- Copyright    : (c) sszark@protonmail.com
-- License      : BSD3-style (see LICENSE)
--
-- Maintainer   : sszark@protonmail.com
-- Stability    : unstable
-- Portability  : unportable
--
-- Layouts for Sszark's XMonad configuration
--
--------------------------------------------------------------------------------

module Layout
     ( myLayoutHook ) where

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------
-- Base
import XMonad

-- Layout
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??)) 
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.Renamed
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.WindowNavigation

import XMonad.Layout.SimpleDecoration
import XMonad.Layout.DecorationAddons
import XMonad.Layout.ButtonDecoration
import XMonad.Layout.SimplestFloat

import XMonad.Layout.NoFrillsDecoration

import XMonad.Layout.Tabbed

import XMonad.Layout.GridVariants (Grid(Grid))

import XMonad.Layout.Spacing

--import XMonad.Layout.BorderResize

--import XMonad.Layout.WindowArranger

-- Hooks
import XMonad.Hooks.ManageDocks

-- Modules
import Config
import ColorScheme

--------------------------------------------------------------------------------
-- Layouts
--------------------------------------------------------------------------------

{-|

 Master and Stack
 -###############################-
 |               |               |
 |               |               |
 |               |               |
 |    Master     |     Stack     |
 |               |               |
 |               |               |
 |               |               |
 ---------------------------------

 Monocle (no borders)
 -###############################-
 |                               |
 |                               |
 |                               |
 |            Monocle            |
 |                               |
 |                               |
 |                               |
 ---------------------------------

 Fullscreen (no borders)
 ---------------------------------
 |                               |
 |                               |
 |                               |
 |          Fullscreen           | 
 |                               |
 |                               |
 |                               |
 ---------------------------------

 Floating
 -###############################-
 |                               |
 |        ---------------        |
 |        |             |        |
 |        |    Float    |        | 
 |        |             |        |
 |        ---------------        |
 |                               |
 ---------------------------------

 Floating (with decorations)
 -###############################-
 |                               |
 |        ###############        |
 |        |             |        |
 |        |    Float    |        | 
 |        |             |        |
 |        ---------------        |
 |                               |
 ---------------------------------


 Hidden (Scratchpads and Minimized)
 * No preview
 
 -}

myTabTheme = def { fontName = myFont'
                 , decoHeight = 18
                 , activeColor = "#1d2021"
                 , inactiveColor = "#1d2021"
                 , activeBorderColor = "#666666"
                 , inactiveBorderColor = "#666666"
                 , urgentBorderColor = "#666666"
                 , activeBorderWidth = 1
                 , inactiveBorderWidth = 1
                 , urgentBorderWidth = 1
                 , activeTextColor = (brightGreen myColors)
                 , inactiveTextColor = (grey myColors)
                 }

mySDConfig = def { inactiveBorderColor = "red"
                 , inactiveTextColor   = "red"
                 , decoWidth           = 200
                 , decoHeight          = 16}

mySpacing i = spacingRaw True (Border 10 10 10 10) True (Border 0 0 0 0) True

master = renamed [Replace "master"]
  $ ResizableTall 1 (3/100) (1/2) []

monocle = renamed [Replace "monocle"]
  $ windowNavigation
  $ limitWindows 20 Full

tabbedMonocle = renamed [Replace "tabbed monocle"]
  $ tabbed shrinkText myTabTheme

grid = renamed [Replace "grid"]
  $ windowNavigation
-- $ limitWindows 12
  $ mySpacing 5
  $ limitWindows 16
  $ Grid (16/10)

floats = renamed [Replace "floats"]
  $ windowNavigation
  $ limitWindows 20 simplestFloat

---- TODO: Add a floating layout with window decorations (does not work)
-- floats' = renamed [Replace "[floats]"]
--   $ windowNavigation
--   $ simpleDeco shrinkText mySDConfig
--   $ limitWindows 20 simplestFloat


-- Layout Hook -----------------------------------------------------------------
myLayoutHook = avoidStruts -- $ windowArrange $ borderResize
  $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout = master
                  ||| noBorders monocle
                  ||| noBorders tabbedMonocle
                  ||| grid
                  ||| floats
--                ||| floats'
--layer1     -> layer2      -> layer3
--keybinding -> combination -> action

--C-e -> e -> emacs
--       o -> org-mode
--       s -> org-schedule
--       r -> org-roam

--"mod4 + e " 
--("C-e o", spawn "emacsclient -c -a 'org-mode'")

