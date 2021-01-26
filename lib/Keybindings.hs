--------------------------------------------------------------------------------
-- |
-- Module       : Keybindings
-- Copyright    : (c) sszark@protonmail.com
-- License      : BSD3-style (see LICENSE)
--
-- Maintainer   : sszark@protonmail.com
-- Stability    : unstable
-- Portability  : unportable
--
-- Keybindings for Sszark's XMonad configuration
--
--------------------------------------------------------------------------------

module Keybindings
     ( myKeys ) where

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------
-- Base
import XMonad
import qualified XMonad.StackSet as SS
import System.Exit (exitSuccess)

-- Layout
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))
import XMonad.Layout.ResizableTile

-- Prompt
import XMonad.Prompt
import XMonad.Prompt.XMonad
import XMonad.Prompt.Shell

-- Actions
--import XMonad.Actions.CycleWS
--import qualified XMonad.Actions.Search as S

-- Utilities
import XMonad.Util.Run (spawnPipe, safeSpawn, hPutStrLn) 
import XMonad.Util.NamedScratchpad

-- Hooks
import XMonad.Hooks.ManageDocks



import XMonad.Actions.SwapWorkspaces

-- Modules ---------------------------------------------------------------------
import Config
import Prompt
import Scratchpads
import Tree

-- Extension of XMonad.Actions.Search
import qualified XMonad.Actions.SearchEXT as S
-- Extension of XMonad.Actions.CycleWS
import CycleWS

--------------------------------------------------------------------------------
-- keybindings
--------------------------------------------------------------------------------
myKeys :: [(String, X ())]
myKeys =
-- Control
  -- Recompile and restart XMonad
  [ ("M-C-r", spawn "xmonad --recompile")
  -- Restart XMonad
  , ("M-S-r", spawn "xmonad --restart")
  -- Exit XMonad
  , ("M-S-q", io exitSuccess)

-- Tree Select
  , ("C-t t", treeselectAction myTSConfig)         

-- Window Navigation
  -- Focus master window
  , ("M-m",   windows SS.focusMaster)
  -- Focus next window
  , ("M-j",   windows SS.focusDown)
  -- Focus previous window
  , ("M-k",   windows SS.focusUp)
  -- Swap focus with next window
  , ("M-S-j", windows SS.swapDown)
  -- Swap focus with prev window
  , ("M-S-k", windows SS.swapUp)

-- Window Resize
  -- + Horizontal
  , ("M-l", sendMessage Expand)
  -- - Horizontal
  , ("M-h", sendMessage Shrink)
  -- + Vertical
  , ("M-M1-k", sendMessage MirrorExpand)
  -- - Vertical
  , ("M-M1-j", sendMessage MirrorShrink)

-- Layouts
  -- Enable fullscreen layout
  , ("M-f", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)
  -- Cycle layouts
  , ("M-<Tab>", sendMessage NextLayout)
  -- Toggle struts (disables all gaps)
  , ("M-b", sendMessage ToggleStruts)
  -- Toggle window borders
  , ("M-S-n", sendMessage $ MT.Toggle NOBORDERS)


-- Workspaces
  -- Change to next workspace  
  , ("M-]",     nextNormalWS)
  -- Change to previous workspace
  , ("M-[",     prevNormalWS)
  -- Move focused window to next workspace
  , ("M-S-]",   shiftToNext)
  -- Move focused window to previous workspace
  , ("M-S-[",   shiftToPrev)
  -- Change focus to next monitor
  , ("M-C-]",   nextScreen)
  -- Change focus to previous monitor
  , ("M-C-[",   prevScreen)
  -- Move focused workspace to next monitor
  , ("M-C-A-]", shiftNextScreen)
  -- Move focused workspace to previous monitor
  , ("M-C-A-[", shiftPrevScreen)
  -- Toggles between the two previous workspaces
  , ("M-q",     toggleWS)
  
  -- Swap workspaces
  --, ("m-", windows $ swapWithCurrent i)

-- Prompts
  -- Root menu (all menus)
  , ("M-0", xmonadPromptC myRootMenu myXPConfig)
        
-- Application Launcher
  -- Terminal
  , ("M-<Return>", spawn myTerminal)
  -- Run Prompt
  , ("M-<Space>",  shellPrompt myXPConfig)
  -- File Manager
  , ("M-e",        spawn myFiles)
  -- Web Browser
  , ("M-w",        spawn myBrowser)
  
-- Scratchpads
  -- IRC
  , ("M-8", namedScratchpadAction myScratchPads "irc")

-- Sound
  -- Lower volume
  , ("M-<KP_9>",        spawn "amixer set Master 5%- unmute")
  -- Increase volume
  , ("M-<KP_0>",        spawn "amixer set Master 5%+ unmute")
  -- Toggle mute/unmute
  , ("M-<KP_Subtract>", spawn "amixer set Master toggle")
     
-- Media Keys
  -- Play
  , ("<XF86AudioPlay>",        spawn "playerctl play-pause")
  -- Previous
  , ("<XF86AudioPrev>",        spawn "playerctl previous")
  -- Next
  , ("<XF86AudioNext>",        spawn "playerctl next")
  -- Lower volume
  , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
  -- Increase volume
  , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
  -- Web Browser
  , ("<XF86HomePage>",         spawn myBrowser)
  -- Web Browser + Search Engine
  , ("<XF86Search>",       safeSpawn myBrowser ["https://www.duckduckgo.com/"])
  -- Mail
  , ("<XF86Mail>",             spawn (myTerminal ++ " -e neomutt"))
  -- Calculator
  , ("<XF86Calculator>",       spawn (myTerminal ++ " -e python3 -q"))
  -- Eject disc drive
--, ("<XF86Eject>",            ???
  -- Print Screen
  , ("<Print>",                spawn "scrot -d 0")
  ]

  -- Search Engines via emacs bindings (see `SearchEngine.hs`)
  ++ [("M-s " ++ k, S.promptSearch myXPConfig f) | (k,f) <- S.searchList ]
