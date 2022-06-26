import cv2
import numpy as np

image = cv2.imread('test.png', cv2.IMREAD_GRAYSCALE)
cv2.imshow('original', image)
cv2.waitKey()
image2 = image.ravel()
print(image2)
with open('input.txt', 'w') as f:
    f.write('\n'.join("{0:b}".format(int(e)) for e in image2))

my_file = open("output_filtered.txt", "r")
content = my_file.read()
content_list = content.split("\n")
my_file.close()
lis = [int(x, 2) for x in content_list]
liss = [np.uint8(x) for x in lis]
l = np.array(liss)
ll = l.reshape(256, 256)
print(ll)
cv2.imshow('result', ll)
cv2.waitKey()
cv2.destroyAllWindows()
