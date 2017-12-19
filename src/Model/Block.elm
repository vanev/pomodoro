module Model.Block exposing (..)

import Time exposing (Time)

type alias Block =
  { duration : Time
  , label : String
  }
