--------------------------------------------------------------------------------
-- |
-- Module       : Log
-- Copyright    : (c) sszark@protonmail.com
-- License      : BSD3-style (see LICENSE)
--
-- Maintainer   : sszark@protonmail.com
-- Stability    : unstable
-- Portability  : unportable
--
-- Log for Sszark's XMonad configuration
--
--------------------------------------------------------------------------------

module Log
     ( myLogHook ) where

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------
-- Core
import XMonad

-- Hooks
import XMonad.Hooks.DynamicLog

-- Actions
import XMonad.Actions.WorkspaceNames

-- Utils
import XMonad.Util.Run
import XMonad.Util.NamedScratchpad (namedScratchpadFilterOutWorkspacePP)

-- Modules ---------------------------------------------------------------------
import ColorScheme
import Config

--------------------------------------------------------------------------------
-- Log Hook
-- * This keeps track of all internal state updates within xmonad and outputs
--   status information to external programs, such as xmobar or dzen
--------------------------------------------------------------------------------
myLogHook xmproc = do
  workspaceNamesPP myPP >>= dynamicLogWithPP . namedScratchpadFilterOutWorkspacePP
    where                   
    myPP = def
      -- Pipes interal state to the xmobar process
      { ppOutput          = hPutStrLn xmproc
      -- Current workspace
      , ppCurrent         = xmobarColor (brightGreen myColors)  "" 
      -- Visible, but not current workspace
      , ppVisible         = xmobarColor (brightGreen myColors)  "" . wrap "[" "]"
      -- Hidden workspaces
      , ppHidden          = xmobarColor (foreground myColors)   ""
      -- Hidden workspaces with no windows
      , ppHiddenNoWindows = xmobarColor (grey myColors)         ""
      -- Title of focused window
      , ppTitle           = xmobarColor (foreground myColors)   "" . shorten 30
      -- Urgent workspace
      , ppUrgent          = xmobarColor (brightYellow myColors) "" . wrap "!" "!"
      -- Separators
      , ppSep             = "<fc=#666666> <fn=2>|</fn> </fc>"
      }
