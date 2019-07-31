module Config.Mappings( keyMappings ) where

import XMonad
import XMonad.Core

keyMappings :: [(String, X())]
keyMappings = [ ("M-F11", spawn "rofi -show run")
              , ("C-<F11>", spawn "sleep 0.2; scrot -s -e 'mv $f ~/screenshots'") ]
