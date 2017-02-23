Config {
    --font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
    font = "xft:Dejavu Sans Mono:size=10"
        , borderColor = "#4D5966"
        , border = TopB
        , bgColor = "#4D5966"
        , fgColor = "black"
        , position = TopW L 100
        , commands = [
                        Run Date "%a %d %b %H:%M" "date" 10
                        , Run StdinReader
                        , Run Kbd [("ru(winkeys)", "RU"), ("us", "US")]
                        -- , Run Battery [ "-t", "AC: <acstatus> <left>%"
                                    -- , "-h", "#859900"
                                    -- , "-n", "#859900"
                                    -- , "-l", "#dc322f"
                                    -- , "--"
                                    -- , "-O", "charging"
                                    -- , "-i", "*"
                                    -- , "-o", "off"
                           -- ] 60
                        , Run Battery        [ "--template" , "<acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "darkred"
                             , "--normal"   , "darkorange"
                             , "--high"     , "black"

                             , "--" -- battery specific options
                                       , "-o"   , "<left>% (<timeleft>)"
                                       , "-O"   , "charging..."
                                       , "-i"   , "*"
                             ] 50
                        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "%StdinReader% }{ %kbd% | %battery% | <fc=#ffffff>%date%</fc>"
        }
