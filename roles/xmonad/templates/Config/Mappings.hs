module Config.Mappings( keyMappings, myMouseKeys ) where

import XMonad
import XMonad.Core
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import qualified XMonad.StackSet as W

myMouseKeys :: [((KeyMask, KeySym), X())]
myMouseKeys = [ ((0, xK_h), spawn "xdotool mousemove_relative -- -10 0")
              , ((0, xK_l), spawn "xdotool mousemove_relative 10 0")
              , ((0, xK_j), spawn "xdotool mousemove_relative 0 10")
              , ((0, xK_k), spawn "xdotool mousemove_relative 0 -10")
              , ((controlMask, xK_h), spawn "xdotool mousemove_relative -- -1 0")
              , ((controlMask, xK_l), spawn "xdotool mousemove_relative 1 0")
              , ((controlMask, xK_j), spawn "xdotool mousemove_relative 0 1")
              , ((controlMask, xK_k), spawn "xdotool mousemove_relative 0 -1")
              , ((shiftMask, xK_h), spawn "xdotool mousemove_relative -- -100 0")
              , ((shiftMask, xK_l), spawn "xdotool mousemove_relative 100 0")
              , ((shiftMask, xK_j), spawn "xdotool mousemove_relative 0 100")
              , ((shiftMask, xK_k), spawn "xdotool mousemove_relative 0 -100")
              , ((0, xK_c), spawn "xdotool click 1")
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
