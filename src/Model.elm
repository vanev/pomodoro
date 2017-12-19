module Model exposing (..)

import Msg exposing (Msg)
import Model.Blocks exposing (Blocks, currentBlock)
import Time exposing (Time, second, inSeconds)

type alias Model =
  { stopped : Bool
  , elapsed : Time
  , blocks : Blocks
  }

init : (Model, Cmd Msg)
init =
  (
    { stopped = True
    , elapsed = 0
    , blocks = Model.Blocks.init
    },
    Cmd.none
  )

currentDuration : Model -> Time
currentDuration model =
  model
    |> .blocks
    |> currentBlock
    |> .duration

timeRemaining : Model -> Time
timeRemaining model =
  let
    elapsed = model.elapsed
    duration = currentDuration model
  in
    duration - elapsed

percentComplete : Model -> Float
percentComplete model =
  let
    elapsed = model.elapsed
    duration = currentDuration model
  in
    (elapsed / duration) * 100
