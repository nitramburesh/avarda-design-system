module AvardaDesignSystem.UI.Text exposing (paragraph)

import Html exposing (Attribute, Html)


paragraph : List (Attribute msg) -> List (Html msg) -> Html msg
paragraph =
    Html.p
