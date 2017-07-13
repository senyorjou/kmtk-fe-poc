module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)


type Route
    = MainPage
    | AboutPage
    | ContactsPage
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map MainPage top
        , map AboutPage (s "about")
        , map ContactsPage (s "contacts")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
