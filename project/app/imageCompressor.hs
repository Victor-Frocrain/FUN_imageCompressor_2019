module Main where

import Functions
import System.Exit
import System.Environment
import System.Directory
import Text.Read
import System.IO

main :: IO ()
main = do
  args <- getArgs
  if ((countArgs args 0) /= 3) then exitWith (ExitFailure 84)
  else do
    let params = computeParams args
    if ((parseParams params) == True) then do
      let fileName = takeFileName params
      exist <- doesFileExist fileName
      if (exist == True) then do
        fileContent <- readFile fileName
        let fileLines = lines fileContent
        let pixels = fillPixels fileLines []
        let compos = dividePixels pixels (myRound ((fromIntegral (length pixels)) / (fromIntegral (nbColors params)))) 0 (length pixels) (nbColors params) []
        let clusters = computeNewClusters compos 0 (nbColors params) []
        let finalColors = clustersLoop pixels clusters compos (convergence params)
        let finalClusters = computeNewClusters finalColors 0 (nbColors params) []
        if (checkPixels pixels == True) then putStr (displayResults finalColors finalClusters "" 0)
        else exitWith (ExitFailure 84)
      else exitWith (ExitFailure 84)
    else
      exitWith (ExitFailure 84)
    exitWith (ExitSuccess)
  exitWith (ExitSuccess)

displayPixels :: [Pixel] -> String -> String
displayPixels (Pixel{posX=posX, posY=posY, colr=colr, colv=colv, colb=colb}:[]) str = str ++ ("PosX = " ++ (show posX) ++ " PosY = " ++ (show posY) ++ " colR = " ++ (show colr) ++ " colV = " ++ (show colv) ++ " colB = " ++ (show colb))
displayPixels (Pixel{posX=posX, posY=posY, colr=colr, colv=colv, colb=colb}:ps) str = displayPixels ps (str ++ ("PosX = " ++ (show posX) ++ " PosY = " ++ (show posY) ++ " colR = " ++ (show colr) ++ " colV = " ++ (show colv) ++ " colB = " ++ (show colb)) ++ "\n")

computeParams :: [String] -> Params
computeParams args = params
                    where
                      params = handleArgs args defaultParams 0

takeFileName :: Params -> String
takeFileName (Params{file=file}) = file

checkPixels :: [Pixel] -> Bool
checkPixels (pix:[]) = parsePixel pix
checkPixels (pix:ps) = if (parsePixel pix == True) then checkPixels ps
                       else False

parsePixel :: Pixel -> Bool
parsePixel (Pixel{posX=posX, posY=posY, colr=colr, colv=colv, colb=colb}) = if (posX >= 0 && posY >= 0 &&
                                                                                 colr >= 0 && colr <= 255 &&
                                                                                 colv >= 0 && colv <= 255 &&
                                                                                 colb >= 0 && colb <= 255) then True
                                                                             else False

fillPixels :: [String] -> [Pixel] -> [Pixel]
fillPixels (x:[]) pix = pix ++ [(parseLine x 0 (length x) 0 False defaultPixel)]
fillPixels (x:l) pix = fillPixels l (pix ++ [(parseLine x 0 (length x) 0 False defaultPixel)])

parseLine :: String -> Int -> Int -> Int -> Bool -> Pixel -> Pixel
parseLine line 0 len 0 bool pix = if (0 < len && line !! 0 == '(') then parseLine line 1 len 0 True pix
                                  else defaultPixel
parseLine line i len indice bool pix = if (i < len && line !! i >= '0' && line !! i <= '9' && indice == 0 && bool == True) then parseLine line (i + 1) len (indice + 1) False (pix {posX= handleInt (takeNumber line i len "")})
                                       else if (i < len && line !! i >= '0' && line !! i <= '9' && indice == 1 && bool == True) then parseLine line (i + 1) len (indice + 1) False (pix {posY= handleInt (takeNumber line i len "")})
                                       else if (i < len && line !! i >= '0' && line !! i <= '9' && indice == 2 && bool == True) then parseLine line (i + 1) len (indice + 1) False (pix {colr= handleInt (takeNumber line i len "")})
                                       else if (i < len && line !! i >= '0' && line !! i <= '9' && indice == 3 && bool == True) then parseLine line (i + 1) len (indice + 1) False (pix {colv= handleInt (takeNumber line i len "")})
                                       else if (i < len && line !! i >= '0' && line !! i <= '9' && indice == 4 && bool == True) then parseLine line (i + 1) len (indice + 1) False (pix {colb= handleInt (takeNumber line i len "")})
                                       else if (i < len && line !! i == ',' && (indice == 1 || indice == 3 || indice == 4) && bool == False) then parseLine line (i + 1) len indice True pix
                                       else if (i + 2 < len && line !! i == ')' && line !! (i + 1) == ' ' && line !! (i + 2) == '(' && (indice == 2) && bool == False) then parseLine line (i + 3) len indice True pix
                                       else if (i < len && line !! i >= '0' && line !! i <= '9' && bool == False) then parseLine line (i + 1) len indice bool pix
                                       else if (i < len && (i + 1) >= len && line !! i == ')' && indice == 5) then pix
                                       else defaultPixel

takeNumber :: String -> Int -> Int -> String -> String
takeNumber line i len result = if (i < len && line !! i >= '0' && line !! i <= '9') then takeNumber line (i + 1) len (result ++ [line !! i])
                                      else result

countArgs :: [String] -> Int -> Int
countArgs (_:args) i = countArgs args (i + 1)
countArgs [] i = i

parseParams :: Params -> Bool
parseParams (Params{nbColors=nb, convergence=c, file=f}) = if (nb >= 0 && c >= 0) then True
                                                         else False

handleArgs :: [String] -> Params -> Int -> Params
handleArgs [] params _ = params
handleArgs (x:args) params 0 = handleArgs args (params {nbColors = handleInt x}) 1
handleArgs (x:args) params 1 = handleArgs args (params {convergence = handleFloat x}) 2
handleArgs (x:args) params 2 = handleArgs args (params {file = x}) 3

handleInt :: String -> Int
handleInt s = case (readMaybe s :: Maybe Int) of
                Nothing -> (-1)
                Just a -> a

handleFloat :: String -> Float
handleFloat s = case (readMaybe s :: Maybe Float) of
                Nothing -> (-1)
                Just a -> a

handleErrorInt :: String -> Bool
handleErrorInt s = case (readMaybe s :: Maybe Int) of
                    Nothing -> True
                    Just a -> False