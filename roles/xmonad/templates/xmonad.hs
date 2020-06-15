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

main = do
 xmproc <- spawnPipe "xmobar"
 xmonad $ def
  { terminal                     = "urxvt"
  , modMask                      = mod4Mask
  , borderWidth                  = 2
  , focusedBorderColor           = "#ba9864"
  , startupHook                  = StartUp.hooks
  , manageHook                   = myManageHook
  , layoutHook                   = avoidStruts $ myLayout
  , logHook                      = dynamicLogWithPP xmobarPP { ppOutput = hPutStrLn xmproc
                                                             , ppTitle  = xmobarColor "#4f8396" "" . shorten 50
                                                             }
  } `additionalKeysP` Cfg.keyMappings
