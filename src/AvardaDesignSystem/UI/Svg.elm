module AvardaDesignSystem.UI.Svg exposing (avatarIcon, closeIcon)

import Css
import Html.Styled exposing (Html)
import Svg.Styled as Svg exposing (Attribute, Svg)
import Svg.Styled.Attributes as SvgAttributes


type SvgAttribute msg
    = Color String
    | Size IconSize
    | LogoWidth String
    | ViewBox String
    | Custom (List (Attribute msg))


type SvgModel msg
    = SvgModel (List (SvgAttribute msg)) (List (Svg msg))


type alias IconSize =
    { width : Float, height : Float }


view : SvgModel msg -> Html msg
view (SvgModel customAttributes svg) =
    Svg.svg (List.concatMap customAttributeToSvgAttribute customAttributes) svg


defaultIconColor : String
defaultIconColor =
    "#000000"


prependHashToHexString : String -> String
prependHashToHexString color =
    if String.startsWith "#" color then
        color

    else
        String.append "#" color


customAttributeToSvgAttribute : SvgAttribute msg -> List (Attribute msg)
customAttributeToSvgAttribute attribute =
    case attribute of
        Color color ->
            [ SvgAttributes.fill color ]

        Size { width, height } ->
            [ SvgAttributes.height <| String.fromFloat height
            , SvgAttributes.width <| String.fromFloat width
            ]

        LogoWidth width ->
            [ SvgAttributes.width width ]

        ViewBox viewBox ->
            [ SvgAttributes.viewBox viewBox ]

        Custom customAttributes ->
            customAttributes


closeIcon : IconSize -> Html msg
closeIcon size =
    SvgModel [ ViewBox "0 0 24 25", Size size, Color defaultIconColor ]
        [ Svg.path [ SvgAttributes.d "m2.808 5.02 1.414-1.414 16.971 16.97-1.414 1.414z" ] []
        , Svg.path [ SvgAttributes.d "m19.779 3.604 1.414 1.414L4.223 21.99l-1.415-1.414z" ] []
        ]
        |> view


avatarIcon : IconSize -> String -> Html msg
avatarIcon size color =
    SvgModel [ ViewBox "0 0 19 21", Size size, Color <| prependHashToHexString color ]
        [ Svg.path
            [ SvgAttributes.fillRule "evenodd"
            , SvgAttributes.clipRule "evenodd"
            , SvgAttributes.d "M8.047 13.204c-1.143.743-2.529 1.345-3.723 1.79C2.941 15.509 2 16.761 2 18.124V20H0v-1.877c0-2.309 1.57-4.237 3.626-5.003 1.138-.424 2.367-.966 3.33-1.593 1.023-.665 1.472.926 1.544.492l2 .481c.072.434.521-1.638 1.544-.973.963.627 2.192 1.169 3.33 1.593C17.43 13.886 19 15.814 19 18.123V20h-2v-1.877c0-1.362-.941-2.614-2.324-3.129-1.194-.445-2.58-1.047-3.723-1.79-.506-.33-1.023-.723-1.453-1.186-.43.463-.947.857-1.453 1.186Z"
            ]
            []
        , Svg.path
            [ SvgAttributes.fillRule "evenodd"
            , SvgAttributes.clipRule "evenodd"
            , SvgAttributes.d "M9.5 12c1.931 0 4-1.938 4-5 0-1.66-.391-2.926-1.01-3.73C11.93 2.544 11.043 2 9.5 2c-1.543 0-2.43.544-2.99 1.27C5.89 4.074 5.5 5.34 5.5 7c0 3.062 2.069 5 4 5Zm0 2c3.314 0 6-3.134 6-7s-1.8-7-6-7-6 3.134-6 7 2.686 7 6 7Z"
            ]
            []
        ]
        |> view
