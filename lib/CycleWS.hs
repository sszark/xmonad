--------------------------------------------------------------------------------
-- |
-- Module       : CycleWS
-- Copyright    : (c) sszark@protonmail.com
-- License      : BSD3-style (see LICENSE)
--
-- Maintainer   : sszark@protonmail.com
-- Stability    : unstable
-- Portability  : unportable
--
-- Extension of 'XMonad.Actions.CycleWS' for Sszark's XMonad configuration
--
--------------------------------------------------------------------------------

-- re-exports 'XMonad.Actions.CycleWS' with local extension
module CycleWS
    ( module XMonad.Actions.CycleWS
    , nextNormalWS
    , prevNormalWS
    ) where

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------
import XMonad
import XMonad.Actions.CycleWS
--import XMonad.Actions.CycleWS (Direction1D(Next, Prev), WSType(WSIs), moveTo)
import qualified XMonad.StackSet as W

-- Modification of `nextWS` to ignore workspace 'NSP'
nextNormalWS :: X ()
nextNormalWS = moveTo Next noNSP
 where
   noNSP :: WSType
   noNSP = WSIs $ do
     hiddenWs <- gets $ map W.tag . W.hidden . windowset
     pure $ \w -> W.tag w `elem` hiddenWs && W.tag w /= "NSP"

-- Modification of `prevWS` to ignore workspace 'NSP'
prevNormalWS :: X ()
prevNormalWS = moveTo Prev noNSP
 where
   noNSP :: WSType
   noNSP = WSIs $ do
     hiddenWs <- gets $ map W.tag . W.hidden . windowset
     pure $ \w -> W.tag w `elem` hiddenWs && W.tag w /= "NSP"

