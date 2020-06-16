module Config.LogHook( myLogHook ) where

import System.IO
import XMonad.Hooks.DynamicLog

yellowHl = "#ffe059"
red      = "#924650"

circlify :: Bool -> String -> String
circlify True  _  = xmobarRaw "\61713"
circlify False _  = xmobarRaw "\61708"

myLayoutPrinter :: String -> String
myLayoutPrinter "Spacing Full"        = xmobarRaw "\57949"
myLayoutPrinter "Spacing Tall"        = xmobarRaw "\64319"
myLayoutPrinter "Spacing Mirror Tall" = xmobarRaw "ﳶ"
myLayoutPrinter "Spacing writeroom"   = xmobarRaw "\63251"
myLayoutPrinter x                     = xmobarRaw "\61738"

myLogHook xmproc = dynamicLogWithPP xmobarPP { ppOutput  = hPutStrLn xmproc
                                      , ppTitle   = xmobarColor "#4f8396" "" . shorten 50
                                      , ppCurrent = xmobarColor red "#222222" . circlify True
                                      , ppHidden  = xmobarColor yellowHl "#222222". circlify False
                                      , ppUrgent  = xmobarColor "red" "#222222"
                                      , ppLayout  = myLayoutPrinter
                                      , ppWsSep   = " "
                                      }
