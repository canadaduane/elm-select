module Main exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes
import Html.Events
import Dict exposing (Dict, empty)
import Css
import MainCss exposing (..)


type Msg
    = EmptyMsg
    | ClickMsg Int


type alias StoryId =
    Int


type alias Story =
    { label : String, story : String }


type alias StoryDict =
    Dict StoryId Story


type alias SelectedStory =
    { id : StoryId, selected : Bool }


blankStory =
    Story "[None]" "[None]"


stories : StoryDict
stories =
    Dict.empty
        |> Dict.insert 1 (Story "Christmas Eve" "There once was a negan who sat on a pike, looking for Christmas, and biscuits, and Mike.")
        |> Dict.insert 2 (Story "John Oliver" "Far, far away in a land called teevee, there lived a wise man whose laugh you could see.")


styles =
    Css.asPairs >> Html.Attributes.style


lightRed =
    Css.rgb 255 235 235


white =
    Css.rgb 255 255 255


selectView : StoryDict -> StoryId -> Html Msg
selectView stories selectedStoryId =
    let
        storyLabel id story =
            let
                color =
                    if id == selectedStoryId then
                        lightRed
                    else
                        white
            in
                button
                    [ styles
                        [ Css.backgroundColor color
                        , Css.display Css.block
                        , Css.width (Css.pct 100)
                        , Css.border (Css.px 0)
                        , Css.padding (Css.px 5)
                        ]
                    , Html.Events.onClick (ClickMsg id)
                    ]
                    [ text story.label ]
    in
        div [ styles [ Css.flex (Css.int 1) ] ]
            (Dict.map storyLabel stories |> Dict.values)


storyView story =
    div [ styles [ Css.flex (Css.int 2), Css.marginLeft (Css.px 20) ] ] [ text story.story ]


view model =
    div
        [ styles (flexStyle ++ thickMargin) ]
        [ selectView stories model
        , storyView (Dict.get model stories |> Maybe.withDefault blankStory)
        ]


type alias Model =
    Int


model : Model
model =
    1


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EmptyMsg ->
            ( model, Cmd.none )

        ClickMsg i ->
            ( i, Cmd.none )


main =
    Html.App.program
        { init = ( model, Cmd.none )
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
