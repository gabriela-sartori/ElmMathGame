import Msg    exposing (Msg)
import Model  exposing (Model, init)
import Update exposing (update)
import View   exposing (view)
import Sub    exposing (sub)

import Html

main : Program Never Model Msg
main =
    Html.program
        { init          = init
        , view          = view
        , update        = update
        , subscriptions = sub }
