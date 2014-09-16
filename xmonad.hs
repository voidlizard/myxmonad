import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig

import Data.List

-- ЖИЗНЬ-ТО НАЛАЖИВАЕТСЯ, username

theConfig = desktopConfig

myTerminal = "lxterminal"

dmenuRun = unwords [ "dmenu_run "
                   , "-nb", "'#e0e0e0'"
                   , "-nf", "'#3b495e'"
                   , "-fn", "'DejaVu Sans Mono-10:style=bold'"
                   ]

myScreenShotDir = "$HOME/Pictures/Screenshots"

sshot = unwords [ "mkdir -p", myScreenShotDir, ";"
                , "sfile=" ++ myScreenShotDir ++ "/" ++ "`date +'%Y%m%d%H%M%S'`.png", ";"
                , "import -window root $sfile", ";"
                , "xdg-open $sfile"
                ]

myManageHook = manageDocks <+> manageHook theConfig

myKeys = keys $ additionalKeysP theConfig newKeys
  where newKeys = [ ("M-p",        spawn dmenuRun)
                  , ("<Print>",    spawn sshot)
                  ]

main = xmonad $ theConfig { modMask    = mod4Mask
                          , terminal   = myTerminal
                          , manageHook = myManageHook
                          , keys       = myKeys
                          }

