--------------------------------------------------------------------------------
-- |
-- Module       : Prompts
-- Copyright    : (c) sszark@protonmail.com
-- License      : BSD3-style (see LICENSE)
--
-- Maintainer   : sszark@protonmail.com
-- Stability    : unstable
-- Portability  : unportable
--
-- Prompts for Sszark's XMonad configuration
--
--------------------------------------------------------------------------------

module Prompt
     ( myXPKeymap
     , myXPConfig
     , myRootMenu
     ) where

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------
-- Base
import XMonad
import System.Exit (exitSuccess)

-- Prompts
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Ssh
import XMonad.Prompt.ConfirmPrompt

-- Actions
import XMonad.Actions.WorkspaceNames
--import qualified XMonad.Actions.Search as S

-- Data
import qualified Data.Map as M

-- Arrow Navigation
import Control.Arrow (first)

-- Modules ---------------------------------------------------------------------
import ColorScheme
import Config

-- Extends 'XMonad.Actions.Search'
import qualified XMonad.Actions.SearchEXT as S
--import qualified Search as S

--------------------------------------------------------------------------------
-- Prompt
-- * Prompts are input fields and selectors for scripting
--------------------------------------------------------------------------------

-- Keybindings -----------------------------------------------------------------
myXPKeymap :: M.Map (KeyMask,KeySym) (XP ())
myXPKeymap = M.fromList $
     -- control + <key>
     map (first $ (,)   controlMask)
     -- kill line backwards
     [ (xK_z,           killBefore)
     -- kill line forwards
     , (xK_k,           killAfter)
     -- move to the beginning of the line
     , (xK_a,           startOfLine)
     -- move to the end of the line
     , (xK_e,           endOfLine)
     -- delete a character foward
     , (xK_m,           deleteString Next)
     -- move cursor forward
     , (xK_b,           moveCursor Prev)
     -- move cursor backward
     , (xK_f,           moveCursor Next)
     -- kill the previous word
     , (xK_BackSpace,   killWord Prev)
     -- paste a string
     , (xK_y,           pasteString)
     -- quit out of prompt
     , (xK_g,           quit)
     , (xK_bracketleft, quit)
     ]

-- Config ----------------------------------------------------------------------
myXPConfig :: XPConfig
myXPConfig = def
      { font                = myFont'
      , bgColor             = background    myColors'
      , fgColor             = foreground    myColors
      , bgHLight            = black         myColors
      , fgHLight            = brightYellow  myColors
      , borderColor         = foreground    myColors
      , promptBorderWidth   = 0
--    , promptKeymap        = myXPKeymap
      , position            = Top
      , height              = 18
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , defaultPrompter     = id
      , autoComplete        = Nothing
      , showCompletionOnTab = False
      , searchPredicate     = fuzzyMatch
      , alwaysHighlight     = True
      , maxComplRows        = Nothing
      }

-- Hide Completion
--myXPConfig' = myXPConfig { maxComplRows = Just 0 }
--myXPConfig' = myXPConfig { historySize = 0 }

-- Menus -----------------------------------------------------------------------
-- System
mySystemMenu :: [(String, X ())]
mySystemMenu =
              [ ("recompile", spawn "xmonad --recompile")
              , ("restart",   spawn "xmonad --restart")
              , ("exit",      confirmPrompt myXPConfig "(exit xmonad?)" (io exitSuccess))
              , ("reboot",    confirmPrompt myXPConfig "(reboot system?)" (spawn "reboot"))
              , ("shutdown",  confirmPrompt myXPConfig "(shutdown system?)" (spawn "poweroff"))
              ]

-- Search
mySearchMenu :: [(String, X ())]
mySearchMenu =
              [ ("duckduckgo", S.promptSearch myXPConfig S.duckduckgo)
              , ("Arch Wiki",  S.promptSearch myXPConfig S.archwiki)
              , ("NixOS Wiki",  S.promptSearch myXPConfig S.nixoswiki)
              , ("NixOS Options",  S.promptSearch myXPConfig S.nixosopt)
              ]

-- Root (All Menus)
myRootMenu :: [(String, X ())]
myRootMenu =
            [ ("system", xmonadPromptC mySystemMenu myXPConfig)
            , ("xmonad", xmonadPrompt myXPConfig)
            , ("ssh",    sshPrompt myXPConfig)
            , ("search", xmonadPromptC mySearchMenu myXPConfig)
            , ("rename", renameWorkspace myXPConfig)
            ]

