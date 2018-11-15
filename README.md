# purescript-styled
Styled Components Library

This project aims to simplify working with local dynamic CSS code

# How to build
Just type ``bower install && pulp server`` in your terminal and open ``localhost:1337``

# Guide
It meant to be used with purescript-halogen and purescript-css

You must use ``styledPage`` function from CSS.Styled, it's type:
```purescript
styledPage :: forall p i. Array (StyledComponent) -> Array (HH.HTML p i) -> HH.HTML p i
```

First argument is ``Array (StyledComponent)`` which means array (``[]``) of StyledComponents.
Second arguments is a ``Array (HH.HTML p i)`` which means array (``[]``) html elements.
You must list all StyledComponent elements in first argument to use them in second argument.

Then ``styledPage`` function must be used as wrapper in render function in halogen architecture.

# How to Create StypedComponent
It's easy, you must use ``StyledComponent`` type and function ``styled`` from CSS.Styled.
Example:
```purescript
labelStyled :: StyledComponent
labelStyled = styled "label" $ do
    fontSize $ px 18.0
    marginRight $ px 20.0
```
First arguments to styled function must be ``String`` name of html element and second argument must be StyleM Unit block.
Now you can place it in your ``styledPage`` like that:
```purescript
styledPage
    [ labelStyled
    ]
    [ labelStyled.element [] []
    ]
```