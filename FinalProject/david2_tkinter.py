import tkinter as tk
from tkinter import ttk
import tkinter.filedialog as fd
import os
import shutil

class finalProject:
    def __init__(self):
        # Variables
        self.filesToBeProcessed = []            # List of string
        self.sourceDirectory = ""               # String
        self.initialfolder = "/Volumes/extSSD/02_Classes/20_CSCI 5722 Computer Vision/HWs/csci5722s21/FinalProject/"
        self.targetobject = ""
        self.filesAfterProcessed = []
        self.targetDirectory = ""
        self.copyprogress = ""
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

    def detectionObject(self) -> list:

        print("detectionObject")
        print("self.objectvar", self.objectvar.get())

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

    def nearDuplicate():
        print("NEAR DUPLICATE FUNCTION")


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