--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:b8bfd0c37bc762d335d6b9e3b1c551ed:c4b2f03c2c7525e17163802e79e13c99:f80f3788f3d0cf6fbee7292fcfc2f8dc$
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
            -- sad01
            x=1106,
            y=2,
            width=90,
            height=90,

        },
        {
            -- sad02
            x=1014,
            y=2,
            width=90,
            height=90,

        },
        {
            -- sad03
            x=922,
            y=2,
            width=90,
            height=90,

        },
        {
            -- sad04
            x=830,
            y=2,
            width=90,
            height=90,

        },
        {
            -- sad05
            x=738,
            y=2,
            width=90,
            height=90,

        },
        {
            -- sad06
            x=646,
            y=2,
            width=90,
            height=90,

        },
        {
            -- sad07
            x=554,
            y=2,
            width=90,
            height=90,

        },
        {
            -- sad08
            x=462,
            y=2,
            width=90,
            height=90,

        },
        {
            -- sad09
            x=370,
            y=2,
            width=90,
            height=90,

        },
        {
            -- sad10
            x=278,
            y=2,
            width=90,
            height=90,

        },
        {
            -- sad11
            x=186,
            y=2,
            width=90,
            height=90,

        },
        {
            -- sad12
            x=94,
            y=2,
            width=90,
            height=90,

        },
        {
            -- sad13
            x=2,
            y=2,
            width=90,
            height=90,

        },
    },
    
    sheetContentWidth = 1198,
    sheetContentHeight = 94
}

SheetInfo.frameIndex =
{

    ["sad01"] = 1,
    ["sad02"] = 2,
    ["sad03"] = 3,
    ["sad04"] = 4,
    ["sad05"] = 5,
    ["sad06"] = 6,
    ["sad07"] = 7,
    ["sad08"] = 8,
    ["sad09"] = 9,
    ["sad10"] = 10,
    ["sad11"] = 11,
    ["sad12"] = 12,
    ["sad13"] = 13,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
