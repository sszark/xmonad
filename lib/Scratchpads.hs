--------------------------------------------------------------------------------
-- |
-- Module       : Scratchpads
-- Copyright    : (c) sszark@protonmail.com
-- License      : BSD3-style (see LICENSE)
--
-- Maintainer   : sszark@protonmail.com
-- Stability    : unstable
-- Portability  : unportable
--
-- Scratchpads for Sszark's XMonad configuration
--
--------------------------------------------------------------------------------

module Scratchpads
     ( myScratchPads ) where

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------
-- Base
import XMonad

-- Utilities
import XMonad.Util.NamedScratchpad

--------------------------------------------------------------------------------
-- Scratchpads
--------------------------------------------------------------------------------
-- Scratch pads are persistant programs that you can summon or unsummon at will.
myScratchPads :: [NamedScratchpad]
myScratchPads =
  -- Documentation Vim Buffer
  [ NS "doc" "alacritty -t 'doc' -e nvim ~/doc/index.md" (title =? "doc") defaultFloating
  -- IRC Chat
  , NS "irc" "alacritty -t 'irc' -e tmux a -t irc" (title =? "irc") defaultFloating
                ]
