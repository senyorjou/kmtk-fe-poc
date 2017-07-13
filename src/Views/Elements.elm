module Views.Elements exposing (headerView)

import Html exposing (Html, a, div, header, nav, li, text, button, h1, p, span, ul)
import Html.Attributes exposing (attribute, class, href, id, type_)
import Messages exposing (Msg(..))
import Routing exposing (Route(..))


type alias MenuItem =
    { route : Route
    , label : String
    , link : String
    }


renderMenu : Route -> MenuItem -> Html Msg
renderMenu route menu =
    let
        active =
            if route == menu.route then
                "active"
            else
                ""
    in
        li [ class active ] [ a [ href menu.link ] [ text menu.label ] ]


renderMenus : Route -> List (Html Msg)
renderMenus route =
    let
        menus =
            [ MenuItem MainPage "Home" "#"
            , MenuItem AboutPage "About" "#about"
            , MenuItem ContactsPage "Contacts" "#contacts"
            ]

        renderRoute =
            renderMenu route
    in
        List.map renderRoute menus


headerView : Route -> Html Msg
headerView route =
    nav [ class "navbar navbar-default" ]
        [ div [ class "container-fluid" ]
            [ div [ class "navbar-header" ]
                [ button
                    [ attribute "aria-controls" "navbar"
                    , attribute "aria-expanded" "false"
                    , class "navbar-toggle collapsed"
                    , attribute "data-target" "#navbar"
                    , attribute "data-toggle" "collapse"
                    , type_ "button"
                    ]
                    [ span [ class "sr-only" ]
                        [ text "Toggle navigation" ]
                    , span [ class "icon-bar" ] []
                    , span [ class "icon-bar" ] []
                    , span [ class "icon-bar" ] []
                    ]
                , a [ class "navbar-brand", href "#" ]
                    [ text "Demo Page" ]
                ]
            , div [ class "navbar-collapse collapse", id "navbar" ]
                [ ul [ class "nav navbar-nav" ] (renderMenus route) ]
            ]
        ]
