module Contacts.List exposing (listContacts)

import Html exposing (Html, div, h1, table, tbody, td, th, thead, tr, text)
import Html.Attributes exposing (class)
import Messages exposing (Msg)
import Http
import Json.Decode as Decode exposing (field)
import Json.Encode as Encode


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"


collectionDecoder : Decode.Decoder (List Contact)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Contact
memberDecoder =
    Decode.map3 Contact
        (field "id" Decode.int)
        (field "name" Decode.string)
        (field "tld" Decode.string)


type alias Contact =
    { id : Int
    , name : String
    , tld : String
    }


contacts =
    [ Contact 1 "Spain" "es"
    , Contact 2 "France" "fr"
    ]


listContacts : Html Msg
listContacts =
    div []
        [ div [ class "container" ]
            [ h1 [] [ text "Contact list" ]
            , list contacts
            ]
        ]


list : List Contact -> Html Msg
list contacts =
    div []
        [ table [ class "table table-striped" ]
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Country" ]
                    , th [] [ text "Tld" ]
                    ]
                ]
            , tbody [] (List.map row contacts)
            ]
        ]


row : Contact -> Html Msg
row contact =
    tr []
        [ td [] [ text contact.id ]
        , td [] [ text contact.name ]
        , td [] [ text contact.tld ]
        ]
