module Config.LogHook( myLogHook ) where

import System.IO
import XMonad.Hooks.DynamicLog

yellowHl = "#ffe059"
red      = "#924650"

circlify :: Bool -> String -> String
circlify True  _  = "<raw=1:\61713/>"
circlify False _  = "<raw=1:\61708/>"

myLogHook xmproc = dynamicLogWithPP xmobarPP { ppOutput  = hPutStrLn xmproc
                                      , ppTitle   = xmobarColor "#4f8396" "" . shorten 50
                                      , ppCurrent = xmobarColor red "#333333" . circlify True
                                      , ppHidden  = xmobarColor yellowHl "#222222". circlify False
                                      , ppUrgent  = xmobarColor "red" "#222222"
                                      , ppWsSep   = " "
                                      }
