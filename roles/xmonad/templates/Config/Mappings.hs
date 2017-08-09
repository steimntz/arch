module Config.Mappings( keyMappings ) where

import XMonad
import XMonad.Core

keyMappings :: [(String, X())]
keyMappings = [ ("M-p", spawn "rofi -show run") ]
