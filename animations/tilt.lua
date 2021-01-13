--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:d88ad12fc9587bcf64a7f9cf3ca86647:a92017f5cf378bfdc861756470d193b9:301e35bdbdb26ea91dbb0f044a36c48c$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- tilt01
            x=1198,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt02
            x=1106,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt03
            x=1014,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt04
            x=922,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt05
            x=830,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt06
            x=738,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt07
            x=646,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt08
            x=554,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt09
            x=462,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt10
            x=370,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt11
            x=278,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt12
            x=186,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt13
            x=94,
            y=2,
            width=90,
            height=90,

        },
        {
            -- tilt14
            x=2,
            y=2,
            width=90,
            height=90,

        },
    },
    
    sheetContentWidth = 1290,
    sheetContentHeight = 94
}

SheetInfo.frameIndex =
{

    ["tilt01"] = 1,
    ["tilt02"] = 2,
    ["tilt03"] = 3,
    ["tilt04"] = 4,
    ["tilt05"] = 5,
    ["tilt06"] = 6,
    ["tilt07"] = 7,
    ["tilt08"] = 8,
    ["tilt09"] = 9,
    ["tilt10"] = 10,
    ["tilt11"] = 11,
    ["tilt12"] = 12,
    ["tilt13"] = 13,
    ["tilt14"] = 14,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
