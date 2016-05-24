import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.StackTile
import XMonad.Layout.PerWorkspace
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicLog
import System.IO

defaultLayout = (avoidStruts $ smartBorders (tiled ||| Mirror tiled)) |||
    noBorders Full |||
    noBorders simpleTabbed
  where
    tiled = spacing 2 $ Tall nmaster delta ratio
    nmaster = 1      -- The default number of windows in the master pane.
    ratio   = 1/2    -- Default proportion of screen occupied by master pane.
    delta   = 3/100  -- Percent of screen to increment by when resizing panes.

myLayout = 
    onWorkspace "1:web" (tabbed ||| (avoidStruts $ tabbed)) $
    defaultLayout
  where
    tabbed = noBorders simpleTabbed

myWorkspaces :: [String]
myWorkspaces =  ["1:web","2:term"] ++ map show [3..5]

color0 :: String
color0 = "#456def"

myKeys = [
         ("M-q",     kill)
         ]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { modMask = mod4Mask
        , terminal = "urxvt"
        , workspaces           = myWorkspaces
        , borderWidth          = 1
        , normalBorderColor = "#abc123"
        , focusedBorderColor = color0
        , handleEventHook    = fullscreenEventHook
        , layoutHook = myLayout
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor color0 "" . shorten 50
                        }
        } `additionalKeysP` myKeys

