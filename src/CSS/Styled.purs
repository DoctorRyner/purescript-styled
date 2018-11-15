module CSS.Styled where

import Prelude

import CSS (StyleM, (?))
import CSS.Extra as CssExtra
import Halogen (ElemName(..))
import Halogen as H
import Halogen.HTML (element)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

type IProp r i = HH.IProp ("class" ∷ String | r) i

type ElementProducer = forall t5 t6 t7. Array (IProp t7 t5) -> Array (HH.HTML t6 t5) -> HH.HTML t6 t5

type Styled = String -> StyleM Unit -> StyledComponent

type StyledComponent =
    { id :: H.ClassName
    , localStyle :: StyleM Unit
    , element :: ElementProducer
    }

styled :: Styled
styled elName gottenStyle =
    { id: newClassName
    , localStyle: gottenStyle
    , element: \attras childas -> element (ElemName elName) (attras <> [HP.class_ newClassName]) childas
    }

    where newClassName = CssExtra.newClass unit

styledPage :: forall p i. Array (StyledComponent) -> Array (HH.HTML p i) -> HH.HTML p i
styledPage components htmlElements =
    HH.div [] $
        [ CssExtra.generateStyle $ CssExtra.composedStylesheet $ map (\tmp -> CssExtra.class_ tmp.id ? tmp.localStyle) components ]
        <> map (\htmlElement -> htmlElement) htmlElements