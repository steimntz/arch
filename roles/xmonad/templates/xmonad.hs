import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ManageDocks
import Config.XMobarHs
import Config.Mappings as Cfg
import Config.XColors as Colors
import Config.StartUpHooks as StartUp
import Config.Layout
import Config.ManageHook
import Config.LogHook

primary = Colors.fromXres $ Colors.fromXres "stz.primary"

main = do
 export
 xmproc <- spawnPipe "xmobar"
 xmonad $ def
  { terminal                     = "urxvt"
  , modMask                      = mod4Mask
  , borderWidth                  = 2
  , focusedBorderColor           = primary
  , startupHook                  = StartUp.hooks
  , manageHook                   = myManageHook
  , layoutHook                   = avoidStruts $ myLayout
  , logHook                      = myLogHook xmproc
  } `additionalKeysP` Cfg.keyMappings `additionalKeys` Cfg.myMouseKeys
