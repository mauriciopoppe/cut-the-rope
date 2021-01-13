--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:4e20e72658434c4e3ec5aa7dc14b2fff:9df3f20f7a732235a7975ea321c46944:c5ab41e4e2a696b40d85bf30bb38fd5c$
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
            -- open01
            x=646,
            y=2,
            width=90,
            height=90,

        },
        {
            -- open02
            x=554,
            y=2,
            width=90,
            height=90,

        },
        {
            -- open03
            x=462,
            y=2,
            width=90,
            height=90,

        },
        {
            -- open04
            x=370,
            y=2,
            width=90,
            height=90,

        },
        {
            -- open05
            x=278,
            y=2,
            width=90,
            height=90,

        },
        {
            -- open06
            x=186,
            y=2,
            width=90,
            height=90,

        },
        {
            -- open07
            x=94,
            y=2,
            width=90,
            height=90,

        },
        {
            -- open08
            x=2,
            y=2,
            width=90,
            height=90,

        },
    },
    
    sheetContentWidth = 738,
    sheetContentHeight = 94
}

SheetInfo.frameIndex =
{

    ["open01"] = 1,
    ["open02"] = 2,
    ["open03"] = 3,
    ["open04"] = 4,
    ["open05"] = 5,
    ["open06"] = 6,
    ["open07"] = 7,
    ["open08"] = 8,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
