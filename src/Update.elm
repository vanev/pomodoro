module Update exposing (..)

import Msg exposing (..)
import Model exposing (Model, timeRemaining)
import Time exposing (Time, second)
import Model.Blocks exposing (..)

handleStartStopButtonClick : Model -> (Model, Cmd Msg)
handleStartStopButtonClick model =
  (
    { model
    | stopped = not model.stopped
    },
    Cmd.none
  )

handleResetButtonClick : Model -> (Model, Cmd Msg)
handleResetButtonClick model =
  let
    blocks = model.blocks
    newBlocks = { blocks | current = 0 }
  in
    (
      { model
      | stopped = True
      , elapsed = 0
      , blocks = newBlocks
      },
      Cmd.none
    )

delta : Model -> Float
delta model =
  if model.stopped then
    0
  else
    1 * second

updateElapsed : Model -> Float
updateElapsed model =
  if (timeRemaining model) == 0 then
    0
  else
    model.elapsed + (delta model)

updateBlocks : Model -> Blocks
updateBlocks model =
  if (timeRemaining model) == 0 then
    inc model.blocks
  else
    model.blocks

handleTick : Model -> (Model, Cmd Msg)
handleTick model =
  (
    { model
    | elapsed = updateElapsed model
    , blocks = updateBlocks model
    },
    Cmd.none
  )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    StartStopButtonClick -> handleStartStopButtonClick model
    ResetButtonClick -> handleResetButtonClick model
    Tick time -> handleTick model
