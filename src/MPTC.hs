{-# LANGUAGE DeriveDataTypeable        #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE FunctionalDependencies    #-}
{-# LANGUAGE MultiParamTypeClasses     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE UndecidableInstances      #-}
{-# LANGUAGE ScopedTypeVariables       #-}
module MPTC where

import           Control.Exception
import           Data.Typeable

class MonadThrow e m where
    throwM :: e -> m a
instance Exception e => MonadThrow e IO where
    throwM = throwIO

class MonadThrow e m => MonadCatch e m where
    catchM :: m a -> (e -> m a) -> m a
instance Exception e => MonadCatch e IO where
    catchM = catch

data MyException = MyException
    deriving (Show, Typeable)
instance Exception MyException

myFunc = throwM MyException `catchM` \(_ :: MyException) -> return ()
