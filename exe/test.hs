import System.Environment
import Data.Acid
import Hoodle.Persist.Types 

main :: IO () 
main = do acid <- openLocalState (HoodlePersistState "hello world") 
          args <- getArgs
          if null args 
             then do p <- query acid QueryState 
                     putStrLn $ "The state ; " ++ p 
             else do update acid (WriteState (unwords args))
                     putStrLn $ "The state has been modified"
