{-# LANGUAGE MultiParamTypeClasses #-}
import Control.Failure
import Control.Applicative
import Control.Monad

data FooExc = FooExc
    deriving Show
data BarExc = BarExc
    deriving Show

data FooBarBaz a = Foo FooExc | Bar BarExc | Baz a
    deriving Show

instance Functor FooBarBaz where
    fmap = liftM
instance Applicative FooBarBaz where
    pure = return
    (<*>) = ap
instance Monad FooBarBaz where
    return = Baz

    Foo x >>= _ = Foo x
    Bar x >>= _ = Bar x
    Baz a >>= f = f a
instance Failure FooExc FooBarBaz where
    failure = Foo
instance Failure BarExc FooBarBaz where
    failure = Bar


main = print $ do
    failure FooExc
    return () :: FooBarBaz ()