{-# LANGUAGE DeriveDataTypeable        #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE FunctionalDependencies    #-}
{-# LANGUAGE MultiParamTypeClasses     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE UndecidableInstances      #-}
module FunDeps where

import           Control.Exception
import           Data.Typeable

class MonadThrow e m | m -> e where
    throwM :: e -> m a
instance MonadThrow SomeException IO where
    throwM = throwIO

class MonadThrow e m => MonadCatch e m | m -> e where
    catchM :: m a -> (e -> m a) -> m a

data MyException = MyException
    deriving (Show, Typeable)
instance Exception MyException

myFunc = throwM (toException MyException) `catchM` \_ -> return ()
