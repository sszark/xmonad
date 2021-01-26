--------------------------------------------------------------------------------
-- |
-- Module       : ColorScheme
-- Copyright    : (c) sszark@protonmail.com
-- License      : BSD3-style (see LICENSE)
--
-- Maintainer   : sszark@protonmail.com
-- Stability    : stable
-- Portability  : portable
--
-- Color Schemes for Sszark's XMonad configuration
--
--------------------------------------------------------------------------------


module ColorScheme
     ( gruvboxDarkHard, gruvboxDarkVoid, Colors(..) ) where

--------------------------------------------------------------------------------
-- Color Scheme
--------------------------------------------------------------------------------
data Colors = 
  Colors
    { foreground    :: String
    , background    :: String
    , grey          :: String
    , black         :: String
    , red           :: String
    , green         :: String
    , yellow        :: String
    , blue          :: String
    , magenta       :: String
    , cyan          :: String
    , white         :: String 
    , brightBlack   :: String
    , brightRed     :: String
    , brightGreen   :: String
    , brightYellow  :: String
    , brightBlue    :: String
    , brightMagenta :: String
    , brightCyan    :: String
    , brightWhite   :: String
    }

--------------------------------------------------------------------------------
-- Color Scheme (Definitions)
--------------------------------------------------------------------------------
-- Gruvbox https://github.com/morhetz/gruvbox
gruvboxDarkHard = 
  Colors
    { foreground    = "#ebdbb2"
    , background    = "#1d2021"
    , black         = "#282828"
    , grey          = "#928374"
    , red           = "#cc241d"
    , green         = "#98971a"
    , yellow        = "#d79921"
    , blue          = "#458588"
    , magenta       = "#b16286"
    , cyan          = "#689d6a"
    , white         = "#a89984"
    , brightBlack   = "#928374"
    , brightRed     = "#fb4934"
    , brightGreen   = "#b8bb26"
    , brightYellow  = "#fabd2f"
    , brightBlue    = "#83a598"
    , brightMagenta = "#d3869b"
    , brightCyan    = "#8ec07c"
    , brightWhite   = "#ebdbb2"
    }

-- Modified version of 'Gruvbox Dark Hard'
gruvboxDarkVoid = gruvboxDarkHard { background = "#000000" }

