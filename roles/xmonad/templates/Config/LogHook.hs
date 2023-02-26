module Config.LogHook( myLogHookDbus, myLogHookXmobar ) where

import System.IO
import XMonad.Hooks.DynamicLog
import qualified XMonad.DBus as D
import qualified DBus.Client as DC

import Config.XColors as Colors

highlight = Colors.fromXres $ Colors.fromXres "stz.hl"
primary = Colors.fromXres $ Colors.fromXres "stz.primary"
background = Colors.fromXres "*background"
foreground = Colors.fromXres "*foreground"

circlify :: Bool -> String -> String
circlify True  _  = xmobarRaw "\61713"
circlify False _  = xmobarRaw "\61708"

myLayoutPrinter :: String -> String
myLayoutPrinter "Spacing Full"        = xmobarRaw "\57949"
myLayoutPrinter "Spacing Tall"        = xmobarRaw "\64319"
myLayoutPrinter "Spacing Mirror Tall" = xmobarRaw "ﳶ"
myLayoutPrinter "Spacing writeroom"   = xmobarRaw "\63251"
myLayoutPrinter x                     = xmobarRaw "\61738"

myDbus :: DC.Client -> PP
myDbus dbus = def { ppOutput = D.send dbus }

myLogHookDbus dbus = dynamicLogWithPP (myDbus dbus)

myLogHookXmobar xmproc = dynamicLogWithPP xmobarPP { ppOutput    = hPutStrLn xmproc
                                             , ppTitle     = xmobarColor foreground background . shorten 50
                                             , ppCurrent   = xmobarColor primary background . circlify True
                                             , ppHidden    = xmobarColor highlight background. circlify False
                                             , ppUrgent    = xmobarColor "white" background
                                             , ppLayout    = myLayoutPrinter
                                             , ppWsSep     = " "
                                             }
