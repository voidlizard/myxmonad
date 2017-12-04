import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName

import Data.List

-- ЖИЗНЬ-ТО НАЛАЖИВАЕТСЯ, username

theConfig = desktopConfig

myTerminal = "mate-terminal"

myScreenShotDir = "$HOME/Pictures/Screenshots"

myManageHook = manageDocks <+> manageHook theConfig

myKeys = defineKeys [ ("M-p",        spawn dmenuRun)
                    , ("<Print>",    spawn sshot)
                    , ("S-<Print>",  spawn sshotClip)
                    , ("M1-C-l",     spawn lock)
                    , ("<XF86AudioLowerVolume>", spawn volumeLo)
                    , ("<XF86AudioRaiseVolume>", spawn volumeHi)
                    , ("<XF86AudioMute>",        spawn volumeToggle)
                    ]
  where defineKeys = keys . additionalKeysP theConfig

conf = ewmh theConfig { modMask    = mod4Mask
                      , terminal   = myTerminal
                      , manageHook = myManageHook
                      , keys       = myKeys
                      , startupHook = startup
                      , handleEventHook = handleEventHook theConfig <+> fullscreenEventHook
                      }

main = do
  xmonad conf { startupHook = startupHook conf >> setWMName "LG3D"
              }
startup :: X()
startup = do
  return ()

volumeToggle  = "amixer -q sset Master toggle"

volumeLo = "amixer -q sset Master 1%-"

volumeHi = "amixer -q sset Master 1%+"

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

sshotClip = unwords [ "import 'png:-' | xclip -selection clipboard -target image/png -i"
                    ]

lock = "dm-tool lock"
