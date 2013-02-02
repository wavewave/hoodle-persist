{-# LANGUAGE DeriveDataTypeable, TypeFamilies, StandaloneDeriving #-}

-----------------------------------------------------------------------------
-- |
-- Module      : Hoodle.Persist.Types
-- Copyright   : (c) 2013 Ian-Woo Kim
--
-- License     : BSD3
-- Maintainer  : Ian-Woo Kim <ianwookim@gmail.com>
-- Stability   : experimental
-- Portability : GHC
--
-----------------------------------------------------------------------------

module Hoodle.Persist.Types where

import Control.Monad
import Control.Monad.Reader
import Control.Monad.State
import Data.Acid
import Data.Acid.Advanced
import Data.SafeCopy 
import Data.Typeable
import System.FilePath 

data HoodlePersistState = HoodlePersistState 
                          { recentPath :: FilePath
                          } 
                          deriving (Show,Typeable)

instance SafeCopy HoodlePersistState where 
  putCopy (HoodlePersistState p) = contain $ safePut p 
  getCopy = contain $ liftM HoodlePersistState safeGet 

writeState :: String -> Update HoodlePersistState () 
writeState p = put (HoodlePersistState p) 

queryState :: Query HoodlePersistState String
queryState = do HoodlePersistState p <- ask 
                return p 

data WriteState = WriteState String 
data QueryState = QueryState 

deriving instance Typeable WriteState 
instance SafeCopy WriteState where 
  putCopy (WriteState st) = contain $ safePut st 
  getCopy = contain $ liftM WriteState safeGet 
instance Method WriteState where
  type MethodResult WriteState = () 
  type MethodState WriteState = HoodlePersistState 
instance UpdateEvent WriteState 

deriving instance Typeable QueryState 
instance SafeCopy QueryState where 
  putCopy QueryState = contain $ return () 
  getCopy = contain $ return QueryState 
instance Method QueryState where
  type MethodResult QueryState = String 
  type MethodState QueryState = HoodlePersistState 
instance QueryEvent QueryState 

instance IsAcidic HoodlePersistState where
  acidEvents = [ UpdateEvent (\(WriteState p) -> writeState p) 
               , QueryEvent (\QueryState -> queryState) 
               ] 




