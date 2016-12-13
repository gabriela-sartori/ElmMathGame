module Msg exposing (Msg(..))

import Calc exposing (Calc)

type Msg
    = Nop
    | Start
    | SetCalc Calc
    | InputNumber Int
    | Backspace
    | Enter
    | DecayTimeLeft
    