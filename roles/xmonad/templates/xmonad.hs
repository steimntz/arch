import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ManageDocks
import Config.Mappings as Cfg
import Config.XColors as Colors
import Config.StartUpHooks as StartUp
import Config.XMobarHs as Bar
import Config.Layout
import Config.ManageHook
import Config.LogHook

primary = Colors.fromXres $ Colors.fromXres "stz.primary"

xmobarcfg = Bar.config {  font = "xft:DejaVuSansMono Nerd Font Mono:pixelsize=12:antialiase=true:autohinting=true"
        , additionalFonts = ["xft:DejaVuSansMono Nerd Font Mono:pixelsize=18:antialiase=true:autohinting=true", "xft:DejaVuSansMono Nerd Font Mono:pixelsize=10:antialiase=true:autohinting=true"]
        , textOffsets = [15]
        , borderColor = "#ba9864"
        , border = BottomB
        , bgColor = "#222222"
        , fgColor = "#888888"
--        , position = TopW L 100
        , commands = [ Run $ Weather "CYVR" ["-t","<tempC>C","-L","18","-H","25","--normal","#4f8396","--high","red","--low","lightblue"] 36000
                     , Run $ Network "enp5s0" ["-L","0","-H","32","--normal","#4f8396","--high","#4f8396a", "--template", "<dev>: <fn=2> <tx>kB/s  <rx>kB/s</fn>", "--Low", "1000", "--High", "5000"] 10
                     , Run $ Cpu ["-L","3","-H","50","--normal","#4f8396","--high","red"] 10
                     , Run $ Memory ["-t","Mem: <usedratio>%"] 10
                     , Run $ Swap [] 10
                     , Run $ Com "uname" ["-s","-r"] "" 36000
                     , Run $ Date "%a %b %_d %Y %H:%M:%S" "date" 10
                     , Run $ StdinReader
                     ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "<fc=#ba9864>%StdinReader%</fc>  <fn=1></fn> %cpu%  <fn=1></fn> %memory% * %swap%  <fn=1></fn> %enp5s0% }{<fc=#ba9864>%date%</fc>  <fn=1></fn> %uname%  <fn=1></fn> %CYVR% "
        }

main = do
 Bar.export $ xmobarcfg
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
  } `additionalKeysP` Cfg.keyMappings
