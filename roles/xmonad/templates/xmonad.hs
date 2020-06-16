import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import Config.Mappings as Cfg
import Config.StartUpHooks as StartUp
import Config.Layout
import Config.ManageHook
import System.IO

yellow   = "#ba9864"
yellowHl = "#ffe059"
red      = "#924650"

circlify :: Bool -> String -> String
circlify True  _  = "<raw=1:\61713/>"
circlify False _  = "<raw=1:\61708/>"

main = do
 xmproc <- spawnPipe "xmobar"
 xmonad $ def
  { terminal                     = "urxvt"
  , modMask                      = mod4Mask
  , borderWidth                  = 2
  , focusedBorderColor           = yellow
  , startupHook                  = StartUp.hooks
  , manageHook                   = myManageHook
  , layoutHook                   = avoidStruts $ myLayout
  , logHook                      = dynamicLogWithPP xmobarPP { ppOutput  = hPutStrLn xmproc
                                                             , ppTitle   = xmobarColor "#4f8396" "" . shorten 50
                                                             , ppCurrent = xmobarColor red "#333333" . circlify True
                                                             , ppHidden  = xmobarColor yellowHl "#222222". circlify False
                                                             , ppUrgent  = xmobarColor "red" "#222222"
                                                             , ppWsSep   = " "
                                                             }
  } `additionalKeysP` Cfg.keyMappings
