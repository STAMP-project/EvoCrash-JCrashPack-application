#!/bin/bash -e

# Bash script
#
# author: Xavier Devroey

scriptdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

echo "application,case,version,fixed_version,avg_ccn,application_ncss,frame_count,buggy_frame,exception,exception_name,exception_type,frame,frame_level,class,line,private,abstract_class,abstract_method,class_ccn,method_ccn"
for f in $(find . -regex .*\.log); do
	application=$(echo ${f:2} | cut -d '/' -f 1)
	caseName=$(echo ${f:2} | cut -d '/' -f 2)
	version=$(echo $caseName | sed -En 's/.*-([0-9]+b)/\1/p')
    frame_count=$(($(cat $f | grep 'at ' | wc -l)))
    if [[ "$application" =~ ^(XWIKI|ES)$ ]]; then
    	buggy=''
    else 
    	buggy=$(($frame_count-1))
    fi;
	exception=$(head -n 1 $f | cut -d " " -f1 | sed 's/:$//')
	exception_name=$(echo ${exception##*.})
	if [[ "$exception_name" =~ ^(AnnotationTypeMismatchException|ArithmeticException|ArrayStoreException|BufferOverflowException|BufferUnderflowException|CannotRedoException|CannotUndoException|ClassCastException|CMMException|CompletionException|ConcurrentModificationException|DataBindingException|DateTimeException|DOMException|EmptyStackException|EnumConstantNotPresentException|EventException|FileSystemAlreadyExistsException|FileSystemNotFoundException|IllegalArgumentException|IllegalMonitorStateException|IllegalPathStateException|IllegalStateException|IllformedLocaleException|ImagingOpException|IncompleteAnnotationException|IndexOutOfBoundsException|JMRuntimeException|LSException|MalformedParameterizedTypeException|MalformedParametersException|MirroredTypesException|MissingResourceException|NegativeArraySizeException|NoSuchElementException|NoSuchMechanismException|NullPointerException|ProfileDataException|ProviderException|ProviderNotFoundException|RasterFormatException|RejectedExecutionException|SecurityException|SystemException|TypeConstraintException|TypeNotPresentException|UncheckedIOException|UndeclaredThrowableException|UnknownEntityException|UnmodifiableSetException|UnsupportedOperationException|WebServiceException|WrongMethodTypeException|RuntimeException)$ ]]; then
    	exception_type="Java runtime exception"
    elif [[ "$exception" =~ ^(java.lang) ]]; then
        exception_type="Java lang exception"
    else
        exception_type="Custom exception"
    fi;
    level=0
    while read -r line; do
    	line=$(echo $line | tr -d '\r\n')
    	if [[ ${line:0:3} == "at " ]]; then
    		frame=${line:3}
    		let level=level+1
    		class=$(echo $frame | cut -d '(' -f 1)
    		line=$(echo $frame | cut -d ':' -f 2 | cut -d ')' -f 1)
    		echo "$application,$caseName,$version,,,,$frame_count,$buggy,$exception,$exception_name,$exception_type,$frame,$level,$class,$line,,,,,"
    	fi; 
    done < "$f";
done;
