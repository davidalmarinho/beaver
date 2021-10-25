@echo off

GOTO selection

REM Create a lua file that stores some configurations and actions
:createFirstLuaFile
type nul > premake5.lua
echo workspace "Workspace">> premake5.lua
echo     architecture "x64">> premake5.lua
echo. >> premake5.lua
echo     configurations {>> premake5.lua
echo        "Release",>> premake5.lua
echo        "Debug">> premake5.lua
echo     }>> premake5.lua
echo. >> premake5.lua
echo     startproject "ProjectFolder">> premake5.lua
echo. >> premake5.lua
echo outputdir = "%%{cfg.buildcfg}-%%{cfg.system}-%%{cfg.architecture}">> premake5.lua
echo --ex.: {Debug}{Windows}{x64}>> premake5.lua
echo. >> premake5.lua
echo -- Look for premake5.lua file of the project>> premake5.lua
echo include "ProjectFolder">> premake5.lua
echo. >> premake5.lua
echo newaction {>> premake5.lua
echo     trigger = "clean",>> premake5.lua
echo     description = "Remove all binaries and intermediate binaries, and vs files.",>> premake5.lua
echo     execute = function()>> premake5.lua
echo         print("Remove binaries")>> premake5.lua
echo         os.rmdir("./bin")>> premake5.lua
echo         print("Removing intermediate binaries")>> premake5.lua
echo         os.rmdir("./bin-int")>> premake5.lua
echo         print("Removing project files")>> premake5.lua
echo         os.rmdir("./.vs")>> premake5.lua
echo         os.remove("**.sln")>> premake5.lua
echo         os.remove("**.vcproj")>> premake5.lua
echo         os.remove("**.vcxproj")>> premake5.lua
echo         os.remove("**.vcxproj.filters")>> premake5.lua
echo         os.remove("**.vcxproj.user")>> premake5.lua
echo         os.remove("**.vcxproj")>> premake5.lua
echo         os.remove("**.project")>> premake5.lua
echo         os.remove("**Makefile")>> premake5.lua
echo         os.remove("*.workspace")>> premake5.lua
echo.>> premake5.lua
echo         workspace_dir_name = os.matchdirs("*.xcworkspace")>> premake5.lua
echo         -- This will return a list, where the index number 1 stores the name of the folder>> premake5.lua
echo         if workspace_dir_name[1] ~= nil then>> premake5.lua
echo             os.rmdir(workspace_dir_name[1])>> premake5.lua
echo         end>> premake5.lua
echo.>> premake5.lua
echo         xcodeproj_name = os.matchdirs("ProjectFolder/*.xcodeproj")>> premake5.lua
echo         if xcodeproj_name[1] ~= nil then>> premake5.lua
echo             os.rmdir(xcodeproj_name[1])>> premake5.lua
echo         end>> premake5.lua
echo         print("Clean up done.")>> premake5.lua
echo     end>> premake5.lua
echo }>> premake5.lua
echo. >> premake5.lua
echo newaction {>> premake5.lua
echo     trigger = "compile_every_way",>> premake5.lua
echo     description = "Created for debug purposes.",>> premake5.lua
echo     execute = function()>> premake5.lua
echo         os.execute("vendor\\premake5.exe codelite")>> premake5.lua
echo         os.execute("vendor\\premake5.exe xcode4")>> premake5.lua
echo         os.execute("vendor\\premake5.exe gmake")>> premake5.lua
echo         os.execute("vendor\\premake5.exe gmake2")>> premake5.lua
echo         os.execute("vendor\\premake5.exe vs2005")>> premake5.lua
echo         os.execute("vendor\\premake5.exe vs2008")>> premake5.lua
echo         os.execute("vendor\\premake5.exe vs2010")>> premake5.lua
echo         os.execute("vendor\\premake5.exe vs2012")>> premake5.lua
echo         os.execute("vendor\\premake5.exe vs2013")>> premake5.lua
echo         os.execute("vendor\\premake5.exe vs2015")>> premake5.lua
echo         os.execute("vendor\\premake5.exe vs2017")>> premake5.lua
echo         os.execute("vendor\\premake5.exe vs2019")>> premake5.lua
echo     end>> premake5.lua
echo }>> premake5.lua
GOTO :eof

REM Creates a lua file where we configure the project
:createSecondLuaFile
type nul > premake5.lua
echo -- Catch the current directory path>> premake5.lua
echo handle = io.popen("echo %%cd%%")>> premake5.lua
echo project_name = handle:read("*a")>> premake5.lua
echo.>> premake5.lua
echo -- Remove the current folder "ProjectFolder" from our path>> premake5.lua
echo -- ex.: C:\Users\userName\Documents\001_HelloWorld\ProjectFolder -> C:\Users\userName\Documents\001_HelloWorld\>> premake5.lua
echo tmp = "">> premake5.lua
echo for p in string.gmatch(project_name, "%%S+\\") do>> premake5.lua
echo     tmp = tmp .. p>> premake5.lua
echo end>> premake5.lua
echo.>> premake5.lua
echo -- Removing the last "\">> premake5.lua
echo -- ex.: C:\Users\userName\Documents\001_HelloWorld\ -^> C:\Users\userName\Documents\001_HelloWorld>> premake5.lua
echo project_name = string.sub(tmp, 1, -2)>> premake5.lua
echo.>> premake5.lua
echo -- We will just stay with 001_HelloWorld>> premake5.lua
echo name_buffer = "">> premake5.lua
echo     while ( true ) do>> premake5.lua
echo         -- Catch the index where we have the first slash
echo         -- ex.: ~/Documents/001_HelloWorld - The index of the first slash is 1>> premake5.lua
echo         slash_index = string.find(project_name, "\\")>> premake5.lua
echo        name_buffer = "">> premake5.lua
echo.>> premake5.lua
echo         -- When we will have no slashes, we also will have a null value in slash_index variable,>> premake5.lua
echo         -- so we will break the while loop here>> premake5.lua
echo         if slash_index == nil then>> premake5.lua
echo             break>> premake5.lua
echo         end>> premake5.lua
echo.>> premake5.lua
echo         -- To remove the all content until we fint the first slash>> premake5.lua
echo         for i = slash_index + 1, string.len(project_name) do>> premake5.lua
echo             name_buffer = name_buffer .. string.sub(project_name, i, i)>> premake5.lua
echo         end>> premake5.lua
echo         project_name = name_buffer>> premake5.lua
echo     end>> premake5.lua
echo.>> premake5.lua
echo project (project_name)>> premake5.lua
echo     kind "ConsoleApp">> premake5.lua
echo     language "C++">> premake5.lua
echo     cppdialect "C++17" -- cpp 2017 version>> premake5.lua
echo     -- In case of importing libraries>> premake5.lua
echo     staticruntime "on">> premake5.lua
echo.>> premake5.lua
echo     targetdir("../bin/" .. outputdir .. "/%%{prj.name}") -- Inside the current directory. '..' is contenation in Lua-->> premake5.lua
echo     objdir("../bin-int/" .. outputdir .. "/%%{prj.name}")>> premake5.lua
echo.>> premake5.lua
echo     files {>> premake5.lua
echo         "cpp/**.cpp", -- Look for .cpp file in subdirectories>> premake5.lua
echo         "include/**.h">> premake5.lua
echo         -- "include/**.hpp">> premake5.lua
echo     }>> premake5.lua
echo.>> premake5.lua
echo     includedirs {>> premake5.lua
echo         "include">> premake5.lua
echo     }>> premake5.lua
echo.>> premake5.lua
echo     defines {>> premake5.lua
echo         "WINDOWS">> premake5.lua
echo     }>> premake5.lua
echo.>> premake5.lua
echo     filter { "configurations:Debug" }>> premake5.lua
echo         buildoptions "/MTd" -- d is just for debug>> premake5.lua
echo         runtime "Debug">> premake5.lua
echo         symbols "on" -- To generate debug symbols>> premake5.lua
echo.>> premake5.lua
echo     filter { "configurations:Release" }>> premake5.lua
echo         buildoptions "/MT" >> premake5.lua
echo         runtime "Release">> premake5.lua
echo         optimize "on">> premake5.lua
GOTO :eof

REM Creates the main's cpp file
:createMainCpp
type nul > main.cpp
echo #include ^<iostream^>>> main.cpp
echo.>> main.cpp
echo #include "program_info.h">> main.cpp
echo.>> main.cpp
echo int main(int argc, char *argv[]) {>> main.cpp
echo     // Enable arguments for our program>> main.cpp
echo     program_inform::show_info(argc, argv);>> main.cpp
echo     std::cout ^<^< "Hello World!" ^<^< std::endl;>> main.cpp
echo.>> main.cpp
echo     return 0;>> main.cpp
echo }>> main.cpp
REM ">" writes and deletes/creates, ">>" update the file
GOTO :eof REM is the same as exit /b

REM Creates the second's cpp file
:createProgramInfoCpp
type nul > program_info.cpp
echo #include ^<iostream^>> program_info.cpp
echo #include ^<string.h^>>> program_info.cpp
echo.>> program_info.cpp
echo #include "program_info.h">> program_info.cpp
echo.>> program_info.cpp
echo namespace program_inform {>> program_info.cpp
echo    void show_info(int argc, char *argv[]) {>> program_info.cpp
echo        // If we don't have any arguments>> program_info.cpp
echo        if (argc == 1) return;>> program_info.cpp
echo.>> program_info.cpp
echo        if (strcmp("--version", argv[1]) == 0) {>> program_info.cpp
echo            std::cout ^<^< "v0.0.1" ^<^< std::endl;>> program_info.cpp
echo        } else if (strcmp("--name", argv[1]) == 0) {>> program_info.cpp
echo            std::cout ^<^< argv[0] ^<^< std::endl;>> program_info.cpp
echo        } else if (strcmp("--help", argv[1]) == 0) {>> program_info.cpp
echo            std::cout ^<^< "Available arguments:" ^<^< std::endl;>> program_info.cpp
echo             std::cout ^<^< "--name Tell you the name of the program" ^<^< std::endl;>> program_info.cpp
echo             std::cout ^<^< "--version Provides you information about the program" ^<^< std::endl;>> program_info.cpp
echo         } else {>> program_info.cpp
echo             std::cout ^<^< "Argument not recognised. Type --help for more informations." ^<^< std::endl;>> program_info.cpp
echo         }>> program_info.cpp
echo.>> program_info.cpp
echo         // Warn the user that our program only can take one argument>> program_info.cpp
echo         if (argc ^> 2) {>> program_info.cpp
echo             std::cout ^<^< "This program should have only one argument. Type --help for more informations." ^<^< std::endl;>> program_info.cpp
echo         }>> program_info.cpp
echo.>> program_info.cpp
echo         exit(0);>> program_info.cpp
echo     }>> program_info.cpp
echo  }>> program_info.cpp
GOTO :eof

REM This function creates the header file
:createProgramInfoH
type nul > program_info.h
echo #pragma once>> program_info.h
echo namespace program_inform {>> program_info.h
echo    // argc -> Number of arguments>> program_info.h    
echo    // argv[0] -> Name of the program>> program_info.h
echo    // argv[1] -> First argument>> program_info.h
echo    void show_info(int argc, char *argv[]);>> program_info.h
echo.>> program_info.h
echo } // namespace program_inform\n'>> program_info.h
GOTO :eof

REM If there is no arguments
:selection
IF "%~1" == "" GOTO printHelp
IF "%~1" == "create" GOTO createProject
IF "%~1" == "compile" GOTO compile
IF "%~1" == "run" GOTO run
IF "%~1" == "clean" GOTO clean
IF "%~1" == "delete" GOTO delete
IF "%~1" == "gmake" GOTO gmake
IF "%~1" == "gmake2" GOTO gmake2
IF "%~1" == "vs2019" GOTO vs2019 
IF "%~1" == "vs2017" GOTO vs2017 
IF "%~1" == "vs2015" GOTO vs2015 
IF "%~1" == "vs2013" GOTO vs2013 
IF "%~1" == "vs2012" GOTO vs2012 
IF "%~1" == "vs2010" GOTO vs2010 
IF "%~1" == "vs2008" GOTO vs2008 
IF "%~1" == "vs2005" GOTO vs2005 
IF "%~1" == "xcode4" GOTO xcode4 
IF "%~1" == "codelite" GOTO codelite
IF "%~1" == "compile_every_way" GOTO compileEveryWay

REM Our user interface
:printHelp
echo.
echo Enter 'beaver action' where action is one of the following:
echo.
echo create            Will create the resources needed to a new project into the current directory.
echo compile           Will generate make file then compile using the make file.
echo run               Will generate make file then compile using the make file then run the project.
echo clean             Remove all binaries and intermediate binaries and project files.
echo delete            Will delete all project files. Be careful.
echo gmake             Generate GNU makefiles for Linux.
echo gmake2            Generate GNU makefiles for Linux.
echo vs2019            Generate Visual Studio 2019 project files.
echo vs2017            Generate Visual Studio 2017 project files.
echo vs2015            Generate Visual Studio 2015 project files.
echo vs2013            Generate Visual Studio 2013 project files.
echo vs2012            Generate Visual Studio 2012 project files.
echo vs2010            Generate Visual Studio 2010 project files.
echo vs2008            Generate Visual Studio 2008 project files.
echo vs2005            Generate Visual Studio 2005 project files.
echo xcode4            Generate Apple Xcode 4 project files.
echo codelite          Generate CodeLite project files.
GOTO done

:createProject
REM Create folders
mkdir ProjectFolder
mkdir vendor
mkdir bin
mkdir bin-int
cd ProjectFolder
mkdir include
mkdir cpp

REM Create cpp main file
cd cpp

REM Write cpp main code
call:createMainCpp

REM Create program_info.cpp file
call:createProgramInfoCpp

REM Create program_info.h file
cd ..
cd include
call:createProgramInfoH

REM Fallback to the folder of the main process
cd ..
cd ..

call:createFirstLuaFile

REM Create the second premake5.lua
cd ProjectFolder

call:createSecondLuaFile
cd ..

REM Download premake5.exe and extract it
cd vendor
curl "https://github.com/premake/premake-core/releases/download/v5.0.0-alpha16/premake-5.0.0-alpha16-windows.zip" -L -O
tar -xf premake-5.0.0-alpha16-windows.zip
del premake-5.0.0-alpha16-windows.zip
cd ..
GOTO done

:compile
vendor\premake5.exe vs2019

if not defined DevEnvDir (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\VsDevCmd.bat"
)

set solutionFile = "Workspace.sln"
echo "%solutionFile%"
msbuild /t:Build /p:Configuration=Debug /p:platform=x64 %solutionFile%

GOTO done

:run
vendor\premake5.exe vs2019
if not defined DevEnvDir (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\VsDevCmd.bat"
)

set solutionFile = "Workspace.sln"
msbuild /t:Build /p:Configuration=Debug /p:platform=x64 %solutionFile%

echo Running...
echo ----------

cd bin

REM Find the Windows' folder. --ex.: Debug-windows-x86_64
for /f "TOKENS=*" %%f IN ('dir /b /ad /s "*windows*"') do (
    set directoryWindowsOutput=%%~f
)
cd %directoryWindowsOutput%

REM Find the folder which holds the excutable. --ex.: 001_HelloWorld
for /f "TOKENS=*" %%p in ('dir /b /ad /s') do (
    set executableDirectory=%%~p
)
cd %executableDirectory%

REM Find the executable file --ex.: 001_HelloWorld.exe
for /f "TOKENS=*" %%c in ('dir /b "*.exe"') do (
    set executableFile=%%~c
)

REM Now, since we have the cought the executable, we will run it
%executableFile%

REM Fallback to the initial directory
cd ..
cd ..
cd ..

GOTO done

:clean
vendor\premake5.exe clean
GOTO done

:delete
REM Ask user if he is sure of deleting the project
set /p confirmation=Are your sure? This action will delete all your ptoject files [Y/N] -^> 
if /i "%confirmation%" neq "Y" GOTO done
vendor\premake5.exe clean

REM Remove vendor, ProjectFolder and premake5.lua file
echo Removing ProjectFolder...
rmdir /s /q ProjectFolder
echo Removing premake5...
del premake5.lua
rmdir /s /q vendor
echo The project has been deleted.
GOTO done

:gmake
vendor\premake5.exe gmake
GOTO done

:gmake2
vendor\premake5.exe gmake2
GOTO done

:vs2019
vendor\premake5.exe vs2019
GOTO done

:vs2017
vendor\premake5.exe vs2017
GOTO done

:vs2015
vendor\premake5.exe vs2015
GOTO done

:vs2013
vendor\premake5.exe vs2013
GOTO done

:vs2012
vendor\premake5.exe vs2012
GOTO done

:vs2010
vendor\premake5.exe vs2010
GOTO done

:vs2008
vendor\premake5.exe vs2008
GOTO done

:vs2005
vendor\premake5.exe vs2005
GOTO done

:xcode4
vendor\premake5.exe xcode4
GOTO done

:codelite
vendor\premake5.exe codelite
GOTO done

:compileEveryWay
vendor\premake5.exe compile_every_way
GOTO done

:done
echo ----------
echo Finishing process...