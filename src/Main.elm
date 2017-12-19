module Main exposing (main)

import Html exposing (program)
import Model exposing (Model, init)
import Msg exposing (Msg)
import Update exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)

main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
