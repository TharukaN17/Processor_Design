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
cv2.imshow('original', imageIn)
cv2.waitKey()

inputImage = open("output_filtered.txt", "r")
content = inputImage.read()
contentList = content.split("\n")
inputImage.close()
intList = [int(x, 2) for x in contentList]
uint8List = [np.uint8(x) for x in intList]
image = np.array(uint8List)
imageFiltered = image.reshape(256, 256)
print(imageFiltered)
cv2.imshow('Filtered', imageFiltered)
cv2.waitKey()

inputImage = open("output_downscaled.txt", "r")
content = inputImage.read()
contentList = content.split("\n")
inputImage.close()
intList = [int(x, 2) for x in contentList]
uint8List = [np.uint8(x) for x in intList]
image = np.array(uint8List)
imageDownsampled = image.reshape(128, 128)
print(imageDownsampled)
cv2.imshow('Downsampled', imageDownsampled)
cv2.waitKey()
cv2.destroyAllWindows()
