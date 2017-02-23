import System.IO
import Data.Ratio((%))
import Control.Monad (liftM2)

import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.Place

import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)

import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.StackTile
import XMonad.Layout.PerWorkspace
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Gaps
import XMonad.Layout.Mosaic

import XMonad.Actions.CycleWS
import XMonad.Actions.WindowBringer
import XMonad.Actions.GridSelect
import XMonad.Actions.FloatKeys

import XMonad.Layout.MultiToggle

import XMonad.Layout.MultiToggle.Instances(StdTransformers(MIRROR))

import XMonad.Layout.MultiColumns

import XMonad.Layout.IndependentScreens

import qualified XMonad.StackSet as W


defaultLayout = (smartBorders lay) |||
                (avoidStruts $ smartBorders $ lay) |||
                (noBorders Full)
   where
    lay = mkToggle (single MIRROR) tiled
    tiled = spacing windowSpacing $ Tall nmaster delta ratio
    windowSpacing = 0
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

myLayout =
    onWorkspace "F" simplestFloat $
    defaultLayout
  where
    tabbed = noBorders simpleTabbed


spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where conf = defaultGSConfig

gridRunProgs = [
      ("Chromium", "chromium")
    , ("SublimeText", "~/usr/bin/sublime-text")
    , ("Dolphin", "dolphin")
    , ("GVim", "gvim")
    --, ("Mathematica", "~/opt/Wolfram/10.0/Executables/Mathematica")
    ]

myKeys = [
          ((modm, xK_q),       kill)
         , ((modm,               xK_x     ), sendMessage $ Toggle MIRROR)
         , ((modm, xK_Left),    prevWS)
         , ((modm, xK_Right),   nextWS)
         -- , ((modm, xK_r), spawnSelected' gridRunProgs)
          , ((modm, xK_r), spawn "~/scripts/dmenu_recent.sh")
         , ((modm, xK_w), goToSelected defaultGSConfig { gs_cellheight = 30, gs_cellwidth = 500 })
         , ((0,   0x1008ff12  ), spawn "amixer -q sset Master toggle")
         , ((0,   0x1008ff11  ), spawn "amixer -q sset Master 5%-")
         , ((0,   0x1008ff13  ), spawn "amixer -q sset Master 5%+")
         , ((0,   0x1008ff14  ), spawn "deadbeef --play-pause")
         , ((0,   0x1008ff15  ), spawn "deadbeef --stop")
         , ((0,   0x1008ff16  ), spawn "deadbeef --prev")
         , ((0,   0x1008ff17  ), spawn "deadbeef --next")
         ]


myManageHook = composeAll
   [
     className =? "stalonetray"    --> doIgnore
   -- , className =? "chromium-browser"      --> (doShift $ myWorkspaces !! 0)
   -- , className =? "Telegram"      --> (viewShift $ myWorkspaces !! 0)
   -- , className =? "XMathematica"      --> (doFloat)
   , manageDocks
   ]
--     where viewShift = doF . liftM2 (.) W.greedyView W.shift

myFadeHook :: X ()
myFadeHook = fadeInactiveLogHook 0.9

color0 :: String
color0 = "#ffffff"

color1 :: String
color1 = "black"

modm :: KeyMask
modm = mod4Mask

myWorkspaces :: [String]
myWorkspaces =  map show [1..5] ++ ["F"]

main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ defaultConfig
        { modMask             = modm
        , terminal            = "urxvt-256color"
        , workspaces          = myWorkspaces
        -- , workspaces          = withScreens 2 myWorkspaces
        , borderWidth         = 1
        , normalBorderColor   = color1
        , focusedBorderColor  = color0
        , handleEventHook     = fullscreenEventHook
        , layoutHook          = myLayout
        , manageHook          = myManageHook <+> manageHook defaultConfig
        , logHook             = dynamicLogWithPP xmobarPP
        -- , logHook             = myFadeHook <+> dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppCurrent =  xmobarColor "white" "#4D5966" . wrap "[" "]"
            , ppTitle = xmobarColor color0 "" . shorten 50
            , ppSep = " > "
            , ppWsSep = " | "
            , ppLayout  = (\ x -> case x of
              "Mirror Spacing 0 Tall"          -> "[H]"
              "Spacing 0 Tall"          -> "[V]"
              "SimplestFloat"                  -> "[~]"
              _                                -> x )
            }
        } `additionalKeys` myKeys

