--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:d797d95a0ecaa54f7b885d0089e48009:e2324b365ea368aa591c804bd542a3a7:da5d5909b26c2716c3aac3f1a5c20954$
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
            -- correct1
            x=671,
            y=2,
            width=145,
            height=141,

        },
        {
            -- correct2
            x=1111,
            y=2,
            width=145,
            height=136,

        },
        {
            -- correct3
            x=1282,
            y=268,
            width=145,
            height=128,

        },
        {
            -- correct4
            x=1429,
            y=263,
            width=145,
            height=118,

        },
        {
            -- correct5
            x=975,
            y=400,
            width=148,
            height=109,

        },
        {
            -- correct6
            x=1125,
            y=400,
            width=148,
            height=105,

        },
        {
            -- correct7
            x=1275,
            y=400,
            width=149,
            height=98,

        },
        {
            -- error1
            x=821,
            y=144,
            width=144,
            height=140,

        },
        {
            -- error2
            x=1284,
            y=134,
            width=145,
            height=127,

        },
        {
            -- error3
            x=1408,
            y=2,
            width=146,
            height=118,

        },
        {
            -- error4
            x=1426,
            y=398,
            width=145,
            height=98,

        },
        {
            -- error5
            x=824,
            y=422,
            width=149,
            height=88,

        },
        {
            -- error6
            x=527,
            y=432,
            width=145,
            height=72,

        },
        {
            -- error7
            x=674,
            y=427,
            width=145,
            height=68,

        },
        {
            -- looney1
            x=527,
            y=289,
            width=145,
            height=141,

        },
        {
            -- looney2
            x=380,
            y=307,
            width=145,
            height=144,

        },
        {
            -- looney3
            x=377,
            y=156,
            width=145,
            height=149,

        },
        {
            -- looney4
            x=230,
            y=2,
            width=145,
            height=152,

        },
        {
            -- looney5
            x=377,
            y=2,
            width=145,
            height=152,

        },
        {
            -- looney6
            x=524,
            y=2,
            width=145,
            height=144,

        },
        {
            -- looney7
            x=965,
            y=2,
            width=144,
            height=140,

        },
        {
            -- rolleyes1
            x=674,
            y=145,
            width=145,
            height=141,

        },
        {
            -- rolleyes2
            x=524,
            y=148,
            width=148,
            height=139,

        },
        {
            -- rolleyes3
            x=824,
            y=286,
            width=148,
            height=134,

        },
        {
            -- rolleyes4
            x=1258,
            y=2,
            width=148,
            height=130,

        },
        {
            -- rolleyes5
            x=967,
            y=144,
            width=157,
            height=126,

        },
        {
            -- rolleyes6
            x=974,
            y=272,
            width=156,
            height=126,

        },
        {
            -- rolleyes7
            x=1126,
            y=140,
            width=156,
            height=126,

        },
        {
            -- rolleyes8
            x=1132,
            y=268,
            width=148,
            height=130,

        },
        {
            -- rolleyes9
            x=674,
            y=288,
            width=148,
            height=137,

        },
        {
            -- surprise1
            x=818,
            y=2,
            width=145,
            height=140,

        },
        {
            -- surprise2
            x=213,
            y=161,
            width=162,
            height=149,

        },
        {
            -- surprise3
            x=201,
            y=320,
            width=177,
            height=150,

        },
        {
            -- surprise4
            x=2,
            y=320,
            width=197,
            height=155,

        },
        {
            -- surprise5
            x=2,
            y=161,
            width=209,
            height=157,

        },
        {
            -- surprise6
            x=2,
            y=2,
            width=226,
            height=157,

        },
    },
    
    sheetContentWidth = 1576,
    sheetContentHeight = 512
}

SheetInfo.frameIndex =
{

    ["correct1"] = 1,
    ["correct2"] = 2,
    ["correct3"] = 3,
    ["correct4"] = 4,
    ["correct5"] = 5,
    ["correct6"] = 6,
    ["correct7"] = 7,
    ["error1"] = 8,
    ["error2"] = 9,
    ["error3"] = 10,
    ["error4"] = 11,
    ["error5"] = 12,
    ["error6"] = 13,
    ["error7"] = 14,
    ["looney1"] = 15,
    ["looney2"] = 16,
    ["looney3"] = 17,
    ["looney4"] = 18,
    ["looney5"] = 19,
    ["looney6"] = 20,
    ["looney7"] = 21,
    ["rolleyes1"] = 22,
    ["rolleyes2"] = 23,
    ["rolleyes3"] = 24,
    ["rolleyes4"] = 25,
    ["rolleyes5"] = 26,
    ["rolleyes6"] = 27,
    ["rolleyes7"] = 28,
    ["rolleyes8"] = 29,
    ["rolleyes9"] = 30,
    ["surprise1"] = 31,
    ["surprise2"] = 32,
    ["surprise3"] = 33,
    ["surprise4"] = 34,
    ["surprise5"] = 35,
    ["surprise6"] = 36,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
