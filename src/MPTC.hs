{-# LANGUAGE DeriveDataTypeable        #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE FunctionalDependencies    #-}
{-# LANGUAGE MultiParamTypeClasses     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE UndecidableInstances      #-}
module MPTC where

import           Control.Exception
import           Data.Typeable

class MonadThrow e m where
    throwM :: e -> m a
instance Exception e => MonadThrow e IO where
    throwM = throwIO

data MyException = MyException
    deriving (Show, Typeable)
instance Exception MyException

myFunc = throwM MyException
