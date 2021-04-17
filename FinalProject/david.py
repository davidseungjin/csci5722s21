import tkinter as tk
import tkinter.filedialog as fd
import os
import cv2 as cv
import matplotlib.pylab as plt
import numpy as np
import pandas as pd
# import tensorflow as tf

def opening_files(root) -> tuple:
    # Tkinter object creation to handle files selection, directory selection.
    testFolderForSorting = '/Volumes/extSSD/02_Classes/20_CSCI 5722 Computer Vision/HWs/csci5722s21/finalproject/photosorter_images'
    testFolderForfiles = '/Volumes/extSSD/02_Classes/20_CSCI 5722 Computer Vision/HWs/csci5722s21/finalproject/photosorter_images'

    # When file(s) opening
    files = fd.askopenfilenames(initialdir = testFolderForfiles, title='Choose a file')
    myfiles = root.tk.splitlist(files)

    for file in myfiles:
        print(file)    
    return myfiles


def opening_dir(testFolderForSorting) -> list:
    # When directory selection.
    # It processes each files in the directory to create file path string and store in a list.

    dirs = fd.askdirectory(initialdir = testFolderForSorting, title = 'Choose a directory')
    files_in_dir = []
    for files in os.listdir(dirs):
        files_in_dir.append(os.path.join(dirs, files))

    for elem in files_in_dir:
        print(elem)
    return files_in_dir


def yolo_initiation(yoloweights, yolo_cfg):
    net = cv.dnn.readNet(yoloweights, yolo_cfg)

    layer_names = net.getLayerNames()
    outputlayers = [layer_names[i[0] - 1] for i in net.getUnconnectedOutLayers()]

    return net, outputlayers


def loading_img(file):
    # Loading image
    img = cv.imread(file)
    img = cv.resize(img, None, fx=0.2, fy=0.2)
    
    return img

def yolo_blob(img):
    # Detecting objects
    # blob = cv.dnn.blobFromImage(img, 0.004, (img.shape[1], img.shape[0]), (0,0,0), True, crop=False)
    # The model has been trained for different sizes of images: 320 x 320 (high speed, less accuracy), 416 x 416 (moderate speed, moderate accuracy) and 608 x 608 (less speed, high accuracy)
    # https://towardsdatascience.com/object-detection-using-yolov3-and-opencv-19ee0792a420
    blob = cv.dnn.blobFromImage(img, 0.00392, (608,608), (0,0,0), True, crop=False)
    # print(blob.shape)
    return blob

def misc_blob_check(blob):
    for b in blob:
        for n, img_b in enumerate(b):
            cv.imshow(str(n), img_b)


def output(net, blob, outputlayers):
    net.setInput(blob)
    outs = net.forward(outputlayers)
    # print(outs)
    return outs

def nms_result(outs, img, myfile) -> None:
    '''
    After detecting objects from img using outs layers already pre-trained
    it updates global variable mydict declared in main function
    format I design is 
    {'people': [file A, file B], 'chair': [file A, file C]} ...
    '''
    height, width, _ = img.shape
    class_ids = []
    confidences = []
    boxes = []

    for out in outs:
        for detection in out:
            scores = detection[5:]
            class_id = np.argmax(scores)
            confidence = float(scores[class_id])
            if confidence > 0.3:
                # Object detected
                center_x = int(detection[0] * width)
                center_y = int(detection[1] * height)
                w = int(detection[2] * width)
                h = int(detection[3] * height)

                # cv.circle(img, (center_x, center_y), 20, (0,0,255), 2)
                # Rectangle coordinates
                x = int(center_x - w // 2)
                y = int(center_y - h // 2)

                boxes.append([x,y,w,h])
                confidences.append(confidence)
                class_ids.append(class_id)
                # cv.rectangle(img, (x, y), (x + w, y + h), (0,0,255), 2)

    # Non maxima suppression
    # print(boxes, confidences)
    # If nothing captured belongs to coco.names class, then throw error "out of index"
    if confidences:
        print(len(confidences), type(confidences))
    else:
        print("No entries in the list confidences")

    # Boxes value should be int, and confidences values should be float, not np.float.
    indexes = cv.dnn.NMSBoxes(boxes, confidences, 0.3, 0.3)
    
    for i in indexes:
        i = i[0]            # it's because indexes are list of list. components are [int]
        # If mydict has the object key already, then secondly check mydict[object] has file key
        # If it meet these two condition, then increase value 1 otherwise create file: 0 as key/value pair of
        # mydict[object]
        # If there is no object key in mydict, create mydict[object] = {file : 0}
        if classes[class_ids[i]] in mydict.keys():
            if myfile in mydict[classes[class_ids[i]]].keys():
                mydict[classes[class_ids[i]]][myfile] += 1
            else:
                mydict[classes[class_ids[i]]][myfile] =1
        else:
            mydict[classes[class_ids[i]]] = {myfile:1}
    '''
    This below is for visualizing into img and show. For Final project, it's not the scope.
    '''
    # for i in range(len(boxes)):
    #     if i in indexes:
    #         x, y, w, h = boxes[i]
    #         label = classes[class_ids[i]]
    #         # print(type(label))
    #         cv.rectangle(img, (x,y), (x+w, y+h), (0,0,255),2)
    #         cv.putText(img, label, (x, y-h//2+20), cv.FONT_HERSHEY_PLAIN, 1, (0,0,255),2)

    # cv.imshow("Image", img)
    # cv.waitKey(0)
    # cv.destroyAllWindows()
    

if __name__ == '__main__':
    # tkinter object creation
    root = tk.Tk()
    root.withdraw()
    
    # Declare and initialize sorting result according to query
    mydict = dict()

    # Opening files test
    myfiles = opening_files(root)
    # print(myfiles, type(myfiles))

    # Opening dir test
    # myfiles = opening_dir("/Volumes/extSSD/02_Classes/20_CSCI 5722 Computer Vision/HWs/csci5722s21/FinalProject/")
    # print(myfiles, type(myfiles))

    basepath = "/Volumes/extSSD/02_Classes/20_CSCI 5722 Computer Vision/HWs/csci5722s21/FinalProject/"
    yoloweights = basepath + "yolo/yolov3.weights"
    yolo_cfg = basepath + "yolo/yolov3_training.cfg"
    coconames = basepath + "yolo/classes.names"

    # yoloweights= basepath + "yolo/yolov3.weights"
    # yolo_cfg = basepath + "yolo/yolov3.cfg"
    # coconames = basepath + "yolo/coco.names"
    with open(coconames, "r") as f:
        classes = [line.strip() for line in f.readlines()]

    
    net, outputlayers = yolo_initiation(yoloweights, yolo_cfg)
    
    for myfile in myfiles:
    # myfile = myfiles[0]
        img = loading_img(myfile)
        blob = yolo_blob(img)
        outs = output(net, blob, outputlayers)
        nms_result(outs, img, myfile)

    # Check result
    for k1, v1 in mydict.items():
        for k2, v2 in v1.items():
            print("Item {}: File {} contains {}".format(k1, k2, v2))
    