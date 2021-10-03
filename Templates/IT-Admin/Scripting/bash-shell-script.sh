#!/bin/bash
#
#::             T I T L E 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#:: Author(s):   	Name, Name, Name
#:: Version 1.00
#::
#::
#::	Purpose: - 
#::		 - 
#::
#::	Dependencies:
#::
#::
#::
#::
#::
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#	
#	NOTE:	This terminal program is written and documented to a very high degree. The reason for doing this is that
#		these apps are seldom changed and when they are, it is usefull to be able to understand why and how 
#		things were built. Obviously, this becomes a useful learning tool as well; for all people that want to 
#		learn how to write admin scripts. It is a good and necessary practice to document extensively and follow
#		patterns when building your own apps and config scripts. Failing to do so will result in a costly mess
#		for any organization after some years and people turnover. 
#
#		As a general rule, we prefer using functions extensively because this makes it easier to manage the script
#		and facilitates several users working on the same scripts over time.
#		
# 
#	Admin scrips are placed in /opt/$BRANDING/scripts. Optionally scripts may use the common
#	functions in functions. 
#
#	Taxonomy of this script: we prioritize the use of functions over monolithic script writing, and proper indentation
#	to make the script more readable. Each function shall also be documented to the point of the obvious.
#	Suggested function structure per google guidelines:
#
#	function_name () {
#		# Documentation and comments... 
#		...code...
#	}
#
#	We also like to log all activity, and to echo status output to the screen in a frienly way. To accomplish this,
#	the table below may be used as appropriate: 
#
#				OUTPUT REDIRECTION TABLE	
#	--------------------------------------------------------------------
#		  || visible in terminal ||   visible in file   || existing
#	  Syntax  ||  StdOut  |  StdErr  ||  StdOut  |  StdErr  ||   file   
#	==========++==========+==========++==========+==========++===========
#	    >     ||    no    |   yes    ||   yes    |    no    || overwrite
#	    >>    ||    no    |   yes    ||   yes    |    no    ||  append
#	          ||          |          ||          |          ||
#	   2>     ||   yes    |    no    ||    no    |   yes    || overwrite
#	   2>>    ||   yes    |    no    ||    no    |   yes    ||  append
#	          ||          |          ||          |          ||
#	   &>     ||    no    |    no    ||   yes    |   yes    || overwrite
#	   &>>    ||    no    |    no    ||   yes    |   yes    ||  append
#	          ||          |          ||          |          ||
#	 | tee    ||   yes    |   yes    ||   yes    |    no    || overwrite
#	 | tee -a ||   yes    |   yes    ||   yes    |    no    ||  append
#	          ||          |          ||          |          ||
#	 n.e. (*) ||   yes    |   yes    ||    no    |   yes    || overwrite
#	 n.e. (*) ||   yes    |   yes    ||    no    |   yes    ||  append
#	          ||          |          ||          |          ||
#	|& tee    ||   yes    |   yes    ||   yes    |   yes    || overwrite
#	|& tee -a ||   yes    |   yes    ||   yes    |   yes    ||  append
#	-------------------------------------------------------------------
#
#	Our scripts are also structured in to three major sections: "settings", "functions", and "execute". 
#	Settings, contain configurable options for the script. Functions, contain all functions. Execute, 
#	contains all the actual logic and control of the script. 
#
#

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#::::::::::::::                                          ::::::::::::::::::::::
#::::::::::::::          Script Settings                 ::::::::::::::::::::::
#::::::::::::::                                          ::::::::::::::::::::::
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Variables that govern the behavior or the script and location of files are 
# set here. There should be no reason to change any of this.

# Use the RTD function library. This contains most of the intelligence used to perform this systems
# maintenance. 


if  [[ -f /path/to/shell_function_library ]]; then 
	source /path/to/shell_function_library
else 
        echo -e $RED "functions NOT loaded!" $ENDCOLOR
        echo -e $YELLOW " " $ENDCOLOR
        echo -e $YELLOW "Cannot ensure that the correct functionality is available" $ENDCOLOR
        echo -e $YELLOW "Quiting rather than cause potential damage..." $ENDCOLOR
        exit 1
fi




# Decide where to put log files.
# Default: log in to the $_RTDLOGSD location dated accordingly. If this is already set 
# we use the requested location.
if [ -z "$_ERRLOGFILE" ]; then _ERRLOGFILE=$_RTDLOGSD/$(date +%Y-%m-%d-%H-%M-%S-%s)-oem-setup-error.log ; else echo "	Errors will be logged to: '$_ERRLOGFILE'"; fi
if [ -z "$_LOGFILE" ]; then _LOGFILE=$_RTDLOGSD/$(date +%Y-%m-%d-%H-%M-%S-%s)-oem-setup.log ; else echo "	Logfile is set to: '$_LOGFILE'"; fi



#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#::::::::::::::                                          ::::::::::::::::::::::
#::::::::::::::          Script Functions                ::::::::::::::::::::::
#::::::::::::::                                          ::::::::::::::::::::::
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#





#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#::::::::::::::                                          ::::::::::::::::::::::
#::::::::::::::          Execute tasks                   ::::::::::::::::::::::
#::::::::::::::                                          ::::::::::::::::::::::
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




if [[ -z $DISPLAY ]]; then 
	echo "No X server at \$DISPLAY [$DISPLAY]" >&2
    	# Run parts if there is no GUI, like for servers and headless systems...
else
	# Run parts that need a GUI. 
fi




#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#::::::::::::::                                          ::::::::::::::::::::::
#::::::::::::::          Finalize.....                   ::::::::::::::::::::::
#::::::::::::::                                          ::::::::::::::::::::::
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

exit

