module Config.Mappings( keyMappings ) where

import XMonad
import XMonad.Core

keyMappings :: [(String, X())]
keyMappings = [ ("M-p", spawn "rofi -show run")
              , ("C-<F10>", spawn "sleep 0.2; scrot -s -e 'mv $f ~/screenshots'")
              , ("M-<Esc>", spawn "xscreensaver-command -lock")
              ]
