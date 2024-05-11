module Config.ManageHook( myManageHook ) where

import XMonad
import System.IO
import XMonad.Layout.Fullscreen
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W

myFloats  = ["steam"]

myManageHook = composeAll . concat $
    [ [className =? "Peek"  --> doFloat]
    , [isFullscreen         --> (doF W.focusDown <+> doFullFloat)]
    ]
