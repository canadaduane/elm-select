module MainCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, li)
import Css.Namespace exposing (namespace)
import Html.Attributes
import Html


type CssClasses
    = SelectButton


type CssIds
    = LeftPanel
    | RightPanel
    | MainPanel


styles : List Mixin -> Html.Attribute a
styles =
    asPairs >> Html.Attributes.style


lightRed : Color
lightRed =
    rgb 255 235 235


white : Color
white =
    rgb 255 255 255


css : Stylesheet
css =
    (stylesheet << namespace "elm")
        [ body
            [ margin (px 0) ]
        , (#) LeftPanel
            [ flex (int 1) ]
        , (#) RightPanel
            [ flex (int 2)
            , marginLeft (px 20)
            ]
        , (#) MainPanel
            (flexStyle ++ thickMargin)
        , (.) SelectButton
            [ display block
            , width (pct 100)
            , border (px 0)
            , padding (px 5)
            ]
        ]


flexStyle : List Mixin
flexStyle =
    [ displayFlex ]


thickMargin : List Mixin
thickMargin =
    [ margin (px 40) ]


buttonStyles : Bool -> List Mixin
buttonStyles isHighlighted =
    let
        clr =
            if isHighlighted then
                lightRed
            else
                white
    in
        [ backgroundColor clr ]
