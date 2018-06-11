 # Introduction

This artifact provides 3 parts: sample, evaluation, and results.
Sample is an example which replicates the `XWIKI-13031` stack trace using ExRunner. 
Evaluation may be used to replicate our results, presented in `CrashPack: A Benchmark for Crash Reproduction`, M. Soltani, P. Derakhshanfar, X. Devroey, and A. van Deursen, submitted to ISSTA 2018.
Results presents complete results of the paper, including details of the manual analysis performed.
We also detail the steps to add a new stack trace to CrashPack and include it in ExRunner, and how to extend ExRunner to another crash replication tool.

# Running Sample

For sample, ExRunner applies EvoCrash 10 times on each frame of the `XWIKI-13031` stack trace.

1. Run `Init.py` in `Sample/pythonScripts` directory:
```
python Sample/pythonScripts/Init.py <Number of Threads>
```
The default `<Number of Threads>` is 5.

  During the execution of ExRunner, we can monitor the progress of EvoCrash on the case.

2. Collect the results:

  Results of the execution (including final fitness value of each case) are saved in `Sample/pythonScripts/outputs/csv/result.csv`. In addition, if a test case has been generated (i.e., EvoCrash succeeded to reproduce the stack trace), it is saved in `Sample/JarFiles/GGA-tests`.


# Reproducing the evaluation

For Evaluation, ExRunner applies EvoCrash 10 times on all of the 72 stack traces selected for evaluation.

 **Attention:** to reproduce evaluation in a reasonable amount of time, one need a powerful machine with a large amount of memory to be able to increase the `<Number of Threads>`. In our evaluation, we distributed the execution on several machines.

1. Run `Init.py` in `Evaluation/pythonScripts` directory:
```
  python Evaluation/pythonScripts/Init.py <Number of Threads>
```

2. Collect the results:

  Results of the execution are saved in `Evaluation/pythonScripts/outputs/csv/result.csv`. In addition, the generated test cases (if any) are saved in `Evaluation/JarFiles/GGA-tests`.


# Add a new stack trace

There are 3 steps to add a new stack trace to ExRunner: 1. adding stack trace, 2. adding dependencies, 3. adding the information of new issue in `input.csv` file.

1. Adding the stack trace
  * Add a `<PROJECT>` directory (project name should be in upper case) to `JarFiles/resources/logs/`. For instance, `JarFiles/resources/logs/XWIKI`.

  * Add a `<issue-name>` directory to `JarFiles/resources/logs/<PROJECT>`. For instance, `JarFiles/resources/logs/XWIKI/XCOMMONS-928`. The `<issue-name>` should denote the issue in the `<PROJECT>` from which the stack trace has been collected.

  * Add a `<issue-name>.log` file to `JarFiles/resources/logs/<PROJECT>/<issue-name>`. For instance, `JarFiles/resources/logs/XWIKI/XCOMMONS-928/XCOMMONS-928.log`. File `<issue-name>.log` contains the stack trace without any other information. For instance:

```
java.lang.NullPointerException: null
    at org.xwiki.extension.repository.internal.installed.DefaultInstalledExtensionRepository.applyInstallExtension(DefaultInstalledExtensionRepository.java:449)
    at org.xwiki.extension.repository.internal.installed.DefaultInstalledExtensionRepository.installExtension(DefaultInstalledExtensionRepository.java:691)
    at org.xwiki.extension.job.internal.AbstractExtensionJob.installExtension(AbstractExtensionJob.java:257)
    at org.xwiki.extension.job.internal.AbstractExtensionJob.applyAction(AbstractExtensionJob.java:204)
    at org.xwiki.extension.job.internal.AbstractExtensionJob.applyActions(AbstractExtensionJob.java:151)
    at org.xwiki.extension.job.internal.InstallJob.runInternal(InstallJob.java:150)
    at org.xwiki.job.AbstractJob.runInContext(AbstractJob.java:205)
    at org.xwiki.job.AbstractJob.run(AbstractJob.java:188)
    at org.xwiki.platform.wiki.creationjob.internal.ExtensionInstaller.installExtension(ExtensionInstaller.java:73)
    at org.xwiki.platform.wiki.creationjob.internal.steps.ProvisionWikiStep.execute(ProvisionWikiStep.java:78)
    at org.xwiki.platform.wiki.creationjob.internal.WikiCreationJob.runInternal(WikiCreationJob.java:80)
    at org.xwiki.job.AbstractJob.runInContext(AbstractJob.java:205)
    at org.xwiki.job.AbstractJob.run(AbstractJob.java:188)
    at java.util.concurrent.ThreadPoolExecutor.runWorker(Unknown Source)
    at java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
    at java.lang.Thread.run(Unknown Source)
```
  

2. Adding dependencies
  * Add a `<PROJECT>-bins` directory (project name should be in upper case) to `JarFiles/resources/targetedSoftware/`. For instance, `JarFiles/resources/targetedSoftware/XWIKI-bins`.

  * Add a `<PROJECT>-<Version>` directory (project name should be in upper case) to `JarFiles/resources/targetedSoftware/<PROJECT>-bins`. For instance, `JarFiles/resources/targetedSoftware/XWIKI-bins/XWIKI-7.2`. `<Version>` is the version of the `<PROJECT>` the will be used by EvoCrash to replicate the stack trace.

  * Put the Jar file of version `<Version>` of the `<PROJECT>` and all its dependencies in `JarFiles/resources/targetedSoftware/<PROJECT>-bins/<PROJECT>-<Version>`.

3. Adding new issue to input.csv
  * Open `data.py` in `input_generator` directory.
  * Add a project entry to `projects` array. Add a list of 3 indexes to the array:
	1. `id`: a unique number for the project.
    2. `name`: project name (`<PROJECT>`).
    3. `package`: name of the project in stack traces.
    Example:
        
	```
  	{"id":"0","name":"xwiki","package":"xwiki"}
  	```
      
  * Add an issue entry to `cases` array. A list with 7 indexes:
    1. `id`: a unique number for issue.
    2. `project`: id of the project in `projects` array.
    3. `name`: the issue name which we used to create directory of stack trace (`<issue-name>`).
    4. `version`: the affected version of stack trace (`<Version>`).
    5. `fixed` (optional): 1 if it is a fixed issue, and 0 if the issue is still unresolved.
    6. `fixed_version` (optional): fixed version.
    7. `buggy_frame` (optional): frame which triggers the bug.
    Example:
    
    ```
    {"id": "7", "project": "0", "name": "XCOMMONS-928", "version": "7.4.2", "fixed": "1", "fixed_version": "7.4.3","buggy_frame": "5"}
    ```
        
  * Run `input_generator/init.py` that will update `input.csv` in `/pythonScripts/inputs`.


# Run other crash replication tools with ExRunner

To perform crash replication benchmarking with another tool, ExRunner has to be modified to match input and output formats of this tool.

  1. Implement an adaptor for the new tool:

  ExRunner uses an adaptor to handle execution of crash replication tool. This adaptor is a class with a `main` method that is called for each line in `input.csv`. For instance, the adaptor for EvoCrash is defined in `JarFiles/src/Run.java`.

  2. Modify input CSV file:

  Arguments for the crash replication tool are defined in `/pythonScripts/inputs/input.csv`. Each line of this CSV file is one stack trace with specific configurations. Indexes of the columns in `input.csv` that are passed to the adaptor are specified in `useful_indexes` array in `pythonScripts/input.py`. For instance, if the needed configurations are only in 2 first columns of `input.csv`, `useful_indexes` would be `[0,1]`.

    **Attention:** application, case, and round columns are mandatory for CSV file.

  3. Customise `csv_results` array in `RunJar.py`:

   There is a `for loop` at `line 147` of `pythonScripts/RunJar.py` that checks each line of output and saves  data to `csv_results` array. Depending on the output of the crash replication tool, this loop has to be modified accordingly.
   
  4. Collect execution logs:

  ExRunner writes results and output logs of the tool in `pythonScripts/outputs/logs`.

# Reproduce analysis of the paper

Results folder contains different subfolders with the complete results of our evaluation. A `Makefile` is available in the `Results/` to launch the R analysis (requires R to be installed and Rscripts command to be available). The different goals (to be launched from the `Results/` folder) are:

  * `make analysebenchmark` prints various statistics on the CrashPack benchmark;
  * `make analyseresults` prints various statistics on the results of our evaluation;
  * `make plots` prints the .pdf plots describing the benchmark and the evaluation results in `plots/`;
  * `make tables` prints the .tex tables describing the benchmark and the evaluation results in `tables/`;
  * `make all` all of the above goals;
  * `make clean` deletes `plots/` and `tables/`.
	
Other files in `Results/` include:

  * `csv/` with csv files with data on the benchmark (in `csv/benchmark/benchmark.csv`) and the results of our 10 rounds of evaluation (in `/csv/round[1-10]/results.csv`);
  * `logs/` with the output logs of EvoCrash for each round of each case;
  * `manual-analysis/` the manual analysis performed on the unreproducible cases (see `/manual-analysis/classification.csv` for the classification of the cases);
  * `tests/` the tests generated by EvoCrash (if any) for the different cases.



