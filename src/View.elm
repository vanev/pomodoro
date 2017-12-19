module View exposing (..)

import Model exposing (Model, timeRemaining, percentComplete)
import Model.Blocks exposing (currentBlock)
import Html exposing (Html, div, p, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, style)
import Msg exposing (..)
import Time exposing (inSeconds, inMinutes)
import String exposing (padLeft)

minutesText : Model -> String
minutesText model =
  model
    |> timeRemaining
    |> inMinutes
    |> floor
    |> toString

secondsText : Model -> String
secondsText model =
  model
    |> timeRemaining
    |> inSeconds
    |> round
    |> \t -> t % 60
    |> toString
    |> padLeft 2 '0'

timeRemainingText : Model -> Html Msg
timeRemainingText model =
  (minutesText model) ++ ":" ++ (secondsText model)
    |> text

blockText : Model -> Html Msg
blockText model =
  model
    |> .blocks
    |> currentBlock
    |> .label
    |> text

startStopButtonText : Model -> Html Msg
startStopButtonText model =
  if model.stopped then
    text "Start"
  else
    text "Stop"

startStopButton : Model -> Html Msg
startStopButton model =
  button
    [ onClick StartStopButtonClick, class "--button" ]
    [ startStopButtonText model ]

resetButton : Model -> Html Msg
resetButton model =
  button
    [ onClick ResetButtonClick, class "--button" ]
    [ text "Reset" ]

time : Model -> Html Msg
time model =
  p
    [ class "--time" ]
    [ timeRemainingText model ]

label : Model -> Html Msg
label model =
  p
    [ class "--label" ]
    [ blockText model
    , div
      [ class "--progress"
      , style
        [ ("width", (percentComplete model |> toString) ++ "%")
        ]
      ]
      []
    ]

buttons : Model -> Html Msg
buttons model =
  div
    [ class "--buttons" ]
    [ startStopButton model
    , resetButton model
    ]

view : Model -> Html Msg
view model =
  div
    [ class "Timer" ]
    [ time model
    , label model
    , buttons model
    ]
