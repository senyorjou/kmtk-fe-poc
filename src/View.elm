module View exposing (..)

import Html exposing (Html, button, div, h1, header, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (Route(..))
import Views.Elements exposing (headerView)
import Contacts.List exposing (listContacts)


view : Model -> Html Msg
view model =
    let
        page =
            case model.route of
                MainPage ->
                    mainPage

                AboutPage ->
                    aboutPage

                ContactsPage ->
                    listContacts

                NotFoundRoute ->
                    notFoundView
    in
        div []
            [ headerView model.route
            , div [] [ page ]
            ]


mainPage : Html Msg
mainPage =
    div [ class "jumbotron" ]
        [ div [ class "container" ]
            [ h1 [] [ text "Welcome to Elm Main page" ]
            , p [] [ text "A delightful language for reliable webapps." ]
            , button [ onClick GoToAboutPage, class "btn btn-primary btn-lg" ]
                [ text "Go To About Page" ]
            ]
        ]


aboutPage : Html Msg
aboutPage =
    div [ class "jumbotron" ]
        [ div [ class "container" ]
            [ h1 [] [ text "This is <about> page" ]
            , button [ onClick GoToMainPage, class "btn btn-primary btn-lg" ]
                [ text "Go To Main Page" ]
            ]
        ]


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not Found" ]
