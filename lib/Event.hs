--------------------------------------------------------------------------------
-- |
-- Module       : Event
-- Copyright    : (c) sszark@protonmail.com
-- License      : BSD3-style (see LICENSE)
--
-- Maintainer   : sszark@protonmail.com
-- Stability    : unstable
-- Portability  : unportable
--
-- Event Handler for Sszark's XMonad configuration
--
--------------------------------------------------------------------------------


module Event
     ( myEventHook ) where

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------
-- Base
import XMonad

-- Hooks
import XMonad.Hooks.EwmhDesktops

--------------------------------------------------------------------------------
-- Event Hook
-- * This implements logic for what should happen when various events occur
--------------------------------------------------------------------------------
myEventHook = handleEventHook def <+> fullscreenEventHook
