import tkinter as tk
from tkinter import ttk
import tkinter.filedialog as fd
import os
import shutil
import cv2 as cv
import numpy as np

class finalProject:
    def __init__(self):
        # Variables
        self.filesToBeProcessed = []            # List of string
        self.sourceDirectory = ""               # String
        self.initialfolder = "/Volumes/extSSD/02_Classes/20_CSCI 5722 Computer Vision/HWs/csci5722s21/FinalProject/"
        self.targetobject = ""
        self.processedDict = {}
        self.filesAfterProcessed = []
        self.targetDirectory = ""
        self.copyprogress = ""
        
        
        self.yoloweights = self.initialfolder + "yolo/yolov3.weights"
        self.yolo_cfg = self.initialfolder + "yolo/yolov3_training.cfg"
        self.coconames = self.initialfolder + "yolo/classes.names"
        with open(self.coconames, "r") as f:
            self.classes = [line.strip() for line in f.readlines()]
        
        self.myCNNnetwork = ""          # will be assigned by the function yolo_initiation
        # print("self.myCNNnetwork is ", self.myCNNnetwork)
        self.outputlayers = ""          # will be assigned by the function yolo_initiation
        self.blob = ""                  # will be assigned by the function yolo_blob(self, img)
        self.outs = ""                  # will be assigned by the function output
        
        self.myGUI()

    def myGUI(self):
        # Tkinter Part
        self.root = tk.Tk()
        self.root.title("CSCI5722 FinalProject")

        self.overview = tk.LabelFrame(self.root, text = "Instruction")
        self.overview.pack(fill="both", expand="yes", padx=10, pady=10)
        label1 = ttk.Label(self.overview, text="Step1: select files or folder").pack()
        label2 = ttk.Label(self.overview, text="Step2: select target object").pack()
        label3 = ttk.Label(self.overview, text="Step3: assign target folder").pack()

        self.first_frame = tk.LabelFrame(self.root, text = "Step1: Opening files")
        self.first_frame.pack(fill="both", expand="yes", padx=10, pady=10)
        openingfiles = ttk.Button(self.first_frame, text="Files", command= lambda: self.opening_files()).pack()
        openingfolder = ttk.Button(self.first_frame, text="Folder", command= lambda: self.opening_dir()).pack()


        self.second_frame = tk.LabelFrame(self.root, text = "Step2-1: Near-Duplicate")
        self.second_frame.pack(fill="both", expand="yes", padx=10, pady=10)
        ttk.Button(self.second_frame, text="Detect: Near-Duplicate", command = lambda: self.nearDuplicate()).pack()


        self.third_frame = tk.LabelFrame(self.root, text = "Step2-2: Detect Objects")
        self.third_frame.pack(fill="both", expand="yes", padx=10, pady=10)
        self.objectvar = tk.StringVar()
        # self.objectvar = objectvar.get()
        tk.Radiobutton(self.third_frame, text="Person", variable = self.objectvar, value = "Person").pack()
        tk.Radiobutton(self.third_frame, text="Car", variable = self.objectvar, value = "Car").pack()
        tk.Radiobutton(self.third_frame, text="Flower", variable = self.objectvar, value = "Flower").pack()
        tk.Radiobutton(self.third_frame, text="Tree", variable = self.objectvar, value = "Tree").pack()
        tk.Radiobutton(self.third_frame, text="Scene", variable = self.objectvar, value = "Scene").pack()
        detection = ttk.Button(self.third_frame, text="Execute detection", command= lambda: self.detectionObject()).pack()

        # bottom_frame = tk.Frame(self.root).pack()
        self.fourth_frame = tk.LabelFrame(self.root, text = "Step3: assign a folder to copy the sorted photos")
        self.fourth_frame.pack(fill="both", expand="yes", padx=10, pady=10)
        openingfolder2 = tk.Button(self.fourth_frame, text="Folder", command = lambda: self.assign_dir()).pack()

        # myentry = tk.Label(self.fourth_frame, bd = 5).pack()
        label8 = tk.Label(self.fourth_frame, text="files will be copied to the folder assigned").pack()
        copytofolder = tk.Button(self.fourth_frame, text="Copy", command = lambda: self.copytofolder()).pack()
        self.label9 = tk.Label(self.fourth_frame, text=self.copyprogress).pack()
        
        
        self.quit_frame = tk.LabelFrame(self.root, text = "Quit Program")
        self.quit_frame.pack(fill="both", expand="yes", padx=10, pady=10)
        label10 = tk.Button(self.quit_frame, text="Quit", command=quit).pack()
        
        self.root.mainloop()

    def opening_files(self) -> list:
        # Tkinter object creation to handle files selection, directory selection.
        self.filesToBeProcessed = list(fd.askopenfilenames(initialdir = self.initialfolder, title='Choose a file'))

        print("myfiles = ", self.filesToBeProcessed, type(self.filesToBeProcessed))
        

    def opening_dir(self) -> list:
        # When directory selection.
        
        self.sourceDirectory = fd.askdirectory(initialdir = self.initialfolder, title = 'Choose a directory')
        self.filesToBeProcessed = [os.path.join(self.sourceDirectory, files) for files in os.listdir(self.sourceDirectory) if os.path.isfile(os.path.join(self.sourceDirectory, files)) ]

        print("dourceDirectory, filesToBeProcessed are", self.sourceDirectory, self.filesToBeProcessed)
        print("len of files are ", len(self.filesToBeProcessed))

    def nearDuplicate():
        print("NEAR DUPLICATE FUNCTION")

    def detectionObject(self) -> list:

        print("detectionObject. detection function start")
        self.detection()
        print("self.processedDict in function detectionObject\n\n", self.processedDict)
        print("self.objectvar", self.objectvar.get())
        print("self.filesAfterProcessed in function detectionObject\n\n", self.filesAfterProcessed)
        

    def assign_dir(self) -> None:
        # When directory selection.
        # It processes each files in the directory to create file path string and store in a list.

        self.targetDirectory = fd.askdirectory(initialdir = self.initialfolder, title = 'Choose a directory')
        print("directory selected is ", self.targetDirectory, type(self.targetDirectory))

    def copytofolder(self):
        # files = [os.path.split(myfile)[1] for myfile in self.filesAfterProcessed]          # if index 0, then it is the path of file
        # files = [os.path.split(myfile)[1] for myfile in self.filesToBeProcessed]
        for elem in self.filesToBeProcessed:
            print("sct, dst ", elem, os.path.join(self.targetDirectory, os.path.split(elem)[1]))
            shutil.copyfile(elem, os.path.join(self.targetDirectory, os.path.split(elem)[1]))
        # self.copyprogress = "Copy completed" <-- How to update text of Label from "" to "Copy completed" OR "Copy started" -> "Copy completed"

    


    def yolo_initiation(self):
        print("yolo_initiation function called")
        # yoloweights = self.yoloweights
        # yolo_cfg = self.yolo_cfg
        self.myCNNnetwork = cv.dnn.readNet(self.yoloweights, self.yolo_cfg)

        layer_names = self.myCNNnetwork.getLayerNames()
        self.outputlayers = [layer_names[i[0] - 1] for i in self.myCNNnetwork.getUnconnectedOutLayers()]
        print("yolo_initiation function finished")
        print("myCNNnetwork and outputlayers are", self.myCNNnetwork, self.outputlayers)


    def loading_img(self, file):
        # Loading image
        img = cv.imread(file)
        img = cv.resize(img, None, fx=0.2, fy=0.2) 
        return img

    def yolo_blob(self, img):
        # Detecting objects
        # blob = cv.dnn.blobFromImage(img, 0.004, (img.shape[1], img.shape[0]), (0,0,0), True, crop=False)
        # The model has been trained for different sizes of images: 320 x 320 (high speed, less accuracy), 416 x 416 (moderate speed, moderate accuracy) and 608 x 608 (less speed, high accuracy)
        # https://towardsdatascience.com/object-detection-using-yolov3-and-opencv-19ee0792a420
        self.blob = cv.dnn.blobFromImage(img, 0.00392, (608,608), (0,0,0), True, crop=False)        

    def misc_blob_check(self):
        for b in self.blob:
            for n, img_b in enumerate(b):
                cv.imshow(str(n), img_b)

    def output(self):
        self.myCNNnetwork.setInput(self.blob)
        self.outs = self.myCNNnetwork.forward(self.outputlayers)
        print("self.outs in output func is ", self.outs)

    def detection(self):
        self.yolo_initiation()
        print("fileToBeProcessed is ", self.filesToBeProcessed)
        for myfile in self.filesToBeProcessed:
            # myfile = myfiles[0]
            print(myfile)
            img = self.loading_img(myfile)
            self.yolo_blob(img)
            self.output()
            self.nms_result(img, myfile)

    def nms_result(self, img, myfile) -> None:
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

        for out in self.outs:
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
        if confidences:
            print(len(confidences), type(confidences))
        else:
            print("No object captured with this confidence condition")

        # Boxes value should be int, and confidences values should be float, not np.float.
        indexes = cv.dnn.NMSBoxes(boxes, confidences, 0.3, 0.3)
        
        for i in indexes:
            i = i[0]            # it's because indexes are list of list. components are [int]
            # If mydict has the object key already, then secondly check mydict[object] has file key
            # If it meet these two condition, then increase value 1 otherwise create file: 0 as key/value pair of
            # mydict[object]
            # If there is no object key in mydict, create mydict[object] = {file : 0}
            if self.classes[class_ids[i]] in self.processedDict.keys():
                if myfile in self.processedDict[self.classes[class_ids[i]]].keys():
                    self.processedDict[self.classes[class_ids[i]]][myfile] += 1
                else:
                    self.processedDict[self.classes[class_ids[i]]][myfile] =1
            else:
                self.processedDict[self.classes[class_ids[i]]] = {myfile:1}
        
        for k1, v1 in self.processedDict.items():
            for k2, v2 in v1.items():
                print("Item {}: File {} contains {}".format(k1, k2, v2))
        
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
    
    a = finalProject()
    

    # Declare and initialize sorting result according to query
    # mydict = dict()

    # Opening files test
    # myfiles = opening_files(root)
    # print(myfiles, type(myfiles))

    # Opening dir test
    # myfiles = opening_dir("/Volumes/extSSD/02_Classes/20_CSCI 5722 Computer Vision/HWs/csci5722s21/FinalProject/")
    # print(myfiles, type(myfiles))