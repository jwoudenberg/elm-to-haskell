module Main exposing (main)

import Authored
import Browser
import Css
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import String.Extra exposing (unindent)


main : Program () () ()
main =
    Browser.sandbox
        { init = ()
        , update = \_ _ -> ()
        , view =
            \_ ->
                Html.h1 [] [ Html.text "Elm to Haskell Syntax Cheatsheet" ]
                    :: List.map viewExample Authored.examples
                    |> Html.div
                        [ Attr.css
                            [ Css.width (Css.px 1024)
                            , Css.margin2 Css.zero Css.auto
                            ]
                        ]
                    |> Html.toUnstyled
        }


viewExample : Authored.Example -> Html msg
viewExample example =
    Html.section []
        [ Html.h2
            [ Attr.css
                [ Css.textAlign Css.center ]
            ]
            [ Html.text example.description ]
        , Html.div
            [ Attr.css
                [ Css.property "display" "flex"
                ]
            ]
            [ Html.code [ Attr.css [ codeStyles ] ] (viewLines example.elm)
            , Html.code [ Attr.css [ codeStyles ] ] (viewLines (example.haskell |> Maybe.withDefault ""))
            ]
        ]


viewLines : String -> List (Html msg)
viewLines string =
    unindent string
        |> String.trim
        |> String.split "\n"
        |> List.map
            (\line ->
                Html.span
                    [ Attr.css
                        [ Css.display Css.block
                        , Css.borderBottom3 (Css.px 1) Css.solid (Css.hex "#eee")
                        , Css.marginTop (Css.px 3)
                        ]
                    ]
                    [ Html.text line ]
            )


codeStyles : Css.Style
codeStyles =
    Css.batch
        [ Css.whiteSpace Css.pre
        , Css.display Css.block
        , Css.width (Css.pct 50)
        ]
