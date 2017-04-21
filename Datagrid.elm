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
    { headers : List Header
    , entries : List Entry
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

type alias Header =
    { header : String }

initialModel : Model
initialModel =
    { title = "Datagrid"
    , headers = initialHeaders
    , entries = initialEntries
    }

initialHeaders : List Header
initialHeaders =
    [ Header "Ticker"
    , Header "Industry"
    , Header "Market Cap"
    , Header "Price"
    , Header "Change"
    , Header "Volume"
    ]

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
            { model |
              headers = initialHeaders
            , entries = initialEntries
            }

-- DECODERS/ENCODERS -----------------------------------------------------------

-- COMMANDS --------------------------------------------------------------------

{-
entriesURL : String
entriesURL =
  "https://spreadsheets.google.com/feeds/cells/0Akt_os3oK7whdHlVWDl5Rk5TMkJHaW5mRm9kYjJKLXc/od6/public/values?alt=json"


getEntries : Cmd Msg
getEntries =
    entriesURL
        |> Http.getString
        |> Http.send DisplayEntries
-}

-- VIEW ------------------------------------------------------------------------


view : Model -> Html Msg
view model =
    div [] [
      table [ id "datagrid" ] [
          caption [] [ text model.title ]
        , thead []
          [ tableHead model.headers ]
        , tableBody model.entries
      ]
    ]


tableHead : List Header -> Html Msg
tableHead headers =
    let
        tableHeaders =
            List.map headRow headers
    in
        tr [] tableHeaders


headRow : Header -> Html Msg
headRow row =
  th [ scope "col" ] [ text row.header ]


tableBody : List Entry -> Html Msg
tableBody rows =
    let
        bodyRows =
            List.map bodyRow rows
    in
        tbody [] bodyRows


bodyRow : Entry -> Html Msg
bodyRow row =
  tr [] [
      td [ scope "row" ] [ text row.ticker ]
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
