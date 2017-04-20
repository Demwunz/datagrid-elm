module Datagrid exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
-- import Http

-- MODEL -----------------------------------------------------------------------


{-

"entry": [{
      	"gs$cell": {
      		"row": "5",
      		"col": "4",
      		"numericValue": "45.8", // "33827.62" // maybe
      		"$t": "£45.80" // "0.29%" // "33,827.62" // "EVAN"
      	}
      }]

-}


type alias Model =
    { entries : List Entry
    , title : String
    }

type alias Entry =
    { ticker : String
    , industry : String
    , marketcap : Float
    , price : String
    , change : Float
    , volume : Float
    }


initialModel : Model
initialModel =
    { entries = initialEntries
    , title = "Datagrid"
    }

initialEntries : List Entry
initialEntries =
    [ Entry "EVAN" "Technical & System Software" 1837.89 "£47.04" 0.0101 51718.0
    , Entry "FILIP" "Information Technology Services" 1837.89 "£47.04" 0.0101 51718.0
    , Entry "EVAN" "Technical & System Software" 1837.89 "£47.04" 0.0101 51718.0
    ]

-- UPDATE ----------------------------------------------------------------------


type Msg = DisplayEntries

update : Msg -> Model -> Model
update msg model =
    case msg of
        DisplayEntries ->
            { model | entries = initialEntries }

-- DECODERS/ENCODERS -----------------------------------------------------------

-- COMMANDS --------------------------------------------------------------------

-- entriesURL : String
-- entriesURL =
--   "https://spreadsheets.google.com/feeds/cells/0Akt_os3oK7whdHlVWDl5Rk5TMkJHaW5mRm9kYjJKLXc/od6/public/values?alt=json"
--
--
-- getEntries : Cmd Msg
-- getEntries =
--     entriesURL
--         |> Http.getString
--         |> Http.send DisplayEntries


-- VIEW ------------------------------------------------------------------------


view : Model -> Html Msg
view model =
    div [] [
      viewHeader model.title
      , table [ id "datagrid"] [
         thead [] [
          tr [ scope "row" ] [
              th [] [ text "Ticker" ]
            , th [] [ text "Industry" ]
            , th [] [ text "Market Cap" ]
            , th [] [ text "Price" ]
            , th [] [ text "Change" ]
            , th [] [ text "Volume" ]
          ]
        ]
        , tableBody model.entries
      ]
    ]


viewHeader : String -> Html Msg
viewHeader title =
    header [] [
        h1 [] [ text title ]
    ]


tableBody : List Entry -> Html Msg
tableBody rows =
    let
        tableRows =
            List.map tableRow rows
    in
        tbody [] tableRows


tableRow : Entry -> Html Msg
tableRow row =
  tr [] [
      td [] [ text row.ticker ]
    , td [] [ text row.industry ]
    , td [] [ text (toString row.marketcap) ]
    , td [] [ text row.price ]
    , td [] [ text (toString row.change) ]
    , td [] [ text (toString row.volume) ]
  ]



main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
