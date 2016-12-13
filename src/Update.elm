module Update exposing (update)

import Msg exposing (Msg(..))
import Model exposing (..)
import Calc  exposing (evalCalc, calcGenerator)

import Json.Decode as JD
import Random

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Nop ->
            model ! []
        
        Start ->
            { model | playing = True, time_left = 300, score = 0, input = "" } ! []

        InputNumber n ->
            { model | input = model.input ++ toString n } ! []

        Backspace ->
            { model | input = String.dropRight 1 model.input } ! []

        Enter ->
            if not model.playing then
                update Start model
            else
                let
                    scored =
                        if model.input == toString (evalCalc model.calc) then 1 else -1
                in
                    { model
                        | input  = ""
                        , score = model.score + scored
                        } ! [ Random.generate SetCalc calcGenerator ]

        SetCalc calc ->
            { model | calc = calc } ! []

        DecayTimeLeft ->
            if model.time_left > 0 then
                { model | time_left = model.time_left - 1 } ! []
            else
                { model | playing = False, scoreMax = max model.score model.scoreMax } ! []

