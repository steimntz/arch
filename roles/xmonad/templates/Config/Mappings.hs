module Config.Mappings( keyMappings ) where

import XMonad
import XMonad.Core
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import qualified XMonad.StackSet as W

keyMappings :: [(String, X())]
keyMappings = [ ("M-p", spawn "rofi -show run")
              , ("C-<F10>", spawn "sleep 0.2; scrot -s -e 'mv $f ~/screenshots'")
              , ("M-<Esc>", spawn "xscreensaver-command -lock")
              , ("M-f", sendMessage $ Toggle FULL)
              , ("M-t", withFocused $ windows . W.sink)
              ]
