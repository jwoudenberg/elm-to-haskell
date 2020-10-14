module Authored exposing (Example, examples)


type alias Example =
    { description : String
    , elm : String
    , haskell : Maybe String
    }


examples : List Example
examples =
    [ { description = "Comments"
      , elm =
            """
            -- a single line comment

            {- a multiline comment
              {- can be nested -}
            -}
            """
      , haskell = Nothing
      }
    , { description = "Literals"
      , elm =
            """
            True  : Bool
            False : Bool

            42    : number  -- Int or Float depending on usage
            3.14  : Float

            '`a'   : Char`
            "abc" : String

            \"\"\"
            This is useful for holding JSON or other
            content that has "quotation marks".
            \"\"\"

            True && not (True || False)
            (2 + 4) * (4^2 - 9)
            "abc" ++ "def"
            """
      , haskell =
            Just
                """
                |
                |
                |
                |
                |
                |
                |
                |
                |
                "\\
                \\This is not at all useful for holding JSON or\\n
                \\content that has "quotation marks".\\n
                \\"
                |
                |
                |
                |
                """
      }
    , { description = "Lists"
      , elm =
            """
            [1,2,3,4]
            1 :: [2,3,4]
            1 :: 2 :: 3 :: 4 :: []
            """
      , haskell =
            Just
                """
                |
                1 : [2,3,4]
                1 : 2 : 3 : 4 : []
                """
      }
    , { description = "Conditionals"
      , elm =
            """
            if powerLevel > 9000 then "OVER 9000!!!" else "meh"

            if key == 40 then
                n + 1
            else if key == 38 then
                n - 1
            else
                n

            case maybe of
              Just xs -> xs
              Nothing -> []

            case xs of
              hd::tl ->
                Just (hd,tl)
              [] ->
                Nothing

            case n of
              0 -> 1
              1 -> 1
              _ -> fib (n-1) + fib (n-2)
            """
      , haskell =
            Just
                """
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                case xs of
                  hd : tl ->
                    Just (hd,tl)
                  [] ->
                    Nothing
                |
                |
                |
                |
                |
                """
      }
    , { description = "Union Types"
      , elm =
            """
            type List = Empty | Node Int List
            """
      , haskell =
            Just
                """
                data List = Empty | Node Int List


                > In Haskell these are called ‘Algebraic Data Types’ (ADT).


                > If you only have a single constructor, you can use ‘newtype’.
                > This is super useful for creating custom versions of primitive
                > types, See: http://dev.stephendiehl.com/hask/#newtype-deriving

                newtype PersonId = PersonId Int
                """
      }
    , { description = "Records"
      , elm =
            """
            point =                         -- create a record
              { x = 3, y = 4 }

            point.x                         -- access field

            List.map .x [point,{x=0,y=0}]   -- field access function

            { point | x = 6 }               -- update a field

            { point |                       -- update many fields
                x = point.x + 1,
                y = point.y + 1
            }

            dist {x,y} =                    -- pattern matching on fields
              sqrt (x^2 + y^2)



            type alias Location =           -- type aliases for records
              { line : Int
              , column : Int
              }
            """
      , haskell =
            Just
                """
                data Point = Point { x :: Int, y :: Int }
                point = Point { x = 3, y = 4 }

                x point

                fmap x [point, Point { x = 0, y = 0 }]

                point { x = 6 }

                point {
                  x = x point + 1,
                  y = y point + 1
                }

                dist (Point {x,y}) =
                  sqrt (x^2 + y^2)


                > The above example uses the NamedFieldPuns language extension


                > Haskell records are always wrapped in a type as shown above.
                > The record `{ x :: Int, y :: Int }` is not a type on its own
                > like in Elm, and so it can not be aliased.
                """
      }
    , { description = "Functions"
      , elm =
            """
            square n =
              n^2

            hypotenuse a b =
              sqrt (square a + square b)

            distance (a,b) (x,y) =
              hypotenuse (a-x) (b-y)
            """
      , haskell = Nothing
      }
    , { description = "Anonymous Functions"
      , elm =
            """
            square =
              \\n -> n^2

            squares =
              List.map (\\n -> n^2) (List.range 1 100)
            """
      , haskell =
            Just
                """
                |
                |
                |
                squares =
                  fmap (\\n -> n^2) [1..100]
                """
      }
    , { description = "Infix Operators"
      , elm =
            """
            (?) : Maybe a -> a -> a
            (?) maybe default =
              Maybe.withDefault default maybe

            infixr 9 ?

            viewNames1 names =
              String.join ", " (List.sort names)

            viewNames2 names =
              names
                |> List.sort
                |> String.join ", "
            """
      , haskell =
            Just
                """
                (?) :: Maybe a -> a -> a
                m ? default = maybe default id m


                |

                viewNames1 names =
                  Data.List.intercalate ", " (Data.List.sort names)

                viewNames2 =
                  Data.List.intercalate ", " . Data.List.sort


                > `.` does in Haskell as `<<` does in Elm.
                """
      }
    , { description = "Let Expressions"
      , elm =
            """
            let
              twentyFour =
                3 * 8
              sixteen =
                4 ^ 2
            in
            twentyFour + sixteen

            let
              ( three, four ) =
                ( 3, 4 )
              hypotenuse a b =
                sqrt (a^2 + b^2)
            in
              hypotenuse three four

            let
              name : String
              name =
                "Hermann"
              increment : Int -> Int
              increment n =
                n + 1
            in
              increment 10
            """
      , haskell =
            Just
                """
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                let
                  name :: String
                  name =
                    "Hermann"
                  increment :: Int -> Int
                  increment n =
                    n + 1
                in
                  increment 10
                """
      }
    , { description = "Applying Functions"
      , elm =
            """
            append xs ys = xs ++ ys
            xs = [1,2,3]
            ys = [4,5,6]

            a1 = append xs ys
            a2 = xs ++ ys

            b2 = (++) xs ys

            c1 = (append xs) ys
            c2 = ((++) xs) ys

            23 + 19    : number
            2.0 + 1    : Float

            6 * 7      : number
            10 * 4.2   : Float

            100 // 2  : Int
            1 / 2     : Float

            (,) 1 2              == (1,2)
            (,,,) 1 True 'a' []  == (1,True,'a',[])
            """
      , haskell =
            Just
                """
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                |
                23 + 19    :: Number t => t
                2.0 + 1    :: Float

                6 * 7      :: Number t => t
                10 * 4.2   :: Float

                quot 100 2  :: Int
                1 / 2       :: Float
                |
                |
                |
                """
      }
    , { description = "Modules"
      , elm =
            """
            module MyModule exposing (..)

            import List                    -- List.map, List.foldl
            import List as L               -- L.map, L.foldl

            import List exposing (..)               -- map, foldl, concat, ...
            import List exposing ( map, foldl )     -- map, foldl

            import Maybe exposing ( Maybe )         -- Maybe
            import Maybe exposing ( Maybe(..) )     -- Maybe, Just, Nothing
            import Maybe exposing ( Maybe(Just) )   -- Maybe, Just
            """
      , haskell =
            Just
                """
                module MyModule where

                import qualified Data.List
                import qualified Data.List as L

                import Data.List
                import Data.List ( map, fold )

                import Data.Maybe ( Maybe )
                import Data.Maybe ( Maybe(..) )
                import Data.Maybe ( Maybe(Just) )
                """
      }
    , { description = "Type Annotations"
      , elm =
            """
            answer : Int
            answer =
              42

            factorial : Int -> Int
            factorial n =
              List.product (List.range 1 n)

            distance : { x : Float, y : Float } -> Float
            distance {x,y} =
              sqrt (x^2 + y^2)
            """
      , haskell =
            Just
                """
                answer :: Int
                answer =
                  42

                factorial :: Int -> Int
                factorial n =
                  Data.List.product [1..n]

                distance :: Point `{ x :: Float, y :: Float }` `-> Float`
                distance (Point {x,y}) =
                  sqrt (x^2 + y^2)
                """
      }
    , { description = "Type Aliases"
      , elm =
            """
            type alias Name = String
            type alias Age = Int

            info : (Name,Age)
            info =
              ("Steve", 28)

            type alias Point = { x:Float, y:Float }

            origin : Point
            origin =
              { x = 0, y = 0 }
            """
      , haskell =
            Just
                """
                type Name = String
                type Age = Int

                info :: (Name, Age)
                info =
                  (`"``Steve``"``, 28)`

                data Point = Point { x :: Float, y :: Float }

                origin :: Point
                origin =
                  Point { x = 0, y = 0 }
                """
      }
    , { description = "JavaScript Interop"
      , elm =
            """
            port prices : (Float -> msg) -> Sub msg

            port time : Float -> Cmd msg
            """
      , haskell =
            Just
                """
                prices :: IO Float

                setCurrentTime :: Float -> IO ()
                """
      }
    ]
