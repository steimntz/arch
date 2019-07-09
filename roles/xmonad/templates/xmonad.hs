import XMonad
import XMonad.Util.EZConfig
import Config.Mappings as Cfg
import Config.StartUpHooks as StartUp
import Config.Layout

main = xmonad $ def
  { terminal    = "urxvt"
  , modMask     = mod4Mask
  , borderWidth = 2
  , startupHook = StartUp.hooks
  , layoutHook  = myLayout
  } `additionalKeysP` Cfg.keyMappings
