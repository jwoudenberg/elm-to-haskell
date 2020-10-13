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
                Html.h1
                    [ Attr.css
                        [ Css.textAlign Css.right
                        , Css.fontWeight Css.lighter
                        , Css.fontSize (Css.em 3)
                        , Css.textShadow4 Css.zero Css.zero (Css.px 10) (Css.hex "#000")
                        , Css.color (Css.hex "#fff")
                        ]
                    ]
                    [ Html.text "Elm to Haskell" ]
                    :: List.map viewExample Authored.examples
                    |> Html.div
                        [ Attr.css
                            [ Css.width (Css.px 1024)
                            , Css.margin2 Css.zero Css.auto
                            , Css.fontFamilies [ "Helvetica Neue", "Helvetica", "Arial", "sans-serif" ]
                            , Css.position Css.relative
                            ]
                        ]
                    |> (\el ->
                            Html.div
                                [ Attr.css
                                    [ Css.minWidth (Css.vw 100)
                                    , Css.minHeight (Css.vh 100)
                                    , Css.backgroundColor (Css.hex "#5E5184")
                                    , Css.position Css.absolute
                                    ]
                                ]
                                [ Html.div
                                    [ Attr.css
                                        [ Css.position Css.absolute
                                        , Css.width (Css.pct 50)
                                        , Css.height (Css.pct 100)
                                        , Css.backgroundColor (Css.hex "#1293D8")
                                        ]
                                    ]
                                    []
                                , el
                                ]
                       )
                    |> Html.toUnstyled
        }


viewExample : Authored.Example -> Html msg
viewExample example =
    let
        linesElm =
            lines example.elm

        linesHaskell =
            case example.haskell of
                Nothing ->
                    []

                Just code ->
                    lines code

        linesHtmlElm =
            List.map viewLine (fillUpToMax linesElm)

        linesHtmlHaskell =
            List.map viewLine (fillUpToMax linesHaskell)

        numLines =
            max (List.length linesElm) (List.length linesHaskell)

        fillUpToMax lines_ =
            [ "" ] ++ lines_ ++ List.repeat (1 + numLines - List.length lines_) ""
    in
    Html.section []
        [ Html.h2
            [ Attr.css
                [ Css.marginTop (Css.em 1.5)
                , Css.marginBottom (Css.em 0.3)
                , Css.fontWeight Css.lighter
                , Css.fontSize (Css.em 2.5)
                , Css.textShadow4 Css.zero Css.zero (Css.px 10) (Css.hex "#000")
                , Css.color (Css.hex "#fff")
                ]
            ]
            [ Html.text example.description ]
        , Html.div
            [ Attr.css
                [ Css.property "display" "flex"
                , Css.backgroundColor (Css.hex "#efefef")
                , Css.borderRadius (Css.px 3)
                , Css.boxShadow4 Css.zero Css.zero (Css.px 10) (Css.hex "#777")
                ]
            ]
            [ Html.code [ Attr.css [ codeStyles ] ] linesHtmlElm
            , Html.code [ Attr.css [ codeStyles ] ] linesHtmlHaskell
            ]
        ]


lines : String -> List String
lines string =
    unindent string
        |> String.trim
        |> String.split "\n"


viewLine : String -> Html msg
viewLine line =
    Html.span
        [ Attr.css
            [ Css.display Css.block
            , Css.borderBottom3 (Css.px 1) Css.solid (Css.hex "#ddd")
            , Css.marginTop (Css.px 3)
            , Css.padding2 Css.zero (Css.px 5)
            ]
        ]
        [ Html.text line ]


codeStyles : Css.Style
codeStyles =
    Css.batch
        [ Css.whiteSpace Css.pre
        , Css.display Css.block
        , Css.width (Css.pct 50)
        ]
