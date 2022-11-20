module Config.XMobarHs
( Config   (..)
, Position (..)
, Align    (..)
, Border   (..)
, Command  (..)
, Run      (..)
, config
, export
) where

import Data.List
import Config.XColors as Colors

data Config = Config { font         :: String
                     , additionalFonts :: [String]
                     , textOffsets :: [Int]
                     , bgColor      :: String
                     , fgColor      :: String
                     , position     :: Position
                     , lowerOnStart :: Bool
                     , hideOnStart  :: Bool
                     , persistent   :: Bool
                     , border       :: Border
                     , borderColor  :: String
                     , commands     :: [Run Command]
                     , sepChar      :: String
                     , alignSep     :: String
                     , template     :: String
                     }

cfgPairs :: [(String, (Config -> String))]
cfgPairs = [ ("font"         , show.font        )
           , ("bgColor"      , show.bgColor     )
           , ("fgColor"      , show.fgColor     )
           , ("position"     , show.position    )
           , ("lowerOnStart" , show.lowerOnStart)
           , ("hideOnStart"  , show.hideOnStart )
           , ("persistent"   , show.persistent  )
           , ("border"       , show.border      )
           , ("borderColor"  , show.borderColor )
           , ("commands"     , show.commands    )
           , ("sepChar"      , show.sepChar     )
           , ("alignSep"     , show.alignSep    )
           , ("template"     , show.template    )
           ]

config :: Config
config = Config { font         = "-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*"
                , additionalFonts = ["xft:DejaVuSansMono Nerd Font Mono:pixelsize=10:antialiase=true:autohinting=true"]
                , textOffsets = [12]
                , bgColor      = "#ffffff"
                , fgColor      = "#ffffff"
                , position     = Top
                , lowerOnStart = True
                , hideOnStart  = False
                , persistent   = False
                , border       = NoBorder
                , borderColor  = "#ffffff"
                , commands     = [ Run $ Date "%a %b %_d %Y * %H:%M:%S" "theDate" 10, Run StdinReader]
                , sepChar      = "%"
                , alignSep     = "}{"
                , template     = "%StdinReader% }{ <fc=#00FF00>%uname%</fc> * <fc=#FF0000>%theDate%</fc>"
                }

instance Show Config where
  showsPrec _ n s = "Config {" ++ e n ++ "}" ++ s
    where e x = intercalate ", " [g (fst y) | y <- f x, uncurry (/=) y]
          f x = zip (h x) (h config)
          g x = fst x ++ " = " ++ snd x
          h x = map (\y -> (fst y, snd y x)) cfgPairs

data Position = Top    | TopW    Align Int | TopSize    Align Int Int
              | Bottom | BottomW Align Int | BottomSize Align Int Int
              | Static { xpos  :: Int, ypos   :: Int
                       , width :: Int, height :: Int
                       } deriving Show

data Align = L | C | R deriving Show

data Border = TopB    | TopBM    Int
            | BottomB | BottomBM Int
            | FullB   | FullBM   Int
            | NoBorder deriving Show

data Command = Uptime                                [String] Int
             | Weather            String             [String] Int
             | Network            String             [String] Int
             | DynNetwork                            [String] Int
             | Wireless           String             [String] Int
             | Memory                                [String] Int
             | Swap                                  [String] Int
             | Cpu                                   [String] Int
             | MultiCpu                              [String] Int
             | Battery                               [String] Int
             | BatteryP           [String]           [String] Int
             | TopProc                               [String] Int
             | TopMem                                [String] Int
             | DiskU              [(String, String)] [String] Int
             | DiskIO             [(String, String)] [String] Int
             | ThermalZone        Int                [String] Int
             | Thermal            String             [String] Int
             | CpuFreq                               [String] Int
             | CoreTemp                              [String] Int
             | Volume             String String      [String] Int
             | MPD                                   [String] Int
             | Mpris1             String             [String] Int
             | Mpris2             String             [String] Int
             | Mail               [(String, String)] String
             | Mbox               [(String, String, String)] [String] String
             | XPropertyLog       String
             | NamedXPropertyLog  String String
             | Brightness         [String]                    Int
             | Kbd                [(String, String)]
             | Locks
             | Com                String [String] String      Int
             | StdinReader
             | Date               String String               Int
             | DateZone           String String String String Int
             | CommandReader      String String
             | PipeReader         String String
             | BufferedPipeReader String [(Int, Bool, String)]
             | XMonadLog
             deriving Show

highlight = Colors.fromXres $ Colors.fromXres "stz.hl"
primary = Colors.fromXres $ Colors.fromXres "stz.primary"
secondary = Colors.fromXres $ Colors.fromXres "stz.secondary"
background = Colors.fromXres "*background"
foreground = Colors.fromXres "*foreground"
blue = Colors.fromXres "*color4"
lightblue = Colors.fromXres "*color8"
red = Colors.fromXres "*color1"
lightyellow = Colors.fromXres "*color11"

xmobarcfg = config {  font = "xft:DejaVuSansMono Nerd Font Mono:pixelsize=12:antialiase=true:autohinting=true"
          , additionalFonts = ["xft:DejaVuSansMono Nerd Font Mono:pixelsize=18:antialiase=true:autohinting=true", "xft:DejaVuSansMono Nerd Font Mono:pixelsize=10:antialiase=true:autohinting=true"]
          , textOffsets = [15]
          , border = BottomB
          , borderColor = primary
          , bgColor = background
          , fgColor = foreground
          , position = TopW L 100
          , commands = [ Run $ Weather "CYVR" ["-t","<tempC>C","-L","18","-H","25","--normal",blue,"--high",red,"--low",lightblue] 36000
                       , Run $ Network "enp5s0" ["-L","0","-H","32","--normal",blue,"--high",blue++"a", "--template", "<dev>: <fn=2> <tx>kB/s  <rx>kB/s</fn>", "--Low", "1000", "--High", "5000"] 10
                       , Run $ Cpu ["-L","3","-H","50","--normal",blue,"--high",red] 10
                       , Run $ Memory ["-t","Mem: <usedratio>%"] 10
                       , Run $ Swap [] 10
                       , Run $ Volume "default" "Master" ["-t", "<fn=2>\xf028</fn> <volume>%"] 10
                       , Run $ Com "uname" ["-s","-r"] "" 36000
                       , Run $ Date "%a %b %_d %Y %H:%M:%S" "date" 10
                       , Run $ StdinReader
                       ]
          , sepChar = "%"
          , alignSep = "}{"
          , template = "<fc=" ++ secondary ++ ">%StdinReader%</fc>  <fn=1></fn> %cpu%  <fn=1></fn> %memory% * %swap%  <fn=1></fn> %enp5s0% }{%default:Master% <fc=" ++ lightyellow ++ ">%date%</fc>  <fn=1></fn> %uname%  <fn=1></fn> %CYVR% "
          }

data Run a = Run a

instance Show a => Show (Run a) where
  showsPrec _ (Run x) s = "Run " ++ show x ++ s

export :: IO ()
export = writeFile ".xmobarrc" $ show xmobarcfg
