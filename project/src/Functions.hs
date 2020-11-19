module Functions where

data Params = Params { nbColors :: Int
                     , convergence :: Float
                     , file :: String
                     }

data Pixel = Pixel { posX :: Int
                     , posY :: Int
                     , colr :: Int
                     , colv :: Int
                     , colb :: Int
                     }

myHead :: [a] -> a

myHead [] = error "liste vide"

myHead (x:_) = x

data Cluster = Cluster  { colR :: Int
                         , colV :: Int
                         , colB :: Int
                        }

data ColorCluster = ColorCluster {  pos :: Int
                                 ,  pixel :: Pixel
                                 }

data Colors = Colors { red :: Int
                     , green :: Int
                     , blue :: Int
                     }

defaultParams = Params {nbColors = (-1), convergence = (-1.0), file = ""}
defaultPixel = Pixel {posX = (-1), posY = (-1), colr = (-1), colv = (-1), colb = (-1)}
defaultCluster = Cluster {colR = 0, colV = 0, colB = 0}

clustersLoop :: [Pixel] -> [Cluster] -> [ColorCluster] -> Float -> [ColorCluster]
clustersLoop pixels clusters colors conv = if (continue == True) then clustersLoop pixels newClusters newColors conv
                                           else newColors
                                             where
                                               newColors = associatePixels pixels clusters []
                                               newClusters = computeNewClusters newColors 0 (length clusters) []
                                               continue = continueLoop clusters newClusters conv

continueLoop :: [Cluster] -> [Cluster] -> Float -> Bool
continueLoop [] [] _ = False
continueLoop (original:orList) (new:newList) conv = if (diff >= conv) then True
                                                    else continueLoop orList newList conv
                                                      where
                                                        diff = computeConvergence original new

computeNewClusters :: [ColorCluster] -> Int -> Int -> [Cluster] -> [Cluster]
computeNewClusters colors i max clusters = if (i < max - 1) then computeNewClusters colors (i + 1) max (clusters ++ [(computeNewValues colors i 0 defaultCluster)])
                                           else clusters ++ [(computeNewValues colors i 0 defaultCluster)]

computeNewValues :: [ColorCluster] -> Int -> Int -> Cluster -> Cluster
computeNewValues [] i 0 cluster = cluster
computeNewValues [] i nb cluster = (cluster {colR= r, colV= g, colB= b})
                                    where
                                      r = midRound ((fromIntegral (colR cluster)) / (fromIntegral nb))
                                      g = midRound ((fromIntegral (colV cluster)) / (fromIntegral nb))
                                      b = midRound ((fromIntegral (colB cluster)) / (fromIntegral nb))
computeNewValues ((ColorCluster{pos=pos, pixel=pixel}):cols) i nb cluster = if (i == pos) then computeNewValues cols i (nb + 1) (cluster {colR= r, colV= g, colB= b})
                                                                           else computeNewValues cols i nb cluster
                                                                              where
                                                                                r = (colr pixel) + (colR cluster)
                                                                                g = (colv pixel) + (colV cluster)
                                                                                b = (colb pixel) + (colB cluster)

dividePixels :: [Pixel] -> Int -> Int -> Int -> Int -> [ColorCluster] -> [ColorCluster]
dividePixels [] _ _ _ _ colors = colors
dividePixels (pixel:list) 1 i nbCol nbClusters colors = dividePixels list (myRound ((fromIntegral (length list)) / (fromIntegral (nbClusters - 1)))) (i + 1) (nbCol - 1) (nbClusters - 1) (colors ++ [(ColorCluster {pos= i, pixel= pixel})])
dividePixels (pixel:list) nb i nbCol nbClusters colors = dividePixels list (nb - 1) i (nbCol - 1) nbClusters (colors ++ [(ColorCluster {pos= i, pixel= pixel})])

displayCluster :: [Cluster] -> String -> String
displayCluster [] str = str
displayCluster (Cluster{colR=colR, colV=colV, colB=colB}:[]) str = (str ++ ((show colR) ++ "|" ++ (show colV) ++ "|" ++ (show colB)))
displayCluster (Cluster{colR=colR, colV=colV, colB=colB}:xs) str = displayCluster xs (str ++ ((show colR) ++ "|" ++ (show colV) ++ "|" ++ (show colB)) ++ "       ")

computeConvergence :: Cluster -> Cluster -> Float
computeConvergence (Cluster{colR=colR, colV=colV, colB=colB}) (Cluster{colR=r, colV=v, colB=b}) = if (convergence >= 0) then convergence
                                                                                                  else (convergence * (-1))
                                                                                                    where
                                                                                                        convergence = ((fromIntegral (colR + colV + colB)) / 3) - ((fromIntegral (r + v + b)) / 3)

associatePixels :: [Pixel] -> [Cluster] -> [ColorCluster] -> [ColorCluster]
associatePixels (pix:[]) clusters colors = colors ++ [(ColorCluster {pos= (calcClusterPos pix clusters 0 0 255), pixel= pix})]
associatePixels (pix:pixList) clusters colors = associatePixels pixList clusters (colors ++ [(ColorCluster {pos= (calcClusterPos pix clusters 0 0 255), pixel= pix})])

calcClusterPos :: Pixel -> [Cluster] -> Int -> Int -> Int -> Int
calcClusterPos pixel (cluster:[]) pos current distance = if (currentDistance < distance) then current
                                                         else pos
                                                            where
                                                                currentDistance = computeEuclidianDistance pixel cluster
calcClusterPos pixel (cluster:clList) pos current distance = if (currentDistance < distance) then calcClusterPos pixel clList current (current + 1) currentDistance
                                                             else calcClusterPos pixel clList pos (current + 1) distance
                                                                where
                                                                    currentDistance = computeEuclidianDistance pixel cluster

computeEuclidianDistance :: Pixel -> Cluster -> Int
computeEuclidianDistance (Pixel{colr=colR, colv=colV, colb=colB}) (Cluster{colR=r, colV=v, colB=b}) = round (sqrt (fromIntegral ((colR - r) * (colR - r) + (colV - v) * (colV - v) + (colB - b) * (colB - b))))

displayResults :: [ColorCluster] -> [Cluster] -> String -> Int -> String
displayResults colors (cluster:[]) result i = result ++ "--\n" ++ (createLineCluster cluster) ++ "-\n" ++ (displayColors colors i "")
displayResults colors (cluster:list) result i = displayResults colors list (result ++ "--\n" ++ (createLineCluster cluster) ++ "-\n" ++ (displayColors colors i "")) (i + 1)

createLineCluster :: Cluster -> String
createLineCluster (Cluster{colR=colR, colV=colV, colB=colB}) = "(" ++ (show colR) ++ "," ++ (show colV) ++ "," ++ (show colB) ++ ")\n"

displayColors :: [ColorCluster] -> Int -> String -> String
displayColors (colors:[]) i result = if ((pos colors) == i) then result ++ (createLineColor (pixel colors))
                                     else result
displayColors (colors:list) i result = if ((pos colors) == i) then displayColors list i (result ++ (createLineColor (pixel colors)))
                                       else displayColors list i result

createLineColor :: Pixel -> String
createLineColor (Pixel{posX=x, posY=y, colr=r, colv=v, colb=b}) = "(" ++ (show x) ++ "," ++ (show y) ++ ") (" ++ (show r) ++ "," ++ (show v) ++ "," ++ (show b) ++ ")\n"

myRound :: Float -> Int
myRound x
    | (x - (fromIntegral(truncate x))) < 0.5 = truncate x
    | otherwise = (truncate x) + 1

midRound :: Float -> Int
midRound x
    | (x - (fromIntegral(truncate x))) <= 0.5 = truncate x
    | otherwise = (truncate x) + 1