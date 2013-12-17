{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE RankNTypes #-}
module TypeFamilies where

import Control.Exception

class MonadThrow m where
    type Exc m
    throwM :: Exc m -> m a

instance Exception (Exc m) => MonadThrow IO where
    type Exc m = forall e. Exception e => e