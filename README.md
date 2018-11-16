# purescript-styled
Styled Components Library

This project aims to simplify working with local dynamic CSS code

# How to build
Just type `bower install && pulp server` in your terminal and open `localhost:1337`

# Guide
It meant to be used with purescript-halogen and purescript-css

You must use `styledPage` function from `CSS.Styled` module, it has type:
```purescript
styledPage :: forall p i. Array (Styled) -> Array (HH.HTML p i) -> HH.HTML p i
```

First argument is `Array (Styled)` which means array (`[]`) of our styled html elements.<br />
Second arguments is a `Array (HH.HTML p i)` which means array (`[]`) of html elements.<br />
You must list all `Styled` elements (just once each element) in first argument to use them in second argument.

So `styledPage` function must be used as wrapper in render function in halogen architecture.<br />

# How to Create Styled (Component)
It's easy, you must use `Styled` type and function `styled` from `CSS.Styled` module.<br />
Example:
```purescript
labelStyled :: Styled
labelStyled = styled label $ do
    fontSize $ px 18.0
    marginRight $ px 20.0
```
First arguments to styled function must be `ElementName` (they are placed in `CSS.Styled` module with corresponding html tag name) name of html element and second argument must be `StyleM Unit` block.
Now you can place it in your `styledPage` like that:
```purescript
styledPage
    [ labelStyled
    ]
    [ labelStyled.element [] [ HH.text "It works!" ]
    ]
```