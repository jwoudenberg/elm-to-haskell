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
                                , Html.footer
                                    [ Attr.css
                                        [ Css.textAlign Css.center
                                        , Css.opacity (Css.num 0.6)
                                        , Css.marginTop (Css.px 50)
                                        , Css.color (Css.hex "#fff")
                                        , Css.paddingBottom (Css.px 10)
                                        , Css.textShadow4 Css.zero Css.zero (Css.px 10) (Css.hex "#333")
                                        ]
                                    ]
                                    [ Html.text "© 2020 Jasper Woudenberg - "
                                    , Html.a
                                        [ Attr.css
                                            [ Css.color Css.inherit
                                            ]
                                        , Attr.href "https://github.com/jwoudenberg/elm-to-haskell"
                                        ]
                                        [ Html.text "This Code"
                                        ]
                                    , Html.text " - "
                                    , Html.a
                                        [ Attr.css
                                            [ Css.color Css.inherit
                                            ]
                                        , Attr.href "https://dev.to/jwoudenberg"
                                        ]
                                        [ Html.text "My Blog"
                                        ]
                                    ]
                                ]
                       )
                    |> Html.toUnstyled
        }


viewExample : Authored.Example -> Html msg
viewExample example =
    let
        linesElm =
            toLines example.elm

        linesHaskell =
            case example.haskell of
                Nothing ->
                    List.map (\_ -> "|") linesElm

                Just code ->
                    toLines code

        linesHtmlElm =
            map2WithMaybes
                (\maybeElmLine _ ->
                    case maybeElmLine of
                        Just elmLine ->
                            viewLineLeft elmLine

                        Nothing ->
                            viewLineLeft ""
                )
                linesElm
                linesHaskell

        linesHtmlHaskell =
            map2WithMaybes
                (\maybeElmLine maybeHaskellLine ->
                    case ( maybeElmLine, maybeHaskellLine ) of
                        ( Just elmLine, Just haskellLine ) ->
                            if String.trim haskellLine == "|" then
                                viewGrayLineRight elmLine

                            else
                                viewLineRight haskellLine

                        ( _, Just haskellLine ) ->
                            viewLineRight haskellLine

                        _ ->
                            viewLineRight ""
                )
                linesElm
                linesHaskell
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


toLines : String -> List String
toLines string =
    unindent string
        |> String.split "\n"


viewLineLeft : String -> Html msg
viewLineLeft line =
    Html.span
        [ Attr.css
            [ Css.paddingLeft (Css.px 10)
            , lineStyles
            ]
        ]
        [ Html.text line ]


viewLineRight : String -> Html msg
viewLineRight line =
    Html.span
        [ Attr.css
            [ Css.paddingRight (Css.px 10)
            , lineStyles
            ]
        ]
        [ Html.text line ]


viewGrayLineRight : String -> Html msg
viewGrayLineRight line =
    Html.span
        [ Attr.css
            [ Css.paddingRight (Css.px 10)
            , lineStyles
            , Css.color (Css.hex "aaa")
            ]
        ]
        [ Html.text line ]


lineStyles : Css.Style
lineStyles =
    Css.batch
        [ Css.display Css.block
        , Css.borderBottom3 (Css.px 1) Css.solid (Css.hex "#ddd")
        , Css.marginTop (Css.px 3)
        ]


codeStyles : Css.Style
codeStyles =
    Css.batch
        [ Css.whiteSpace Css.pre
        , Css.display Css.block
        , Css.width (Css.pct 50)
        ]


map2WithMaybes : (Maybe a -> Maybe b -> c) -> List a -> List b -> List c
map2WithMaybes f list1 list2 =
    List.map2
        f
        (List.map Just list1 ++ List.repeat (List.length list2 - List.length list1) Nothing)
        (List.map Just list2 ++ List.repeat (List.length list1 - List.length list2) Nothing)
