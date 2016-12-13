module Model exposing (..)

import Msg  exposing (Msg(SetCalc))
import Calc exposing (Calc, calcGenerator, calcZero)

import Random

type alias Model =
    { playing   : Bool
    , time_left : Int
    , input     : String
    , calc      : Calc
    , score     : Int
    , scoreMax  : Int
    }

init : (Model, Cmd Msg)
init =
    Model
        False
        0
        ""
        calcZero -- (Sum (Parens <| Div (Num 50) (Num 10)) (Parens <| Sub (Num 20) (Num 5)))
        0
        0

        ! [ Random.generate SetCalc calcGenerator ]
