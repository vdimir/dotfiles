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
                        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "%StdinReader% }{ %kbd% | <fc=#ffffff>%date%</fc>"
        }
