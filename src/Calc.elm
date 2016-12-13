module Calc exposing (Calc, calcZero, calcGenerator, calcToStr, evalCalc)

import Json.Decode as JD
import Random

type Calc
    = Num Int
    | Parens Calc
    | Mul Calc Calc
    | Div Calc Calc
    | Sum Calc Calc
    | Sub Calc Calc

calcZero = Num 0

calcToStr : Calc -> String
calcToStr calc =
    case calc of
        Num n ->
            toString n

        Parens c ->
            "(" ++ calcToStr c ++ ")"

        Mul c1 c2 ->
            calcToStr c1 ++ " * " ++ calcToStr c2

        Div c1 c2 ->
            calcToStr c1 ++ " / " ++ calcToStr c2

        Sum c1 c2 ->
            calcToStr c1 ++ " + " ++ calcToStr c2

        Sub c1 c2 ->
            calcToStr c1 ++ " - " ++ calcToStr c2

evalCalc : Calc -> Int
evalCalc calc =
    case calc of
        Num n -> n

        Parens c ->
            evalCalc c

        Mul c1 c2 ->
            evalCalc c1 * evalCalc c2

        Div c1 c2 ->
            evalCalc c1 // evalCalc c2

        Sum c1 c2 ->
            evalCalc c1 + evalCalc c2

        Sub c1 c2 ->
            evalCalc c1 - evalCalc c2

intToCalc : Int -> (Calc -> Calc -> Calc)
intToCalc n =
    case n of
        1 -> Mul
        2 -> Sub
        3 -> Mul
        4 -> Div
        _ -> \_ -> \_ -> Num -1

calcGenerator : Random.Generator Calc
calcGenerator =
    Random.map3 (\a b c -> intToCalc a (Num (max b c)) (Num (min b c)))
        (Random.int 1 3) -- 4
        (Random.int 1 10)
        (Random.int 1 10)
