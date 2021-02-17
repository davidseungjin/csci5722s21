%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 3
% Instructor: Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# %% [code]
import numpy as np
import matplotlib.pyplot as plt
import cv2

# %% [markdown]
# # Q6 A

# %% [code]
image = cv2.imread('chess2.jpg')
image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

# Original Img
plt.figure(figsize=(20, 20))
plt.subplot(2, 2, 1)
plt.title("Original")
plt.imshow(image)

# Rotation Img
# when 180 --> cv2.RORATE_180, 270 --> cv2.ROTATE_90_COUNTERCLOCKWISE
rotate_img = cv2.rotate(image, cv2.ROTATE_90_CLOCKWISE)
plt.subplot(2,2,2)
plt.title("Image Rotation: 90d Clockwise")
plt.imshow(rotate_img)

# Translation Img.
# 10% of width, height translation.
y, x = image.shape[:2]
trans_dist_y = y//10
trans_dist_x = x//10
T = np.float32([[1, 0, trans_dist_x],[0, 1, trans_dist_y]])
translated_img = cv2.warpAffine(image, T, (x, y))

plt.subplot(2, 2, 3)
plt.title("Translated")
plt.imshow(translated_img)

# Scaled Img
scale = 2 # integer value of scale 
new_y = int(image.shape[0] * scale)
new_x = int(image.shape[1] * scale)

new_dimension = (new_x, new_y)
scaled_img = cv2.resize(image, new_dimension, interpolation = cv2.INTER_LINEAR)

plt.subplot(2, 2, 4)
plt.title("Scaled: 2X")
plt.imshow(scaled_img)

plt.show()

# %% [code]
# Making images grayscale (Harris corner detector uses gray colored image)
# From original img
image_gray = cv2.cvtColor(image,cv2.COLOR_RGB2GRAY)
image_gray = np.float32(image_gray)

# From rotation img
rotation_img_gray = cv2.cvtColor(rotate_img,cv2.COLOR_RGB2GRAY)
rotation_img_gray = np.float32(rotation_img_gray)

# From translation img
translation_img_gray = cv2.cvtColor(translated_img, cv2.COLOR_RGB2GRAY)
translation_img_gray = np.float32(translation_img_gray)

# From scaled img
scaling_img_gray = cv2.cvtColor(scaled_img,cv2.COLOR_RGB2GRAY)
scaling_img_gray = np.float32(scaling_img_gray)

# Plotting preparation
plt.figure(figsize=(20, 20))
plt.subplot(2, 2, 1)
plt.title("Gray from Original")
plt.imshow(image_gray, cmap='gray')

plt.subplot(2,2,2)
plt.title("Gray from Rotation")
plt.imshow(rotation_img_gray, cmap='gray')

plt.subplot(2,2,3)
plt.title("Gray from Translation")
plt.imshow(translation_img_gray, cmap='gray')

plt.subplot(2,2,4)
plt.title("Gray from Scale")
plt.imshow(scaling_img_gray, cmap='gray')

plt.show()

# %% [code]
# Harris corner detector parameters
neighbor_size = 2
aperture = 3
k_value = 0.04
threshold = 0.01

dest_original = cv2.cornerHarris(image_gray,neighbor_size,aperture,k_value)
dest_rotation = cv2.cornerHarris(rotation_img_gray,neighbor_size,aperture,k_value)
dest_translation = cv2.cornerHarris(translation_img_gray,neighbor_size,aperture,k_value)
dest_scaling = cv2.cornerHarris(scaling_img_gray,neighbor_size,aperture,k_value)


# Results are marked through the dilated corners 
dest_original = cv2.dilate(dest_original, None)
dest_rotation = cv2.dilate(dest_rotation, None)
dest_translation = cv2.dilate(dest_translation, None)
dest_scaling = cv2.dilate(dest_scaling, None)

# Assign images to show coners detected
image_h = image
rotate_img_h = rotate_img
translated_img_h = translated_img
scaled_img_h = scaled_img


# Reverting back to the original image, 
# with optimal threshold value 
image_h[dest_original > threshold * dest_original.max()]=[255, 0, 0]
rotate_img_h[dest_rotation > threshold * dest_rotation.max()]=[255, 0, 0]
translated_img_h[dest_translation > threshold * dest_translation.max()]=[255, 0, 0]
scaled_img_h[dest_scaling > threshold * dest_scaling.max()]=[255, 0, 0]

# Plotting preparation
plt.figure(figsize=(20, 20))
plt.subplot(2, 2, 1)
plt.title("Harris Corner Detection from Original")
plt.imshow(image_h)

plt.subplot(2,2,2)
plt.title("Harris Corner Detection from Rotation")
plt.imshow(rotate_img_h)

plt.subplot(2,2,3)
plt.title("Harris Corner Detection from Translation")
plt.imshow(translated_img_h)

plt.subplot(2,2,4)
plt.title("Harris Corner Detection from Scale")
plt.imshow(scaled_img_h)

plt.show()

# %% [markdown]
# # Q6 B

# %% [code]
# Create brighter and darker images
constant = 70
unitarray = np.ones(image.shape, dtype = image.dtype) 
image_brighter = cv2.add(image,constant*unitarray)
image_darker = cv2.subtract(image, constant*unitarray)

# Create our shapening kernels.
# positive offset = 2, smoothing by mean filter.
case_1 = 3
case_2 = 5
sharpening_1 = np.array([[0,0,0], [0,2,0], [0,0,0]]) - 1/(case_1**2)*np.ones((case_1,case_1))
sharpening_2 = np.array([[0,0,0,0,0], [0,0,0,0,0], [0,0,2,0,0], [0,0,0,0,0], [0,0,0,0,0]]) - 1/(case_2**2)*np.ones((case_2,case_2))

# applying different kernels to the input image
# When ddepth = -1, the output image will have the same depth as the source
sharpened_1 = cv2.filter2D(image, -1, sharpening_1)
sharpened_2 = cv2.filter2D(image, -1, sharpening_2)


# Plotting preparation
plt.figure(figsize=(20, 20))
plt.subplot(2, 3, 1)
plt.title("Original")
plt.imshow(image)

plt.subplot(2,3,2)
plt.title("Brighter")
plt.imshow(image_brighter)

plt.subplot(2,3,3)
plt.title("Darker")
plt.imshow(image_darker)

plt.subplot(2,3,4)
plt.title("Sharpened: 3x3 kernel")
plt.imshow(sharpened_1)

plt.subplot(2,3,5)
plt.title("Sharpened: 5x5 kernel")
plt.imshow(sharpened_2)

plt.show()

# %% [code]
# After converting Gray, then apply Harris

# Making images grayscale (Harris corner detector uses gray colored image)
# From brighter img
brighter_image_gray = cv2.cvtColor(image_brighter,cv2.COLOR_RGB2GRAY)
brighter_image_gray = np.float32(brighter_image_gray)

# From darker img
darker_img_gray = cv2.cvtColor(image_darker,cv2.COLOR_RGB2GRAY)
darker_img_gray = np.float32(darker_img_gray)

# From sharpening 3x3 img
sharpened_1_img_gray = cv2.cvtColor(sharpened_1, cv2.COLOR_RGB2GRAY)
sharpened_1_img_gray = np.float32(sharpened_1_img_gray)

# From sharpening 5x5
sharpened_2_img_gray = cv2.cvtColor(sharpened_2,cv2.COLOR_RGB2GRAY)
sharpened_2_img_gray = np.float32(sharpened_2_img_gray)

# Making gray: finished.

# Harris corner detector parameters
neighbor_size = 2
aperture = 3
k_value = 0.04
threshold = 0.01

dest_brighter = cv2.cornerHarris(brighter_image_gray,neighbor_size,aperture,k_value)
dest_darker = cv2.cornerHarris(darker_img_gray,neighbor_size,aperture,k_value)
dest_sharpened_1 = cv2.cornerHarris(sharpened_1_img_gray,neighbor_size,aperture,k_value)
dest_sharpened_2 = cv2.cornerHarris(sharpened_2_img_gray,neighbor_size,aperture,k_value)


# Results are marked through the dilated corners 
dest_brighter = cv2.dilate(dest_brighter, None)
dest_darker = cv2.dilate(dest_darker, None)
dest_sharpened_1 = cv2.dilate(dest_sharpened_1, None)
dest_sharpened_2 = cv2.dilate(dest_sharpened_2, None)

# Assign images to show coners detected
brighter_img_h = image_brighter
darker_img_h = image_darker
sharpened_1_img_h = sharpened_1
sharpened_2_img_h = sharpened_2


# Reverting back to the original image, 
# with optimal threshold value 
# image_h[dest_original > threshold * dest_original.max()]=[255, 0, 0]
brighter_img_h[dest_brighter > threshold * dest_brighter.max()]=[255, 0, 0]
darker_img_h[dest_darker > threshold * dest_darker.max()]=[255, 0, 0]
sharpened_1_img_h[dest_sharpened_1 > threshold * dest_sharpened_1.max()]=[255, 0, 0]
sharpened_2_img_h[dest_sharpened_2 > threshold * dest_sharpened_2.max()]=[255, 0, 0]

# Plotting preparation
plt.figure(figsize=(20, 20))
plt.subplot(2, 3, 1)
plt.title("Harris Corner Detection from Original")
plt.imshow(image_h)

plt.subplot(2,3,2)
plt.title("Harris Corner Detection from Brighter")
plt.imshow(brighter_img_h)

plt.subplot(2,3,3)
plt.title("Harris Corner Detection from Darker")
plt.imshow(darker_img_h)

plt.subplot(2,3,4)
plt.title("Harris Corner Detection from Sharpen: 3x3")
plt.imshow(sharpened_1_img_h)

plt.subplot(2,3,5)
plt.title("Harris Corner Detection from Sharpen: 5x5")
plt.imshow(sharpened_2_img_h)


plt.show()

# %% [markdown]
# # Q6 C

# %% [code]
# Creating image having white squire in the center with black background.

background = np.zeros((100,100,3), dtype = image.dtype)
# print(background.dtype)
white_square = 255* np.ones((background.shape[0]//3, background.shape[1]//3, background.shape[2]), dtype=background.dtype)

C_img = background
C_img[C_img.shape[0]//3:C_img.shape[0]//3*2, C_img.shape[1]//3:C_img.shape[1]//3*2, :] = white_square


def gaussian_noise(image, sigma):
    row,col,ch= image.shape
    mean = 0
    gaussian_distribution = np.random.normal(mean,sigma,(row,col,ch))
    gaussian_noise = gaussian_distribution.reshape(row,col,ch)
    combination = image + gaussian_noise
    
    return combination.astype('uint8')

C_img_g1 = gaussian_noise(C_img, 0.1)
C_img_g2 = gaussian_noise(C_img, 0.5)
C_img_g3 = gaussian_noise(C_img, 1)

# print(C_img_g1.shape, C_img_g1.size, C_img_g1.dtype)

# Plotting preparation
plt.figure(figsize=(20, 20))
plt.subplot(2, 2, 1)
plt.title("Original Black and White")
plt.imshow(C_img)

plt.subplot(2,2,2)
plt.title("Add to original: Gaussian noise (sigma=0.1)")
plt.imshow(C_img_g1)

plt.subplot(2,2,3)
plt.title("Add to original: Gaussian noise (sigma=0.5)")
plt.imshow(C_img_g2)

plt.subplot(2,2,4)
plt.title("Add to original: Gaussian noise (sigma=1)")
plt.imshow(C_img_g3)


plt.show()

# %% [code]
# After converting Gray, then apply Harris


neighbor_size = 2
aperture = 3
k_value = 0.04
threshold = 0.1

def count_invalid(corners):
    from math import sqrt
    expected_corners = [ \
        [33, 33], \
        [33, 66], \
        [66, 33], \
        [66, 66] \
    ]
    num_expected = len(expected_corners)
    allowance = 2 # Allow corner to be within 2 units of the expected
    i = 0
    valid = 0
    while i < len(corners):
        corner = corners[i]
        for expected in expected_corners:
            if sqrt((expected[0]-corner[0])**2+(expected[1]-corner[1])**2) < allowance: # We have a match
                valid += 1
                expected_corners.remove(expected)
                break
        i += 1
    return max(num_expected, len(corners)) - valid

def rms(corners):
    from math import sqrt
    expected_corners = [ \
        [33, 33], \
        [33, 66], \
        [66, 33], \
        [66, 66] \
    ]
    sum = 0
    for corner in corners:
        # Find nearest expected corner
        min_distance = 1000000000000000000
        for expected in expected_corners:
            distance = (expected[0]-corner[0])**2+(expected[1]-corner[1])**2
            min_distance = min(min_distance, distance)
        sum += min_distance
    return sqrt(sum / len(expected_corners))

sigma_values = []
rms_values = []
def gray_harris(filename, sigma, neighbor_size, aperture, k_value, threshold):
    # Making images grayscale (Harris corner detector uses gray colored image)
    img_gray = cv2.cvtColor(filename, cv2.COLOR_RGB2GRAY)
    img_gray = np.float32(img_gray)
    # Making gray: finished.

    # Harris corner detector parameters
    dest_img = cv2.cornerHarris(img_gray,neighbor_size,aperture,k_value)
    # Results are marked through the dilated corners 
    dest_img = cv2.dilate(dest_img, None)

    # Assign images to show coners detected
    temp = filename

    # Reverting back to the original image, 
    # with optimal threshold value 
    #temp[dest_img> threshold * dest_img.max()]=[255, 0, 0]

    # Threshold the image and convert to uint8
    ret, dst = cv2.threshold(dest_img,threshold*dest_img.max(),255,0)
    dst = np.uint8(dst)

    # Find centroids of detected corner areas
    ret, labels, stats, centroids = cv2.connectedComponentsWithStats(dst)

    # Filter out centroids that have extremely high areas because they aren't relevant to corners
    relevant_centroids = []
    for centroid,stat in zip(centroids, stats):
        if stat[4] < 100: # Setting the threshold for area of corner to be 100 since most corners are closer to 10-20 pixels in area at most
            relevant_centroids.append(centroid)
    centroids = np.asarray(relevant_centroids)

    # Find corners based on additional search criteria
    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 100, 0.001)
    corners = cv2.cornerSubPix(img_gray,np.float32(centroids),(1,1),(-1,-1),criteria)

    # Set corners in image to be red
    res = np.hstack((centroids,corners))
    res = np.int0(res)
    temp[res[:,1],res[:,0]]=[255,0,0]

    print("Number of Missing / Incorrectly Detected Corners (sigma=" + str(sigma) + "): " + str(count_invalid(corners)))
    rms_values.append(rms(corners))
    sigma_values.append(sigma)

    return temp
    
img_C_h = gray_harris(C_img, 0, neighbor_size, aperture, k_value, threshold)
img_C_g1_h = gray_harris(C_img_g1, 0.1, neighbor_size, aperture, k_value, threshold)
img_C_g2_h = gray_harris(C_img_g2, 0.5, neighbor_size, aperture, k_value, threshold)
img_C_g3_h = gray_harris(C_img_g3, 1, neighbor_size, aperture, k_value, threshold)

# Plotting preparation
plt.figure(figsize=(20, 20))
plt.subplot(2, 2, 1)
plt.title("Original Black and white")
plt.imshow(img_C_h)

plt.subplot(2,2,2)
plt.title("Original Black and white + gaussian noise(sigma=0.1)")
plt.imshow(img_C_g1_h)

plt.subplot(2,2,3)
plt.title("Original Black and white + gaussian noise(sigma=0.5)")
plt.imshow(img_C_g2_h)

plt.subplot(2,2,4)
plt.title("Original Black and white + gaussian noise(sigma=1)")
plt.imshow(img_C_g3_h)


plt.show()

# Sigma vs. RMS
plt.plot(sigma_values, rms_values)
plt.xlabel('sigma', fontsize=12)
plt.ylabel('RMS', fontsize=12)
plt.title("Sigma vs. RMS")
plt.show()

# %%
