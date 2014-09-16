import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Hooks.EwmhDesktops

import Data.List

-- ЖИЗНЬ-ТО НАЛАЖИВАЕТСЯ, username

theConfig = desktopConfig

myTerminal = "lxterminal"

myScreenShotDir = "$HOME/Pictures/Screenshots"

myManageHook = manageDocks <+> manageHook theConfig

myKeys = defineKeys [ ("M-p",        spawn dmenuRun)
                    , ("<Print>",    spawn sshot)
                    ]
  where defineKeys = keys . additionalKeysP theConfig

main = xmonad $ ewmh theConfig { modMask    = mod4Mask
                          , terminal   = myTerminal
                          , manageHook = myManageHook
                          , keys       = myKeys
                          , startupHook = startup
                          , handleEventHook = handleEventHook theConfig <+> fullscreenEventHook
                          }

startup :: X()
startup = do
  return ()

dmenuRun = unwords [ "dmenu_run "
                   , "-nb", "'#e0e0e0'"
                   , "-nf", "'#3b495e'"
                   , "-fn", "'DejaVu Sans Mono-10:style=bold'"
                   ]

sshot = unwords [ "mkdir -p", myScreenShotDir, ";"
                , "sfile=" ++ myScreenShotDir ++ "/" ++ "`date +'%Y%m%d%H%M%S'`.png", ";"
                , "import -window root $sfile", ";"
                , "xdg-open $sfile"
                ]
