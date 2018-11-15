module CSS.Extra where

import CSS (class IsString, CSS, Rendered, StyleM, fromString, prefixed, render, renderedSheet)
import Data.Foldable (foldr)
import Data.Maybe (fromMaybe)
import Effect.Random (randomInt)
import Effect.Unsafe (unsafePerformEffect)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Elements as HHE
import Prelude (Unit, show, ($), (<>), pure, unit)

custom :: String -> String -> CSS
custom prop = prefixed (fromString prop)

composedStylesheet :: Array (StyleM Unit) -> Rendered
composedStylesheet classes =
    foldr
        (\tmpClass output -> output <> (render tmpClass) )
        (render $ pure unit)
        classes

class_ :: forall a. IsString a => H.ClassName -> a
class_ (H.ClassName cn) = fromString $ "." <> cn

newClass :: Unit -> H.ClassName
newClass = \_ -> H.ClassName $ "n" <> show (unsafePerformEffect $ randomInt 0 999999999)

generateStyle :: forall t1 t2. Rendered -> HH.HTML t1 t2
generateStyle rendered = HHE.style []
    [ HH.text $ fromMaybe "" $ renderedSheet rendered ] 