module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)

import String

import Msg   exposing (Msg(..))
import Model exposing (..)
import Calc  exposing (calcToStr)

stylesheet =
    let
        tag = "link"
        attrs =
            [ attribute "rel"      "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href"     "/css.css" ]
        children = []
    in 
        node tag attrs children

game_view : Model -> Html Msg
game_view model =
    let
        timeLeftStr =
            model.time_left
            |> toFloat >> flip (/) 10 >> toString
            |> \str -> if String.contains "." str then str else str ++ ".0"

    in
        div []
            [ h2 [] [ text <| calcToStr model.calc ]
            , h3 [] [ text <| "Points: "    ++ toString model.score ]
            , h3 [] [ text <| "Time Left: " ++ timeLeftStr ]
            , br [] []
            , br [] []
            , h3 [] [ text <| model.input ]
            -- , input [ type_ "text", onInput UpdateInput, maxlength 10, value model.input
               -- , autofocus True ] []
            ]

menu_view : Model -> Html Msg
menu_view model =
    div []
        [ p  [] [ text "Some configs..." ]
        , br [] []
        , br [] []
        , br [] []
        ,   if model.scoreMax > 0 then
                text <| "Max Score: " ++ toString model.scoreMax
            else 
                br [] []
        , br [] []
        , br [] []
        , button [ onClick Start ] [ text "Start" ]
        ]

view : Model -> Html Msg
view model =
    div [ id "game" ]
        [ stylesheet
        , h1 [] [ text "Math Game 2000" ]
        , br [] []
        , br [] []
        ,   if model.playing then
                game_view model
            else
                menu_view model
        ]
    
