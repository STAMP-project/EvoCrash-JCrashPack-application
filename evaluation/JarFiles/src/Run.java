
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

//import org.crash.client.log.LogParser;
//import org.crash.master.EvoSuite;
import org.evosuite.coverage.evocrash.LogParser;
import org.evosuite.EvoSuite;
import org.evosuite.ga.metaheuristics.GeneticAlgorithm;
import org.evosuite.result.TestGenerationResult;
import org.evosuite.testcase.TestChromosome;
import org.json.JSONArray;
import org.json.JSONObject;


import net.jcip.annotations.NotThreadSafe;


import net.jcip.annotations.NotThreadSafe;

@NotThreadSafe
public class Run {


	private static int frameLevel;
	private static String ExceptionType;
	private static String issueNumber;
	private static String softwareVersion;
	private static Path logPath;
	private static String dependencies ="";
	private static Path testPath;
	private static Path binpath;
	private static int executionId;


	private static String budget;
	private static String p_functional_mocking;
	private static String functional_mocking_percent;
	private static String p_reflection_on_private;
	private static String reflection_start_percent;
	private static String population;
	private static String targetClass;

	public static void main(String[] args) throws IOException {
		//prepare variables:
		JSONObject array = new JSONObject(args[0]);
		preloadVars(array);
		// prepare command for evoCrash
		String[] command = {
				"-generateTests",
				"-Dcriterion=CRASH",
				"-Dsandbox=TRUE",
				"-Dtest_dir="+ testPath.toString(),
				"-Drandom_tests=0",
				"-Dp_functional_mocking="+p_functional_mocking,
				"-Dfunctional_mocking_percent="+functional_mocking_percent,
				"-Dp_reflection_on_private="+p_reflection_on_private,
				"-Dreflection_start_percent="+reflection_start_percent,
				"-Dminimize=TRUE",
				"-Dheadless_chicken_test=FALSE",
				"-Dpopulation="+population,
				"-Dsearch_budget="+budget,
				"-Dstopping_condition=MAXFITNESSEVALUATIONS",
				"-Dglobal_timeout="+(5*60*60),
				"-Dtarget_frame="+frameLevel,
				"-Dvirtual_fs=TRUE",
				"-Duse_separate_classloader=FALSE",
				"-Dreplace_calls=FALSE",
				"-Dmax_recursion=50",
				// "-Dtools_jar_location=/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home/lib",
				"-Dreset_static_fields=FALSE",
				"-Dvirtual_net=FALSE",
				"-Dtarget_exception_crash="+ExceptionType,
				"-DEXP="+ logPath.toString(),
				"-projectCP",
				dependencies,
				"-class",
				targetClass
				};

EvoSuite evosuite = new EvoSuite();

		try {
			Object result = evosuite.parseCommandLine(command);
			List<List<TestGenerationResult>> results = (List<List<TestGenerationResult>>)result;
			GeneticAlgorithm<?> ga = getGAFromResult(results);

			if (ga == null){
				// ga is null when during bootstrapping the ideal test is found!
				//Assert.assertTrue(true);
				System.exit(0);
			}
			else{
				TestChromosome best = (TestChromosome) ga.getBestIndividual();
				System.exit(0);
				//Assert.assertEquals(0.0, best.getFitness(), 0);
			}
		}catch(Exception e){
			e.printStackTrace(System.out);
			System.exit(0);
		}

	}


	public static void preloadVars(JSONObject array) throws IOException {
		executionId = array.getInt("execution_idx");
		budget = array.getString("search_budget");
		p_functional_mocking = array.getString("p_functional_mocking");
		functional_mocking_percent = array.getString("functional_mocking_percent");
		p_reflection_on_private = array.getString("p_reflection_on_private");
		reflection_start_percent = array.getString("reflection_start_percent");
		population = array.getString("population");
		frameLevel = array.getInt("frame");
		softwareVersion = array.getString("version");
		issueNumber = array.getString("case");

		String user_dir = System.getProperty("user.dir");
		binpath = Paths.get(user_dir,"..","resources", "targetedSoftware", array.getString("application").toUpperCase()+"-bins");
		String bin_path = binpath.toString();

		logPath = Paths.get(user_dir,"..","resources", "logs" ,array.getString("application").toUpperCase(), issueNumber , issueNumber+".log");
		//finding exception type:
//		ExceptionType = array.getString("getExceptionName");

		BufferedReader br =  new BufferedReader(new FileReader(logPath.toString()));
		String firstLine = br.readLine();
		String[] parts = firstLine.split(":");
		ExceptionType = parts[0];
		br.close();


		// get all of the dependencies
    		File depFolder = new File(bin_path,array.getString("application").toUpperCase()+"-"+softwareVersion);
    		System.out.println(depFolder);
    		System.out.println(ExceptionType);
    		File[] listOfFilesInSourceFolder = depFolder.listFiles();
    		for(int i = 0; i < listOfFilesInSourceFolder.length; i++){
    			if(listOfFilesInSourceFolder[i].getName().charAt(0) !='.') {
    				Path depPath = Paths.get(depFolder.getAbsolutePath(), listOfFilesInSourceFolder[i].getName());
    				String dependency = depPath.toString();

    				dependencies += (dependency+":");
    			}
    		}
    		dependencies = dependencies.substring(0, dependencies.length() - 1);


    		//set the place which generated test should be saved.
    		testPath = Paths.get(user_dir,"..", "GGA-tests",issueNumber,"frame-"+frameLevel,"R"+executionId+"_PM"+p_functional_mocking+"_Mperc"+functional_mocking_percent+"_SB"+budget+"_POP"+population);
    		//testPath = Paths.get(user_dir, "GGA-tests");

    		//set the target class
    		targetClass = LogParser.getTargetClass(logPath.toString(), frameLevel);
	}


    @SuppressWarnings("unchecked")
    protected static GeneticAlgorithm<?> getGAFromResult(Object result) {
           assert(result instanceof List);
           List<List<TestGenerationResult>> results = (List<List<TestGenerationResult>>)result;
           if(results.size() == 1) {
           return results.get(0).get(0).getGeneticAlgorithm();
           }else {
        	   return null;
           }
  }
}
