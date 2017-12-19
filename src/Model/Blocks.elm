module Model.Blocks exposing (..)

import Model.Block exposing (Block)
import List
import Array exposing (get, fromList)
import Maybe exposing (withDefault)
import Time exposing (Time, inSeconds, minute, second)

type alias Blocks =
  { items : List Block
  , current : Int
  }

null : Block
null =
  Block 0 "-"

work : Block
work =
  Block (25 * minute) "work"

shortRest : Block
shortRest =
  Block (5 * minute) "short rest"

longRest : Block
longRest =
  Block (15 * minute) "long rest"

init : Blocks
init =
  { items =
    [ work, shortRest
    , work, shortRest
    , work, shortRest
    , work, longRest
    ]
  , current = 0
  }

currentBlock : Blocks -> Block
currentBlock blocks =
  blocks
    |> .items
    |> fromList
    |> get blocks.current
    |> withDefault null

length : Blocks -> Int
length = .items >> List.length

currentIsLast : Blocks -> Bool
currentIsLast blocks =
  blocks.current == ((length blocks) - 1)

inc : Blocks -> Blocks
inc blocks =
  let
    newCurrent =
      if currentIsLast blocks then
        0
      else
        blocks.current + 1
  in
    { blocks
    | current = newCurrent
    }
