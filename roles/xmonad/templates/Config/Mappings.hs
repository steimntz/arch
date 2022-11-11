module Config.Mappings( keyMappings, myMouseKeys ) where

import XMonad
import XMonad.Core
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import qualified XMonad.StackSet as W

myMouseKeys :: [((KeyMask, KeySym), X())]
myMouseKeys = [ ((0, 0x1008ff11), spawn "pacmd list-sinks | grep -B 4 RUNNING | grep index | awk ' { print $NF } ' | xargs -i pactl set-sink-volume {} -2%")
              , ((0, 0x1008ff13), spawn "pacmd list-sinks | grep -B 4 RUNNING | grep index | awk ' { print $NF } ' | xargs -i pactl set-sink-volume {} +2%")
              ]

keyMappings :: [(String, X())]
keyMappings = [ ("M-p", spawn "rofi -show run")
              , ("C-<F10>", spawn "sleep 0.2; scrot -s -e 'mv $f ~/screenshots'")
              , ("M-<Esc>", spawn "xscreensaver-command -lock")
              , ("M-f", sendMessage $ Toggle FULL)
              , ("M-t", withFocused $ windows . W.sink)
              -- Mouse Movements
              , ("xk_l", spawn "xdotool mousemove_relative -- +10 0")
              , ("xk_h", spawn "xdotool mousemove_relative -- -10 0")
              , ("xk_j", spawn "xdotool mousemove_relative -- 0 +10")
              , ("xk_k", spawn "xdotool mousemove_relative -- 0 -10")
              , ("C-M-l", spawn "xdotool mousemove_relative -- +10 0")
              , ("C-M-h", spawn "xdotool mousemove_relative -- -10 0")
              , ("C-M-j", spawn "xdotool mousemove_relative -- 0 +10")
              , ("C-M-k", spawn "xdotool mousemove_relative -- 0 -10")
              , ("M-i", spawn "xdotool click --clearmodifiers 1")
              , ("C-M-p", spawn "xdotool click --clearmodifiers 2")
              , ("M-S-i", spawn "xdotool click --clearmodifiers 3")
              , ("C-S-M-l", spawn "xdotool mousemove_relative -- +100 0")
              , ("C-S-M-h", spawn "xdotool mousemove_relative -- -100 0")
              , ("C-S-M-j", spawn "xdotool mousemove_relative -- 0 +100")
              , ("C-S-M-k", spawn "xdotool mousemove_relative -- 0 -100")
              ]
