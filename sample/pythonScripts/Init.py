import os
import RunJar
from Input import Input
import subprocess
from sys import argv, version

is_py2 = version[0] == '2'
if is_py2:
    import Queue as qu
else:
    import queue as qu

if __name__ == '__main__':


    # directories definitions
    dir_path = os.path.dirname(os.path.realpath(__file__))
    java_file_dir = os.path.join(dir_path,"..","JarFiles","src")
    lib_path = os.path.join(dir_path,"..","JarFiles","libs")
    log_path = os.path.join(dir_path,"..","JarFiles","resources","logs",)
    jarFiles = [f for f in os.listdir(lib_path) if os.path.isfile(os.path.join(lib_path, f)) and not f.startswith('.')]
    libraryString = ""
    for x in jarFiles:
        libraryString = libraryString + os.path.join(lib_path, x) + ":"




    #get number of threads (default value is 5):
    maximum_number_of_threads =  int(argv[1]) if len(argv) == 2 else 5



    #initializing logReader
    logReader = RunJar.LogReader()


    #get inputs from csv
    input_fetcher = Input()
    runs_configs = input_fetcher.fetchInputs()
    number_of_runs = len(runs_configs)
    print ("number of runs: "+ str(number_of_runs))

    # Define a queue. all of the runs will be stored in it
    queue = qu.Queue()



    #Compiling Run.java (this file calls a new instance of EvoCrash)
    subprocess.check_call(
        ['javac', '-cp', libraryString, os.path.join(java_file_dir, "Run.java")])
    print ("Compiling is finished")

    #add all of the runs to the Queue
    for currentRun in runs_configs:
        # Get vali frames from log files
        validFrames = logReader.getValidFrameLevels(
        os.path.join(log_path, currentRun["application"].upper(), currentRun["case"].strip(),
        currentRun["case"].strip() + ".log"), currentRun["package"])
        currentRun["getExceptionName"] = logReader.getExceptionName()
        currentRun["all_frames_count"] = logReader.getAllFramesCount()
        currentRun["project_frames_count"] = logReader.getProjectFramesCount()
        for frame in validFrames:
            currentRun["frame"] = frame
            queue.put(currentRun.copy())

    #Create observer Thread
    observerThread = RunJar.Observer(maximum_number_of_threads)
    observerThread.start()


    #Starting threads
    index = 0
    threads = []
    for OneOf in range(maximum_number_of_threads):
        thread = RunJar.RunJar(name=str(index + 1),java_file_dir=java_file_dir,libraryString=libraryString,theQueue=queue,observerThread=observerThread)
        thread.start()
        threads.append(thread)
        index+=1
    try:
        for index, i in enumerate(threads):
            print ("waiting for Thread # " + str(index+1))
            i.join()
    except Exception as exc:
        print (exc)

