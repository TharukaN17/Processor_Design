import cv2
import numpy as np

inputImage = open("input.txt", "r")
content = inputImage.read()
contentList = content.split("\n")
inputImage.close()
intList = [int(x, 2) for x in contentList]
uint8List = [np.uint8(x) for x in intList]
image = np.array(uint8List)
imageIn = image.reshape(256, 256)
print(imageIn)
cv2.imshow('Original', imageIn)
cv2.waitKey()

currentPixel    = 257
currentRowPixel = 0
totalRowPixels  = 253
totalPixels     = 65278

while True:
    middle          =   np.uint16(image[currentPixel])
    right           =   np.uint16(image[currentPixel+1])
    left            =   np.uint16(image[currentPixel-1])
    bottom          =   np.uint16(image[currentPixel+256])
    top             =   np.uint16(image[currentPixel-256])
    bottomRight     =   np.uint16(image[currentPixel+257])
    topLeft         =   np.uint16(image[currentPixel-257])
    bottomLeft      =   np.uint16(image[currentPixel+255])
    topRight        =   np.uint16(image[currentPixel-255])
    storeLoc        =   currentPixel-257
    image[storeLoc] =   np.uint8((middle*4 + (right+left+bottom+top)*2 + (bottomLeft+bottomRight+topLeft+topRight))/16)

    if currentPixel ==  totalPixels:
        break
    elif currentRowPixel == totalRowPixels:
        currentRowPixel  =  0
        currentPixel     =  currentPixel+3
    else:
        currentRowPixel  =  currentRowPixel+1
        currentPixel     =  currentPixel+1

imageFiltered = image.reshape(256, 256)
print(imageFiltered)
cv2.imshow('Filtered', imageFiltered)
cv2.waitKey()

currentPixelLoc = 0
currentStoreLoc = 0
currentRowPixel = 0
totalRowPixels  = 252
totalPixels     = 64764

while True:
    image[currentStoreLoc] = image[currentPixelLoc]
    if currentPixelLoc == totalPixels:
        break
    elif currentRowPixel == totalRowPixels:
        currentRowPixel = 0
        currentPixelLoc = currentPixelLoc+260
        currentStoreLoc = currentStoreLoc+1
    else:
        currentRowPixel = currentRowPixel+2
        currentPixelLoc = currentPixelLoc+2
        currentStoreLoc = currentStoreLoc+1

imageDownsampled = image[:16129].reshape(127, 127)
print(imageDownsampled)
cv2.imshow('Downscaled', imageDownsampled)
cv2.waitKey()
cv2.destroyAllWindows()
