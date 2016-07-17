import System.IO
import Data.Ratio((%))

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

import qualified XMonad.StackSet as W


windowSpacing :: Int
windowSpacing = 1

defaultLayout = (avoidStruts $ smartBorders $ mkToggle (single MIRROR) tiled)
   ||| noBorders Full 
   where
    tiled = spacing windowSpacing $ Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

myLayout =
    onWorkspace "F" simplestFloat $
    defaultLayout
  where
    tabbed = noBorders simpleTabbed

myWorkspaces :: [String]
myWorkspaces =  map show [1..5] ++ ["F"]

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where conf = defaultGSConfig

gridRunProgs = [
      ("Chromium", "chromium")
    , ("SublimeText", "/home/deffe/opt/bin/sublime3")
    , ("Dolphin", "dolphin")
    , ("GVim", "gvim")
    , ("Mathematica", "~/opt/Wolfram/10.0/Executables/Mathematica")
    ]

myKeys = [
          ((modm, xK_q),       kill)
         , ((modm,               xK_x     ), sendMessage $ Toggle MIRROR)
         , ((modm, xK_Left),    prevWS)
         , ((modm, xK_Right),   nextWS)
         , ((modm, xK_r), spawnSelected' gridRunProgs)
         , ((modm, xK_w), goToSelected defaultGSConfig { gs_cellheight = 30, gs_cellwidth = 500 })
         , ((0,   0x1008ff12  ), spawn "amixer -q sset Master toggle")
         , ((0,   0x1008ff11  ), spawn "amixer -q sset Master 5%-")
         , ((0,   0x1008ff13  ), spawn "amixer -q sset Master 5%+")
         , ((0,   0x1008ff14  ), spawn "mpc toggle")
         , ((0,   0x1008ff15  ), spawn "mpc stop")
         , ((0,   0x1008ff16  ), spawn "mpc prev")
         , ((0,   0x1008ff17  ), spawn "mpc next")
         ]


myManageHook = composeAll
   [
  -- className =? "chromium-browser"      --> (doShift $ myWorkspaces !! 1)
   className =? "XMathematica"      --> (doFloat)
   , manageDocks
   ]

myFadeHook :: X ()
myFadeHook = fadeInactiveLogHook 0.9

color0 :: String
color0 = "#D8BC2C"

color1 :: String
color1 = "#55555"

modm :: KeyMask
modm = mod4Mask

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { modMask             = modm
        , terminal            = "urxvt"
        , workspaces          = myWorkspaces
        , borderWidth         = 1
        , normalBorderColor   = color1
        , focusedBorderColor  = color0
        , handleEventHook     = fullscreenEventHook
        , layoutHook          = myLayout
        , manageHook          = myManageHook <+> manageHook defaultConfig
        , logHook             = myFadeHook <+> dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor color0 "" . shorten 50
            , ppSep = " > "
            , ppWsSep = " | "
            , ppLayout  = (\ x -> case x of
              "Mirror Spacing 1 Tall"          -> "[H]"
              "Mirror Spacing 2 Tall"          -> "[H]"
              "Spacing 1 Tall"                 -> "[V]"
              "Spacing 2 Tall"                 -> "[V]"
              "SimplestFloat"                  -> "[~]"
              _                                -> x )
            }
        } `additionalKeys` myKeys

