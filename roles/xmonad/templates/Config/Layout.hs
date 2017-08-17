module Config.Layout( myLayout ) where

import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps

gapWidth=5

myLayout = spacing gapWidth $ gaps [(U,gapWidth),(D,gapWidth),(L,gapWidth),(R,gapWidth)] $

           tiledHalf 
           ||| Mirror tiledTwoThirds
           ||| Full

  where
     -- default tiling algorithm partitions the screen into two panes
     tiledTwoThirds   = Tall nmaster delta ratioTwoThirds
     tiledHalf = Tall nmaster delta ratioHalf
 
     -- The default number of windows in the master pane
     nmaster = 1
 
     -- Default proportion of screen occupied by master pane
     ratioTwoThirds   = 2/3
     ratioHalf = 1/2
 
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
