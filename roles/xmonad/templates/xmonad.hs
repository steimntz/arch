import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ManageDocks
import Config.Mappings as Cfg
import Config.StartUpHooks as StartUp
import Config.Layout
import Config.ManageHook
import Config.LogHook

yellow   = "#ba9864"

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
  , logHook                      = myLogHook xmproc
  } `additionalKeysP` Cfg.keyMappings
