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
    , Entry "FILIP" "Information Technology Services" 1754.84 "£23.95" 0.0055 114570.0
    , Entry "DELL" "Personal Computers" 23388.24 "£13.32" -0.0045 2.2162924E7
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
          [ thead_ model.headers ]
        , tbody_ model.entries
      ]
    ]


thead_ : List Header -> Html Msg
thead_ headers =
    let
        tableHeaders =
            List.map th_ headers
    in
        tr [] tableHeaders

tbody_ : List Entry -> Html Msg
tbody_ rows =
    let
        tr_ =
            List.map body_tr rows
    in
        tbody [] tr_


body_tr : Entry -> Html Msg
body_tr row =
  tr [] [
      td [ scope "row" ] [ text row.ticker ]
    , td [] [ text row.industry ]
    , marketCap row.marketcap
    , td [ class "numerical" ] [ text row.price ]
    , td [ class "numerical" ] [ text (toString row.change) ]
    , td [ class "numerical" ] [ text (toString row.volume) ]
  ]


th_ : Header -> Html Msg
th_ row =
  th [ scope "col" ] [ text row.header ]


marketCap : Float -> Html Msg
marketCap number =
  let
      value =
        number
        |> truncate
        |> toString
        |> text
  in
      td [ class "numerical" ] [ value ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
