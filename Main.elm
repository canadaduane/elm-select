module Main exposing (..)

import Html exposing (..)
import Html.App
import Html.Events
import Dict exposing (Dict, empty)
import Html.CssHelpers
import MainCss exposing (..)


{ id, class, classList } =
    Html.CssHelpers.withNamespace "elm"
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


blankStory : Story
blankStory =
    Story "[None]" "[None]"


stories : StoryDict
stories =
    Dict.empty
        |> Dict.insert 1
            (Story
                "Christmas Eve"
                """There once was a negan who sat on a pike,
                looking for Christmas, and biscuits, and Mike."""
            )
        |> Dict.insert 2
            (Story
                "John Oliver"
                """Far, far away in a land called teevee, there
                lived a wise man whose laugh you could see."""
            )


selectView : StoryDict -> StoryId -> Html Msg
selectView stories selectedStoryId =
    let
        storyLabel id story =
            button
                [ styles <| buttonStyles (id == selectedStoryId)
                , class [ SelectButton ]
                , Html.Events.onClick (ClickMsg id)
                ]
                [ text story.label ]
    in
        div [ id LeftPanel ]
            (Dict.map storyLabel stories |> Dict.values)


storyView : Story -> Html a
storyView story =
    div [ id RightPanel ] [ text story.story ]


view : StoryId -> Html Msg
view model =
    div
        [ id MainPanel ]
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


main : Program Never
main =
    Html.App.program
        { init = ( model, Cmd.none )
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
