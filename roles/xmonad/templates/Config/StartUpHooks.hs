module Config.StartUpHooks( hooks ) where

import XMonad
import XMonad.Core
import XMonad.Hooks.SetWMName

hooks :: X()
hooks = do
        setWMName "LG3D"
        spawn "xinput list | egrep \"slave.*pointer\" | grep Mouse | grep -v XTEST | sed -e 's/^.*id=//' -e 's/\\s.*$//' | xargs -IMouse sh -c 'echo \"Setting mouse Mouse\"; xinput get-button-map Mouse | tr \" \" \"\n\" | sort -g | xargs | sed \"s,4 5,5 4,g\" | xargs -i sh -c \"xinput set-button-map Mouse {}; echo {};\"'"
        spawn "/usr/bin/xscreensaver-command -exit && /usr/bin/xscreensaver &"
