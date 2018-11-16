module Main where

import CSS
import Prelude

import CSS.Extra (custom)
import CSS.Styled (PageElement, PageElementComposition, Styled, div, fromStyled, img, label, styled, styledPage, toPageElement)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
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
        [ fromStyled (labelStyled) [] [ HH.text "styled label" ]
        , HH.p [] [ HH.text "mere p" ]
        , fromStyled (divStyled) []
            [ fromStyled (labelStyled) []
                [ HH.text "styled label inside styled div with gray background" 
                ]
            ]
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
