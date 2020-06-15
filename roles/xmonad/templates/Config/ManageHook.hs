module Config.ManageHook( myManageHook ) where

import XMonad
import System.IO

myManageHook = composeAll
    [ className =? "Peek"      --> doFloat]
