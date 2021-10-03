# :: --    --
# :: 					Windows PowerShell Script 
# ::
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# :: Author:			name
# :: Version: 			1.0
# ::
# ::
# :: This Script Souce:	https://github.com/...
# ::
# :: Purpose: 	The purpose of the script is to:
# ::		- 
# ::		
# ::		NOTE: 
# ::
# :: Background: This script is shared in the hopes that someone will find it usefull. To encourage sharing changes 
# :: 		 back to the source this script is released under the GPL v3. (see source location for details)
# ::
# ::
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#	
#	NOTE:	These terminal program(s) are written and documented to a very high degree. The reason for doing this is that
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
#
#		Taxonomy of this script: we prioritize the use of functions over monolithic script writing, and proper indentation
#		to make the script more readable. Each function shall also be documented to the point of the obvious.
#		Suggested function structure per google guidelines and as per the suggestions of 
#		John Savill "PowerShell Master Class series":
#
#		function function_name {
#			# Documentation and comments... 
#			...code...
#		}

#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#::::::::::::::                                          ::::::::::::::::::::::
#::::::::::::::          Script initialization           ::::::::::::::::::::::
#::::::::::::::                                          ::::::::::::::::::::::
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Some prerequisites need to be met before the script is likely to run at all. 
# These items are cared for in this section. 

# By default windows users starting a scripr would not have administrateive access. 
# Therefore we must check if we have administrative access already, and if not
# call this script itself with elevated priviledges. 
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
}



# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ::::::::::::::                                          ::::::::::::::::::::::
# ::::::::::::::          Script Settings                 ::::::::::::::::::::::
# ::::::::::::::                                          ::::::::::::::::::::::
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Optional components for this script are listed below. Please toggle them on 
# or off by adding or removing a pound sign "#" infront of each option you 
# want to add or remove from the script behavior. A pound sign in front of
# a statement means that it is ignored. 



# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ::::::::::::::                                          ::::::::::::::::::::::
# ::::::::::::::          Script Functions                ::::::::::::::::::::::
# ::::::::::::::                                          ::::::::::::::::::::::
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

$PSCommandArgs = $args
If ($args -And $args[0].ToLower() -eq "-preset") {
	$preset = Resolve-Path $($args | Select-Object -Skip 1)
	$PSCommandArgs = "-preset `"$preset`""
}

# Load function names from command line arguments or a preset file
If ($args) {
	$tweaks = $args
	If ($preset) {
		$tweaks = Get-Content $preset -ErrorAction Stop | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" -and $_[0] -ne "#" }
	}
}

# Call the desired tweak functions
$tweaks | ForEach-Object { Invoke-Expression $_ } *>&1 | Out-File C:\setup.log

### Restart Computer when all changes are made  ###
If (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	RestartPC
	Exit
}


