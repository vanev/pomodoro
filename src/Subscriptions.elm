module Subscriptions exposing (..)

import Model exposing (Model)
import Msg exposing (..)
import Time exposing (Time, second)

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick
