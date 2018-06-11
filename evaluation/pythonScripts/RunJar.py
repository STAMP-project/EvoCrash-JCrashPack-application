import json
from os import path,chdir, makedirs
from subprocess import PIPE,Popen
import re
import fcntl
import csv
import errno
import threading
from time import time,sleep




# This class defines Observer Thread
class Observer (threading.Thread):
    list_of_threads = []
    max_time = 10*60 # if Crash Replication tool does not response for 10 minutes, the observer will stop that instance of the tool.
    def __init__(self,number_of_threads_to_observe):
        threading.Thread.__init__(self)
        for i in range(number_of_threads_to_observe):
            threadDic = {}
            threadDic["alive"]= True
            threadDic["startTime"]= None
            threadDic["lastOutput"]= None
            threadDic["process"] = None
            threadDic["configurations"]= None
            self.list_of_threads.append(threadDic)


    def observer_kill(self,process,configurations):
        print ("~~~~~~~~~~~~~~~~~~~")
        print ("Reporter #" + self.name + ":"+"The following Procces is killed by observer: ")
        print ("Case: "+configurations["case"])
        print ("frame level: "+str(configurations["frame"]))
        print ("population: "+str(configurations["population"]))
        print ("~~~~~~~~~~~~~~~~~~~")
        process.terminate() # the process and its children will be terminated

    def run(self):
        while True:
            killme = True
            for th in self.list_of_threads:
                if th["alive"]:
                    killme = False
                    break

            if killme:
                break

            for index,th in enumerate(self.list_of_threads):
                if th["startTime"] is not None:
                    timepassed = time() - th["startTime"]
                    if timepassed >= self.max_time:
                        self.observer_kill(th["process"],th["configurations"])
                        self.process_is_finished(index + 1)

            sleep(10)

    def start_process(self,id,process,configurations):
        index= id - 1
        self.list_of_threads[index]["alive"] = True
        self.list_of_threads[index]["startTime"] = time()
        self.list_of_threads[index]["lastOutput"] = time()
        self.list_of_threads[index]["process"] = process
        self.list_of_threads[index]["configurations"] = configurations

    def new_output(self,id):
        index = id - 1
        self.list_of_threads[index]["lastOutput"] = time()

    def process_is_finished(self,id):
        index = id - 1
        self.list_of_threads[index]["startTime"] = None
        self.list_of_threads[index]["lastOutput"] = None
        self.list_of_threads[index]["process"] = None
        self.list_of_threads[index]["configurations"] = None

    def finishing_thread(self,id):
        index = id - 1
        self.list_of_threads[index]["alive"] = False
        self.process_is_finished(id)









# each thread call Run.java
#   1- read data from th shared Queue
#   2-
class RunJar(threading.Thread):


    def __init__(self, name, java_file_dir, libraryString, theQueue=None, observerThread=None):
        threading.Thread.__init__(self)
        self.theQueue = theQueue
        self.java_file_dir = java_file_dir
        self.name = name
        self.libraryString = libraryString
        self.observerThread = observerThread

        print ("Thread #" + name + " is created.")
    # if achieved to computation finished, stop the process and its threads.
    def kill_for_threshold(self,process,configurations):
        print ("*******************")
        print ("Reporter #" + self.name + ":" + "The following Procces is pass threshold: ")
        print ("Case: " + configurations["case"])
        print ("frame level: " + str(configurations["frame"]))
        print ("population: " + str(configurations["population"]))
        print ("final fitness function should not be empty!")
        print ("*******************")
        process.terminate()

    def run(self):
        # go to java files directory
        chdir(self.java_file_dir)

        while not self.theQueue.empty():
            csv_result = {}
            configurations = self.theQueue.get()
            self.theQueue.task_done()
            conf_str = json.dumps(configurations)
            cmd = ['java','-Xmx4000m' ,'-cp', self.libraryString, "Run", conf_str]
            popen = Popen(cmd, stdout=PIPE, stderr=PIPE,universal_newlines=True)
            csv_result["is_protected/private"] = "Yes"
            self.dir_path = path.dirname(path.realpath(__file__))
            csv_result["log_path"] = path.join(self.dir_path, "outputs", "logs", configurations["case"],
                                                    "frame-" + str(configurations["frame"]),
                                                    "R"+str(configurations["execution_idx"])+"_PM"+configurations["p_functional_mocking"]+"_Mperc"+configurations["functional_mocking_percent"]+"_SB"+configurations["search_budget"]+"_POP"+configurations["population"], "out")
            #openning out log file
            filename = path.join(csv_result["log_path"], configurations["case"] + "-frame" + str(configurations["frame"]) + "-" + "out.txt")
            if not path.exists(path.dirname(filename)):
                try:
                    makedirs(path.dirname(filename))
                except OSError as exc:  # Guard against race condition
                    if exc.errno != errno.EEXIST:
                        raise

            self.observerThread.start_process(int(self.name), popen, configurations)
            try:
                error = popen.stderr
                f = open(filename, "w")
                evalIndicator=0
                for stdout_line in iter(popen.stdout.readline, ""):
                    self.observerThread.new_output(int(self.name))
                    write = True

                    if stdout_line[0:33] == "*************** New lineFitness: ":
                        splitted_line_1 = stdout_line.split(": ")
                        csv_result["line_fitness_value"] = splitted_line_1[1]
                        csv_result["line_fitness_number_of_tries"] = "between"+str(evalIndicator)+" and "+ str(evalIndicator+1000)

                    if stdout_line[0:36] == "*************** New currentFitness: ":
                        splitted_line_1 = stdout_line.split(": ")
                        csv_result["fitness_function_value"] = splitted_line_1[1]
                        csv_result["fitness_function_number_of_tries"] = "between" + str(evalIndicator) + " and " + str(evalIndicator+1000)
                    # complete csv result
                    if stdout_line[0:24] == "* number of total tries:":
                        csv_result["total_number_of_tries"] = re.sub("[^0-9]", "", stdout_line)
                    if stdout_line == "* EvoCrash: The target call is either public or protected!":
                        csv_result["is_protected/private"] = "No"
                    if stdout_line[0:42] == ">>>>>>>>>>>>>>>>>>>>>>>>>>>GGA was done in":
                        csv_result["execution_time"] = re.sub("[^0-9]", "", stdout_line)
                    if stdout_line[0:47] == "* Fitness Function/Time passed/Number of tries:":
                        splitted_line_1 = stdout_line.split(": ")
                        splitted_line_2 = splitted_line_1[1].split("/")
                        csv_result["fitness_function_value"] = splitted_line_2[0]
                        csv_result["fitness_function_time(msec)"] = splitted_line_2[1]
                        csv_result["fitness_function_number_of_tries"] = int(splitted_line_2[2])
                    if stdout_line[0:51] == "* LineCoverage Fitness/Time passed/Number of tries:":
                        splitted_line_1 = stdout_line.split(": ")
                        splitted_line_2 = splitted_line_1[1].split("/")
                        csv_result["line_fitness_value"] = splitted_line_2[0]
                        csv_result["line_fitness_time(msec)"] = splitted_line_2[1]
                        csv_result["line_fitness_number_of_tries"] = int(splitted_line_2[2])
                    if stdout_line[0:49] == "* Exception Happened/Time passed/Number of tries:":
                        splitted_line_1 = stdout_line.split(": ")
                        splitted_line_2 = splitted_line_1[1].split("/")
                        csv_result["exception_fitness_value"] = splitted_line_2[0]
                        csv_result["exception_fitness_time(msec)"] = splitted_line_2[1]
                        csv_result["exception_fitness_number_of_tries"] = int(splitted_line_2[2])
                    if stdout_line[0:53] == "* Stack Trace Similarity/Time passed/Number of tries:":
                        splitted_line_1 = stdout_line.split(": ")
                        splitted_line_2 = splitted_line_1[1].split("/")
                        csv_result["stacktrace_similarity_value"] = splitted_line_2[0]
                        csv_result["stacktrace_similarity_fitness(msec)"] = splitted_line_2[1]
                        csv_result["stacktrace_similarity_number_of_tries"] = int(splitted_line_2[2])
                    # if computation finished just break from loop
                    if stdout_line == "* Computation finished":
                        self.kill_for_threshold(popen,configurations)
                        break


                    # printing indicators
                    if stdout_line[0:21]== "* Analyzing classpath":
                        print ("Reporter #" + self.name + " _ Case "+ configurations["case"]+" _ Frame "+str(configurations["frame"])+" _ Population "+str(configurations["population"])+ ": Analyzing classpath")
                    if stdout_line[0:8] == "* Evals:":
                        fitness_eval_counter = re.sub("[^0-9]", "", stdout_line)
                        evalIndicator=int(fitness_eval_counter)
                        fitness_eval_counter = fitness_eval_counter[:-3]+"K"
                        print ("Reporter #" + self.name + " _ Case "+ configurations["case"]+" _ Frame "+str(configurations["frame"])+" _ Population "+str(configurations["population"])+ ": "+fitness_eval_counter+ " out of 125K")
                    if stdout_line[0:19] == "* New lineFitness: " or stdout_line[0:22] == "* New currentFitness: ":
                        print ("Reporter #" + self.name + " _ Case " + configurations["case"] +" _ Frame "+str(configurations["frame"])+" _ Population "+str(configurations["population"])+ ": "+stdout_line)

                     # writing in the out file if write var is true
                    if write:
                        f.write(stdout_line)

            finally:
                self.observerThread.process_is_finished(int(self.name))
                f.close()
            print ("Reporter #" + self.name + " _ Case " + configurations["case"] +" _ Frame "+str(configurations["frame"])+" _ Population "+str(configurations["population"])+": EvoCrash Execution is finished. out log file is saved.")

            csv_result["application"] = configurations["application"]
            csv_result["case"] = configurations["case"]
            csv_result["version"] = configurations["version"]
            csv_result["execution_idx"] = configurations["execution_idx"]
            csv_result["frame_level"] = str(configurations["frame"])
            csv_result["exception_name"] = configurations["getExceptionName"]
            csv_result["p_functional_mocking"] = configurations["p_functional_mocking"]
            csv_result["functional_mocking_percent"] = configurations["functional_mocking_percent"]
            csv_result["p_reflection_on_private"] = configurations["p_reflection_on_private"]
            csv_result["reflection_start_percent"] = configurations["reflection_start_percent"]
            csv_result["search_budget"] = configurations["search_budget"]
            csv_result["population"] = configurations["population"]
            #csv_result["isKilled"] = "Yes" if iskilled else "NO"
            splitted_exception = configurations["getExceptionName"].split('.')
            if (splitted_exception[0] == "java"):
                csv_result["exception_kind"] = "Java Runtime Exception"
            else:
                csv_result["exception_kind"] = "Custom Exception"
            csv_result["all_frames_count"] = str(configurations["all_frames_count"])
            csv_result["project_frames_count"] = configurations["project_frames_count"]

            self.dir_path = path.dirname(path.realpath(__file__))
            csv_result["test_case_path"] = path.join(self.dir_path,'..','JarFiles',"GGA-tests",configurations["case"],"frame-"+str(configurations["frame"]),str(configurations["execution_idx"]))
            csv_result["err_path"] = path.join(self.dir_path,"outputs","logs",configurations["case"],"frame-"+str(configurations["frame"]),"R"+str(configurations["execution_idx"])+"_PM"+configurations["p_functional_mocking"]+"_Mperc"+configurations["functional_mocking_percent"]+"_SB"+configurations["search_budget"]+"_POP"+configurations["population"],"err")
            self.save_logs(str(error),csv_result)
            print ("Reporter #" + self.name + " _ Case " + configurations["case"] + " _ Frame " + str(configurations["frame"]) + " _ Population " + str(configurations["population"]) + ": err log file is saved")
            self.write_on_csv_file(csv_result)
            print ("Reporter #" + self.name + " _ Case " + configurations["case"] + " _ Frame " + str(configurations["frame"]) + " _ Population " + str(configurations["population"]) + ": results are added to csv file")
        self.observerThread.finishing_thread(int(self.name))



    def save_logs(self,err,csv_result):
        #write err
        filename = path.join(csv_result["err_path"],csv_result["case"]+"-frame"+str(csv_result["frame_level"])+"-"+"err.txt")
        if not path.exists(path.dirname(filename)):
            try:
                makedirs(path.dirname(filename))
            except OSError as exc:  # Guard against race condition
                if exc.errno != errno.EEXIST:
                    raise
        f=open(filename,"w")
        f.write(err)
        f.close()

    def write_on_csv_file(self,csv_result):
        title_order=["application",
                     "case",
                     "version",
                     "execution_idx",
                     "exception_name",
                     "exception_kind",
                     "frame_level",
                     "all_frames_count",
                     "project_frames_count",
                     "is_protected/private",
                     "test_case_path",
                     "log_path",
                     "err_path",
                     "p_functional_mocking",
                     "functional_mocking_percent",
                     "p_reflection_on_private",
                     "reflection_start_percent",
                     "search_budget",
                     "population",
                     "line_fitness_value",
                     "line_fitness_time(msec)",
                     "line_fitness_number_of_tries",
                     "exception_fitness_value",
                     "exception_fitness_time(msec)",
                     "exception_fitness_number_of_tries",
                     "stacktrace_similarity_value",
                     "stacktrace_similarity_fitness(msec)",
                     "stacktrace_similarity_number_of_tries",
                     "fitness_function_value",
                     "fitness_function_time(msec)",
                     "fitness_function_number_of_tries",
                     "execution_time",
                     "total_number_of_tries",
                     ]
        csv_file_dir = path.join(self.dir_path,"outputs","csv","results.csv")

        fields = []

        for cell in title_order:
            if cell in csv_result.keys():
                fields.append(csv_result[cell])
            else:
                fields.append("")

        with open(csv_file_dir,"a") as  g:
            fcntl.flock(g, fcntl.LOCK_EX)
            writer = csv.writer(g)
            writer.writerow(fields)
            fcntl.flock(g, fcntl.LOCK_UN)



# Read stack trace and find valid frames
class LogReader():
    ExceptionName = ""
    all_frames_count = 0
    project_frames_count = 0

    def getValidFrameLevels(self, log_dir, project_package):
        self.all_frames_count = 0
        self.project_frames_count = 0
        #reading Exceptions:
        dir_path = path.dirname(path.realpath(__file__))
        with open(path.join(dir_path,"inputs","exceptions.txt"), 'r') as content_file:
            content = content_file.read()
        exceptionList = json.loads(content)
        for index,ex in enumerate(exceptionList):
            exceptionList[index] = re.sub(r"\W", "", ex)
        valid_frames = []
        log_file = open(log_dir, "r")
        counter = 0
        for line in log_file:

            if re.sub(r"\W", "", line) not in exceptionList:
                if counter > 0:
                    splited_line = line.split('.')
                    if len(splited_line) > 1 and (project_package in splited_line or self.appeared_in_other_format(project_package,splited_line)):
                        valid_frames.append(counter)
                        self.project_frames_count += 1
                    if (line.lstrip() != ""):
                        self.all_frames_count += 1
                else:
                    splited_line = line.split(':')
                    self.ExceptionName = splited_line[0]
            counter += 1

        log_file.close();
        return valid_frames

    def appeared_in_other_format(self,project_package,splited_line):
        result =  False
        for part in splited_line:
            if ''.join([i for i in project_package if not i.isdigit()]) == ''.join([i for i in part if not i.isdigit()]):
                result = True
        return result


    def getExceptionName(self):
        return self.ExceptionName

    def getAllFramesCount(self):
        return self.all_frames_count

    def getProjectFramesCount(self):
        return self.project_frames_count
