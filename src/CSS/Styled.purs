module CSS.Styled where

import Prelude

import CSS (StyleM, (?))
import CSS.Extra as CssExtra
import Data.Foldable (foldr)
import Halogen (ElemName(..))
import Halogen as H
import Halogen.HTML (element)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

type IProp r i = HH.IProp ("class" ∷ String | r) i

type ElementProducer = forall t5 t6 t7. Styled -> Array (IProp t7 t5) -> Array (HH.HTML t6 t5) -> HH.HTML t6 t5

type ElementName = { value :: String }

type StyledComponent = ElementName -> StyleM Unit -> Styled

type Styled =
    { id :: H.ClassName
    , name :: ElementName
    , localStyle :: StyleM Unit
    , html :: forall t5 t6 t7. Array (IProp t7 t5) -> Array (HH.HTML t6 t5) -> HH.HTML t6 t5
    }

name :: String -> ElementName
name str = { value: str }

a = name "a" :: ElementName
abbr = name "abbr" :: ElementName
acronym = name "acronym" :: ElementName
address = name "address" :: ElementName
applet = name "applet" :: ElementName
area = name "area" :: ElementName
article = name "article" :: ElementName
aside = name "aside" :: ElementName
audio = name "audio" :: ElementName
b = name "b" :: ElementName
base = name "base" :: ElementName
basefont = name "basefont" :: ElementName
bdi = name "bdi" :: ElementName
bdo = name "bdo" :: ElementName
big = name "big" :: ElementName
blockquote = name "blockquote" :: ElementName
body = name "body" :: ElementName
br = name "br" :: ElementName
button = name "button" :: ElementName
canvas = name "canvas" :: ElementName
caption = name "caption" :: ElementName
center = name "center" :: ElementName
cite = name "cite" :: ElementName
code = name "code" :: ElementName
col = name "col" :: ElementName
colgroup = name "colgroup" :: ElementName
data_ = name "data" :: ElementName
datalist = name "datalist" :: ElementName
dd = name "dd" :: ElementName
del = name "del" :: ElementName
details = name "details" :: ElementName
dfn = name "dfn" :: ElementName
dialog = name "dialog" :: ElementName
dir = name "dir" :: ElementName
div = name "div" :: ElementName
dl = name "dl" :: ElementName
dt = name "dt" :: ElementName
em = name "em" :: ElementName
embed = name "embed" :: ElementName
fieldset = name "fieldset" :: ElementName
figcaption = name "figcaption" :: ElementName
figure = name "figure" :: ElementName
font = name "font" :: ElementName
footer = name "footer" :: ElementName
form = name "form" :: ElementName
frame = name "frame" :: ElementName
frameset = name "frameset" :: ElementName
h1 = name "h1" :: ElementName
h2 = name "h2" :: ElementName
h3 = name "h3" :: ElementName
h4 = name "h4" :: ElementName
h5 = name "h5" :: ElementName
h6 = name "h6" :: ElementName
head = name "head" :: ElementName
header = name "header" :: ElementName
hr = name "hr" :: ElementName
html = name "html" :: ElementName
i = name "i" :: ElementName
iframe = name "iframe" :: ElementName
img = name "img" :: ElementName
input = name "input" :: ElementName
ins = name "ins" :: ElementName
kbd = name "kbd" :: ElementName
label = name "label" :: ElementName
legend = name "legend" :: ElementName
li = name "li" :: ElementName
link = name "link" :: ElementName
main = name "main" :: ElementName
map_ = name "map" :: ElementName
mark = name "mark" :: ElementName
meta = name "meta" :: ElementName
meter = name "meter" :: ElementName
nav = name "nav" :: ElementName
noframes = name "noframes" :: ElementName
noscript = name "noscript" :: ElementName
object = name "object" :: ElementName
ol = name "ol" :: ElementName
optgroup = name "optgroup" :: ElementName
option = name "option" :: ElementName
output = name "output" :: ElementName
p = name "p" :: ElementName
param = name "param" :: ElementName
picture = name "picture" :: ElementName
pre = name "pre" :: ElementName
progress = name "progress" :: ElementName
q = name "q" :: ElementName
rp = name "rp" :: ElementName
rt = name "rt" :: ElementName
ruby = name "ruby" :: ElementName
s = name "s" :: ElementName
samp = name "samp" :: ElementName
script = name "script" :: ElementName
section = name "section" :: ElementName
select = name "select" :: ElementName
small = name "small" :: ElementName
source = name "source" :: ElementName 
span = name "span" :: ElementName
strike = name "strike" :: ElementName
strong = name "strong" :: ElementName
style = name "style" :: ElementName
sub = name "sub" :: ElementName
summary = name "summary" :: ElementName
sup = name "sup" :: ElementName
svg = name "svg" :: ElementName
table = name "table" :: ElementName
tbody = name "tbody" :: ElementName
td = name "td" :: ElementName
template = name "template" :: ElementName
textarea = name "textarea" :: ElementName
tfoot = name "tfoot" :: ElementName
th = name "th" :: ElementName
thead = name "thead" :: ElementName
time = name "time" :: ElementName
title = name "title" :: ElementName
tr = name "tr" :: ElementName
track = name "track" :: ElementName
tt = name "tt" :: ElementName
u = name "u" :: ElementName
ul = name "ul" :: ElementName
var = name "var" :: ElementName
video = name "video" :: ElementName
wbr = name "wbr" :: ElementName

styled :: StyledComponent
styled elName gottenStyle =
    { id: newClassName
    , name: elName
    , localStyle: gottenStyle
    , html: \attras childas -> element (ElemName elName.value) (attras <> [HP.class_ newClassName]) childas
    }

    where newClassName = CssExtra.newClass unit

fromStyled :: ElementProducer
fromStyled el attras childas = element (ElemName el.name.value) (attras <> [HP.class_ el.id]) childas

styledPage :: forall p i. Array (Styled) -> Array (HH.HTML p i) -> HH.HTML p i
styledPage components htmlElements =
    HH.div [] $
        [ CssExtra.generateStyle
            $ CssExtra.composedStylesheet
                $ map (\tmp -> CssExtra.class_ tmp.id ? tmp.localStyle) components
        ] <> map (\htmlElement -> htmlElement) htmlElements