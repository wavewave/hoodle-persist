{-# LANGUAGE OverloadedStrings #-}

-----------------------------------------------------------------------------
-- |
-- Module      : Hoodle.Persist
-- Copyright   : (c) 2013 Ian-Woo Kim
--
-- License     : BSD3
-- Maintainer  : Ian-Woo Kim <ianwookim@gmail.com>
-- Stability   : experimental
-- Portability : GHC
--
-----------------------------------------------------------------------------

module Hoodle.Persist where

import Data.Acid 
import Data.Monoid (mconcat)
import Web.Scotty 

startServer :: IO () 
startServer = scotty 7373 $ do 
    get "/:word" $ do 
      beam <- param "word" 
      html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]

