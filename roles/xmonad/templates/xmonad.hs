import XMonad
import XMonad.Util.EZConfig
import Config.Mappings as Cfg
import XMonad.Hooks.SetWMName

main = xmonad $ def
  { terminal    = "urxvt"
  , modMask     = mod4Mask
  , borderWidth = 2
  , startupHook = setWMName "LG3D"
  } `additionalKeysP` Cfg.keyMappings
