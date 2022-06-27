import cv2
import numpy as np

input_image = open("input.txt", "r")
content = input_image.read()
content_list = content.split("\n")
input_image.close()
lis = [int(x, 2) for x in content_list]
liss = [np.uint8(x) for x in lis]
l = np.array(liss)
ll = l.reshape(256, 256)
print(ll)
cv2.imshow('original', ll)
cv2.waitKey()

input_image = open("output_filtered.txt", "r")
content = input_image.read()
content_list = content.split("\n")
input_image.close()
lis = [int(x, 2) for x in content_list]
liss = [np.uint8(x) for x in lis]
l = np.array(liss)
ll = l.reshape(256, 256)
print(ll)
cv2.imshow('filtered', ll)
cv2.waitKey()

input_image = open("output_downscaled.txt", "r")
content = input_image.read()
content_list = content.split("\n")
input_image.close()
lis = [int(x, 2) for x in content_list]
liss = [np.uint8(x) for x in lis]
l = np.array(liss)
ll = l.reshape(127, 127)
print(ll)
cv2.imshow('downscaled', ll)
cv2.waitKey()
cv2.destroyAllWindows()
