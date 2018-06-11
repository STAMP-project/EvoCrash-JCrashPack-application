XCOMMONS-928

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

# Frame 1
## target frame is private
target method is called in method `installExtension`.
The injected extensions is ok.
`getId()` method of extension, which is passed to the installExtension, did not have proper value as an input for `get()` method of injection extensions.
![Alt text](screenshots/12.jpg?raw=true "XCOMMONS-928")

# Frame 2
`installExtension` is target frame here.
similar to Frame 1

# Frame 3 & 4 & 5
## EvoCrash could not inject target call to generated test
target class is abstract and it contains generic type variables.
```
Target Class is : public abstract class AbstractExtensionJob<R extends ExtensionRequest, S extends JobStatus> extends AbstractJob<R, S>
```
# Frame 6
## EvoCrash could not inject target call to generated test
Target class extends `AbstractExtensionJob`. (Frame 3 to 5)

# Frame 7 & 8
## EvoCrash could not inject target call to generated test
```
Target Class is : public abstract class AbstractJob<R extends Request, S extends JobStatus> implements Job
```

# Frame 9
## target line is not covered
`job` variable is initialized in line 71 by following method:
```
    componentManager.getInstance(Job.class, InstallJob.JOBTYPE);
```
`componentManager` and `Job` are injected classes.
Evocrash cpuld not create a proper `job` variable for next lines, and it leads to NPE in line 72:
```
job.initialize(installRequest);
```

# Frame 10
## target line is not covered
EvoCrash got stock in previous line (line 76).
There is a method call to  `sendWikiProvisioningEvent()`.
in this method EvoCrash got stock in following statement:
```
observationManager.notify(new WikiProvisioningEvent(request.getWikiId()), request.getWikiId(),
            xcontextProvider.get());
```
Note that `observationManager` and `xcontextProvider` are injected by `@injection` and `request` is the input argument of target call.
Since setting the state of these 3 objects are hard for Evocrash during the search, Evocrash could not cover the line.

# Frame 11
## Line is not covered
Evocrash got stock in line 66.
`wikiCreationStepList` is a List which is initilized  by following component in line 63:
```
List<WikiCreationStep> wikiCreationStepList = componentManager.getInstanceList(WikiCreationStep.class);
```
this list is passed to `java.util.Collections.sort` in line 66. and this throws NPE in java.util.Collections.
setting the state of the object for this scenario is hard for Evocrash.

# Frame 12 & 13
Similar to Frame 7 & 8


