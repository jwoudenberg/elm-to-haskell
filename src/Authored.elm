module Authored exposing (Example, examples)


type alias Example =
    { description : String
    , elm : String
    , haskell : String
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
      , haskell =
            """
            -- a single line comment

            {- a multiline comment
              {- can be nested -}
            -}
            """
      }
    , { description = "Literals"
      , elm =
            """
            True  : Bool
            False : Bool

            42    : number  -- Int or Float depending on usage
            3.14  : Float

            'a'   : Char
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
            """
            True  : Bool
            False : Bool

            42    : number  -- Int or Float depending on usage
            3.14  : Float

            'a'   : Char
            "abc" : String

            "\\
            \\This is not at all useful for holding JSON or\\n
            \\content that has \\"quotation marks\\".\\n
            \\"

            True && not (True || False)
            (2 + 4) * (4^2 - 9)
            "abc" ++ "def"
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
            """
            [1,2,3,4]
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
              [] ->
                Nothing
              first :: rest ->
                Just (first, rest)

            case n of
              0 -> 1
              1 -> 1
              _ -> fib (n-1) + fib (n-2)
            """
      , haskell =
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
              [] ->
                Nothing
              first : rest ->
                Just (first, rest)

            case n of
              0 -> 1
              1 -> 1
              _ -> fib (n-1) + fib (n-2)
            """
      }
    , { description = "Records"
      , elm =
            """


            origin = { x = 0, y = 0 }
            point = { x = 3, y = 4 }

            origin.x == 0
            point.x == 3

            List.map .x [ origin, point ] == [ 0, 3 ]

            { point | x = 6 } == { x = 6, y = 4 }

            { point | x = point.x + 1, y = point.y + 1 }
            """
      , haskell =
            """
            data Point = Point { x :: Int, y :: Int }

            origin = Point { x = 0, y = 0 }
            point = Point { x = 3, y = 4 }

            x origin == 0
            x point == 0

            fmap x [ origin, point ] == [ 0, 3 ]

            point { x = 6 } == Point { x = 6, y = 4 }

            point { x = x point + 1, y = y point + 1 }
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
      , haskell =
            """
            square n =
              n^2

            hypotenuse a b =
              sqrt (square a + square b)

            distance (a,b) (x,y) =
              hypotenuse (a-x) (b-y)
            """
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
            """
            square =
              \\n -> n^2

            squares =
              fmap (\\n -> n^2) [1..100]
            """
      }
    , { description = "Operators"
      , elm =
            """
            viewNames1 names =
              String.join ", " (List.sort names)

            viewNames2 names =
              names
                |> List.sort
                |> String.join ", "
            """
      , haskell =
            """
            viewNames1 names =
              Data.List.intercalate ", " (Data.List.sort names)

            viewNames2 names =
              names
                & Data.List.sort
                & Data.List.intercalate ", "
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

            100 // 2   : Int
            1 / 2      : Float
            """
      , haskell =
            """
            append xs ys = xs ++ ys
            xs = [1,2,3]
            ys = [4,5,6]

            a1 = append xs ys
            a2 = xs ++ ys

            b2 = (++) xs ys

            c1 = (append xs) ys
            c2 = ((++) xs) ys

            23 + 19    :: Number t => t
            2.0 + 1    :: Float

            6 * 7      :: Number t => t
            10 * 4.2   :: Float

            quot 100 2 :: Int
            1 / 2      :: Float
            """
      }
    , { description = "Modules"
      , elm =
            """
            module MyModule exposing (..)

            import List
            import List as L

            import List exposing (..)
            import List exposing ( map, foldl )

            import Maybe exposing ( Maybe )
            import Maybe exposing ( Maybe(..) )
            """
      , haskell =
            """
            module MyModule where

            import qualified Data.List
            import qualified Data.List as L

            import Data.List
            import Data.List ( map, fold )

            import Data.Maybe ( Maybe )
            import Data.Maybe ( Maybe(..) )
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
            """
            answer :: Int
            answer =
              42

            factorial :: Int -> Int
            factorial n =
              Data.List.product [1..n]

            distance :: Point { x :: Float, y :: Float } -> Float
            distance Point {x,y} =
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
            """
            type Name = String
            type Age = Int

            info :: (Name, Age)
            info =
              ("Steve", 28)

            data Point = Point { x :: Float, y :: Float }

            origin :: Point
            origin =
              Point { x = 0, y = 0 }
            """
      }
    , { description = "Custom Types"
      , elm =
            """
            type User
              = Regular String Int
              | Visitor String
            """
      , haskell =
            """
            data User
              = Regular String Int
              | Visitor String
            """
      }
    , { description = "JavaScript Interop"
      , elm =
            """
            port prices : (Float -> msg) -> Sub msg

            port time : Float -> Cmd msg
            """
      , haskell =
            """
            prices :: IO Float

            setCurrentTime :: Float -> IO ()
            """
      }
    ]
