--------------------------------------------------------------------------------
-- |
-- Module       : Tree
-- Copyright    : (c) sszark@protonmail.com
-- License      : BSD3-style (see LICENSE)
--
-- Maintainer   : sszark@protonmail.com
-- Stability    : unstable
-- Portability  : unportable
--
-- Tree Select for Sszark's XMonad configuration
--
--------------------------------------------------------------------------------

module Tree
     ( myTSConfig
     , treeselectAction
     ) where

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------

import XMonad
import Data.Tree
import qualified Data.Map as M
import qualified XMonad.Actions.TreeSelect as TS
import XMonad.Hooks.WorkspaceHistory
import qualified XMonad.StackSet as W

myTSConfig = TS.TSConfig { TS.ts_hidechildren = True
                           , TS.ts_background   = 0x00000000
                           , TS.ts_font         = "xft:xos4 Terminus-10"
                           , TS.ts_node         = (0xff000000, 0xff50d0db)
                           , TS.ts_nodealt      = (0xff000000, 0xff10b8d6)
                           , TS.ts_highlight    = (0xffffffff, 0xffff0000)
                           , TS.ts_extra        = 0xff000000
                           , TS.ts_node_width   = 200
                           , TS.ts_node_height  = 30
                           , TS.ts_originX      = 0
                           , TS.ts_originY      = 0
                           , TS.ts_indent       = 200
                           , TS.ts_navigate     = myTreeNavigation
                           }

myTreeNavigation = M.fromList
  [ ((0, xK_Escape),   TS.cancel)
  , ((0, xK_Return),   TS.select)
  , ((0, xK_space),    TS.select)
  , ((0, xK_Up),       TS.movePrev)
  , ((0, xK_Down),     TS.moveNext)
  , ((0, xK_Left),     TS.moveParent)
  , ((0, xK_Right),    TS.moveChild)
  , ((0, xK_k),        TS.movePrev)
  , ((0, xK_j),        TS.moveNext)
  , ((0, xK_h),        TS.moveParent)
  , ((0, xK_l),        TS.moveChild)
  , ((0, xK_o),        TS.moveHistBack)
  , ((0, xK_i),        TS.moveHistForward)
  ]

treeselectAction :: TS.TSConfig (X ()) -> X ()
treeselectAction a = TS.treeselectAction a
  [ Node (TS.TSNode "Hello"    "displays hello"      (spawn "xmessage hello!")) []
  , Node (TS.TSNode "Shutdown" "Poweroff the system" (spawn "123")) []
  , Node (TS.TSNode "Brightness" "Sets screen brightness using xbacklight" (return ()))
    [ Node (TS.TSNode "Bright" "FULL POWER!!"            (spawn "xbacklight -set 100")) []
    , Node (TS.TSNode "Normal" "Normal Brightness (50%)" (spawn "xbacklight -set 50"))  []
    , Node (TS.TSNode "Dim"    "Quite dark"              (spawn "xbacklight -set 10"))  []
    ]
  , Node (TS.TSNode "Office               ->" "Collection of office programs" (return ()))
    [ Node (TS.TSNode "Bright" "FULL POWER!!"            (spawn "xbacklight -set 100")) []
    , Node (TS.TSNode "Normal" "Normal Brightness (50%)" (spawn "xbacklight -set 50"))  []
    , Node (TS.TSNode "Dim"    "Quite dark"              (spawn "xbacklight -set 10"))  []
    ]
  ]
