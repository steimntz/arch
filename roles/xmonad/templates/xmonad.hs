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
import qualified XMonad.DBus as D
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP (PP, def)

statusBarPP :: PP
statusBarPP = def

primary = Colors.fromXres $ Colors.fromXres "stz.primary"

mySB = statusBarProp "polybar --reload -c ~/.config/polybar/config.ini" (pure statusBarPP)

main = do
 export
 xmproc <- spawnPipe "polybar"
 dbus <- D.connect
 D.requestAccess dbus
 xmonad . withEasySB mySB defToggleStrutsKey $ def
  { terminal                     = "urxvt"
  , modMask                      = mod4Mask
  , borderWidth                  = 2
  , focusedBorderColor           = primary
  , startupHook                  = StartUp.hooks
  , manageHook                   = myManageHook
  , layoutHook                   = avoidStruts $ myLayout
  , logHook                      = myLogHookDbus dbus
  } `additionalKeysP` Cfg.keyMappings `additionalKeys` Cfg.myMouseKeys
