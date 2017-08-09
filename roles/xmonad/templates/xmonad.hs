import XMonad
import XMonad.Util.EZConfig
import Config.Mappings as Cfg

main = xmonad $ def
  { terminal    = "urxvt"
  , modMask     = mod4Mask
  , borderWidth = 2
  } `additionalKeysP` Cfg.keyMappings
