module Main where

import CSS (fontSize, px, width)
import Prelude (Unit, Void, bind, const, pure, unit, ($), (<<<))

import CSS.Extra (custom)
import CSS.Styled (Styled, div, img, label, styled, styledPage)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.VDom.Driver (runUI)

-- QUERY
data Query a = Unit a

-- STATE
type State = Unit

initialState :: Unit
initialState = unit

-- CSS

-- some styled label
labelStyled :: Styled
labelStyled = styled label $ do
    fontSize $ px 18.0

-- div with gray background
divStyled :: Styled
divStyled = styled div $
    custom "background-color" "#dadada"

logo :: Styled
logo = styled img <<< width $ px 10.0

-- RENDER
render :: State -> H.ComponentHTML Query
render state =
    styledPage
        -- you must provide list of all styled component elements
        -- which you will use in HTML section bellow
        [ labelStyled
        , divStyled
        ]
        -- html section bellow
        [ divStyled.html [] []
        ]

-- EVAL
eval :: forall a m. Query a -> H.ComponentDSL State Query Void m a
eval (Unit a) = pure a

-- UI
ui :: forall a. H.Component HH.HTML Query Unit Void a
ui = H.component
    { initialState: const initialState
    , render: render
    , eval: eval
    , receiver: const Nothing
    }

-- MAIN
main :: Effect Unit
main = HA.runHalogenAff do
    body <- HA.awaitBody
    runUI ui unit body
