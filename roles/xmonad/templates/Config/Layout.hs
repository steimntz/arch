module Config.Layout( myLayout ) where

import XMonad
import XMonad.Layout.Gaps
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

gapWidth=5

myLayout = lessBorders OnlyScreenFloat $ spacing gapWidth $
           gaps [(U, gapWidth*3), (L, gapWidth), (R, gapWidth), (D, gapWidth)] $
           mkToggle (NOBORDERS ?? FULL ?? EOT) $
           tiledHalf 
           ||| Mirror tiledTwoThirds
           ||| Full
           ||| writeroom

  where
     tiledTwoThirds   = Tall nmaster delta ratioTwoThirds
     tiledHalf = Tall nmaster delta ratioHalf
     writeroom = renamed [Replace "writeroom"] $ gaps [(L, gapWidth*100), (R, gapWidth*100)] Full
 
     -- The default number of windows in the master pane
     nmaster = 1
 
     -- Default proportion of screen occupied by master pane
     ratioTwoThirds   = 2/3
     ratioHalf = 1/2
 
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
