--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:3a223a80d1b45796cd7e50f3c6f30ceb:9efd4a217d835e9f814a15abc30bc2e5:f920d4ea66451f4ca37f2cd0506174c8$
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
            -- idle01
            x=830,
            y=2,
            width=90,
            height=90,

        },
        {
            -- idle02
            x=738,
            y=2,
            width=90,
            height=90,

        },
        {
            -- idle03
            x=646,
            y=2,
            width=90,
            height=90,

        },
        {
            -- idle04
            x=554,
            y=2,
            width=90,
            height=90,

        },
        {
            -- idle05
            x=462,
            y=2,
            width=90,
            height=90,

        },
        {
            -- idle06
            x=370,
            y=2,
            width=90,
            height=90,

        },
        {
            -- idle07
            x=278,
            y=2,
            width=90,
            height=90,

        },
        {
            -- idle08
            x=186,
            y=2,
            width=90,
            height=90,

        },
        {
            -- idle09
            x=94,
            y=2,
            width=90,
            height=90,

        },
        {
            -- idle10
            x=2,
            y=2,
            width=90,
            height=90,

        },
    },
    
    sheetContentWidth = 922,
    sheetContentHeight = 94
}

SheetInfo.frameIndex =
{

    ["idle01"] = 1,
    ["idle02"] = 2,
    ["idle03"] = 3,
    ["idle04"] = 4,
    ["idle05"] = 5,
    ["idle06"] = 6,
    ["idle07"] = 7,
    ["idle08"] = 8,
    ["idle09"] = 9,
    ["idle10"] = 10,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
