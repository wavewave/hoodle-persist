-----------------------------------------------------------------------------
-- |
-- Executable  : HoodlePersistServer
-- Copyright   : (c) 2013 Ian-Woo Kim
--
-- License     : BSD3
-- Maintainer  : Ian-Woo Kim <ianwookim@gmail.com>
-- Stability   : experimental
-- Portability : GHC
--
-----------------------------------------------------------------------------

module Main where 

-- import System.Environment
import Data.Acid
import Data.Acid.Remote
import Network
-- 
import Hoodle.Persist.Types 


main :: IO () 
main = do 
  acid <- openLocalState (HoodlePersistState "Hello World")
  acidServer acid (UnixSocket "hoodle-persist")
{-          args <- getArgs
          if null args 
             then do p <- query acid QueryState 
                     putStrLn $ "The state ; " ++ p 
             else do update acid (WriteState (unwords args))
                     putStrLn $ "The state has been modified"
-}
