--------------------------------------------------------------------------------
--   / _ \   * XMonad 0.15 (Dynamic X11 window manager written in Haskell)    --
-- \_\(_)/_/ *                                                                --
--  _//"\\_  * Sszark <sszark@protonmail.com>                                 --
--   /   \   * https://sszark.se/git/dotfiles/blob/xmonad/                    --
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- TODO
--------------------------------------------------------------------------------

{-|
 
 * Implement mouse resizing for windows in tiled mode
 * Extract (Search Engines) from `Prompts.hs` to it's own module
 * Move `manageHook` to it's own module
 * Layouts
   * Floating layout with decorations/buttons
   * Tabbed layout
   * Ewmh Fullscreen auto detection for applications

 -}

-- Points of Interest-----------------------------------------------------------

{-|
 
 * `XMonad.Actions.CopyWindow`
    Provides dwm style tags across workspaces
 
 * `XMonad.Actions.CycleSelectedLayouts`
    Better layout cycling

 * `XMonad.Actions.CycleWorkspaceByScreen`
    Screen specific workspace toggles

 * `XMonad.Actions.DwmPromote`
   `XMonad.Actions.Promote`
    Adopt focused window as the new master (switch)

 * `XMonad.Actions.DynamicProjects`
   `XMonad.Actions.DynamicWorkspaceGroups`
   `XMonad.Actions.DynamicWorkspaceOrder`
    Workspace templates for specific workflows

 * `XMonad.Actions.TopicSpace`
    Organize workspaces by topic

 * `XMonad.Actions.FlexibleResize`
    Resize floating windows from all corners (only bottom right by default)

 * `XMonad.Actions.FloatKeys`
    Manipulate floating windows

 * `XMonad.Actions.FloatSnap`
    Floating windows snap to other windows (simpler alignment/resize)

 * `XMonad.Actions.Minimize`
   `XMonad.Hooks.Minimize`
    Minimizing windows (for decoration buttons etc)

 * `XMonad.Actions.Navigation2D`
    2D navigation (up, down, left, right etc) instead of incrementing the stack

 * `XMonad.Actions.RotSlaves`
    Rotate non-master windows in the stack

 * `XMonad.Actions.WithAll`
    Unfloat all windows on a workspace (do an operation to all windows in a WS)

 * `XMonad.Actions.SwapWorkspaces`
    Swap workspace positions

 * `XMonad.Actions.TagWindows`
    Tag individual windows

 * `XMonad.Actions.GridSelect`
    Prompt / Rofi Window like functionality in a grid overlay

 * `XMonad.Actions.TreeSelect`
    Openbox Menu like functionality for selecting items from a list

 * `XMonad.Actions.WindowBringer`
   `XMonad.Actions.WindowGo`
    Menu that brings you to windows you can't find

 * `XMonad.Actions.WindowMenu`
    Grid select centered on the window to perform window operations

================================================================================

 * `XMonad.Hooks.CurrentWorkspaceOnTop`
    Window will always be on top?

 * `XMonad.Hooks.FloatNext`
    Sets new windows spawned to floating mode automatically

 * `XMonad.Hooks.PositionStoreHooks`
   `XMonad.Layout.PositionStoreFloat`
    Remember window positions and sizes

 * `XMonad.Hooks.ServerMode`
    Monitor and control xmonad remotely

================================================================================

 * `XMonad.Layout.BorderResize`
    Resize windows by dragging the borders

 * `XMonad.Layout.ButtonDecoration`
   `XMonad.Layout.ImageButtonDecoration` 
    Add buttons to decorations

 * `XMonad.Layout.SimpleDecoration`
    Decorations

 * `XMonad.Layout.Fullscreen`
    Fullscreen

 * `XMonad.Layout.Gaps`
    Window Gaps

 * `XMonad.Layout.Maximize`
    Fill the screen with a window

 * `XMonad.Layout.MouseResizableTile`
    Resize window with mouse

 * `XMonad.Layout.NoFrillsDecoration`
    Decorations

 * `XMonad.Layout.PerScreen`
    Layout auto-selector for different screen sizes

 * `XMonad.Layout.PerWorkspace`
    Layout auto-select for different workspaces

 * `XMonad.Layout.SimpleFloat`
    Floating Windows

 * `XMonad.Layout.Spacing`
    Gaps around the edges of windows

 * `XMonad.Layout.Stoppable`
    Extreme power savings (stops processes that are hidden)

 * `XMonad.Layout.TabBarDecoration`
    Different version of tabs?

 * `XMonad.Layout.WindowArranger`
    Modify windows by resizing and moving them around in all directions

 * `XMonad.Layout.WindowNavigation`
    Navigate workspaces

================================================================================

 * `XMonad.Prompt.AppendFile`
    Append text from the prompt to a file (note taking)

 * `XMonad.Prompt.Layout`
    Select a layout from prompt

 * `XMonad.Prompt.Man`
    Prompt for opening man pages

 * `XMonad.Prompt.Pass`
    Pass password manager prompt (might use instead of keepass??)

 * `XMonad.Prompt.Ssh`
    SSH prompt for remote connections

 * `XMonad.Prompt.Unicode`
    Search unicode symbols and copy them to clipboard

 * `XMonad.Prompt.Window`
    Select windows and bring it forth or go to it

 * `XMonad.Prompt.Workspace`
    Select workspace and go there

================================================================================

 * `XMonad.Util.Cursor`
    Set X11 cursor

 * `XMonad.Util.ExclusiveScratchpads`
    Alternative version of scratchpads??

 -}

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------
-- Base
import XMonad

-- Utilities
import XMonad.Util.NamedScratchpad (namedScratchpadManageHook)
import XMonad.Util.EZConfig        (additionalKeysP)
import XMonad.Util.Run             (spawnPipe)

-- Hooks
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks  (docks)

-- Modules ---------------------------------------------------------------------
import Config
  ( myFocusFollowsMouse
  , myBorderWidth
  , myNormalColor
  , myWorkspaces
  , myFocusColor
  , myTerminal
  , myModMask
  , myBar'
  )

import Keybindings (myKeys)
import Scratchpads (myScratchPads)
import Startup     (myStartupHook)
import Layout      (myLayoutHook)
import Event       (myEventHook)
import Log         (myLogHook)

--------------------------------------------------------------------------------
-- Main
--------------------------------------------------------------------------------
main :: IO ()
main = do
  xmproc <- spawnPipe (myBar')
  xmonad $ ewmh $ docks def
    { modMask            = myModMask
    , focusFollowsMouse  = myFocusFollowsMouse
    , terminal           = myTerminal
    , startupHook        = myStartupHook
    , layoutHook         = myLayoutHook
    , workspaces         = myWorkspaces
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalColor
    , focusedBorderColor = myFocusColor
    , handleEventHook    = myEventHook
    , manageHook         = namedScratchpadManageHook myScratchPads
    , logHook            = myLogHook xmproc
    } `additionalKeysP` myKeys

