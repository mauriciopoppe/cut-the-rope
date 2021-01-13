--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:dda58aef74eb8e9f7053602b90330769:1892eb1c8ee8eb2f2defa26d46134595:584d465f9be76587f98015faa06bb792$
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
            -- chew01
            x=906,
            y=2,
            width=82,
            height=78,

            sourceX = 10,
            sourceY = 20,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- chew02
            x=816,
            y=2,
            width=88,
            height=78,

            sourceX = 6,
            sourceY = 21,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- chew03
            x=530,
            y=2,
            width=100,
            height=82,

            sourceX = 0,
            sourceY = 17,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- chew04
            x=438,
            y=2,
            width=90,
            height=84,

            sourceX = 5,
            sourceY = 15,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- chew05
            x=732,
            y=2,
            width=82,
            height=82,

            sourceX = 10,
            sourceY = 18,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- chew06
            x=346,
            y=2,
            width=90,
            height=86,

            sourceX = 0,
            sourceY = 13,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- chew07
            x=262,
            y=2,
            width=82,
            height=90,

            sourceX = 9,
            sourceY = 10,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- chew08
            x=2,
            y=2,
            width=82,
            height=94,

            sourceX = 9,
            sourceY = 6,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- chew09
            x=178,
            y=2,
            width=82,
            height=90,

            sourceX = 10,
            sourceY = 10,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- chew10
            x=86,
            y=2,
            width=90,
            height=90,

            sourceX = 4,
            sourceY = 9,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- chew11
            x=632,
            y=2,
            width=98,
            height=82,

            sourceX = 1,
            sourceY = 17,
            sourceWidth = 100,
            sourceHeight = 100
        },
    },
    
    sheetContentWidth = 990,
    sheetContentHeight = 98
}

SheetInfo.frameIndex =
{

    ["chew01"] = 1,
    ["chew02"] = 2,
    ["chew03"] = 3,
    ["chew04"] = 4,
    ["chew05"] = 5,
    ["chew06"] = 6,
    ["chew07"] = 7,
    ["chew08"] = 8,
    ["chew09"] = 9,
    ["chew10"] = 10,
    ["chew11"] = 11,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
