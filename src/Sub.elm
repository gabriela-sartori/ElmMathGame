module Sub exposing (..)

import Msg   exposing (Msg(..))
import Model exposing (Model)

import Keyboard
import Time

digitToMsg : Int -> Msg
digitToMsg x =
    let _ = Debug.log "key" x in
    if x == 13 then
        Enter

    else if x >= 48 && x <= 57 then
        InputNumber <| x - 48

    else
        Nop


sub : Model -> Sub Msg
sub model =
    Sub.batch
        [ Keyboard.presses digitToMsg
        , Keyboard.downs (\x -> if x == 8 then Backspace else Nop)
        , if model.playing then
            Time.every 100 (\_ -> DecayTimeLeft)
          else
            Sub.none
        ]
    