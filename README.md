# openssl-android-terminal
<p>This sample shows how to compile and use openssl library for Android. The main feature is that it supports Russian GOST engine, and you can add another engine by adding the source files to engine directory and modifying openss.cnf file pointing to that engine in engine_section.<p>
	<center><image src="screens/app_terminal2.jpg"/></center>
<p>This project is Android project, but in order to compile openssl library in android you should do followings:</p>
<ul>
	<li>The script that compiles openssl library written in Linux Bash shell, so you should  have Linux environment(such as Ubuntu or Debian), (Windows script will be available later) </li>
	<li>You should have Android studio, Android sdk and as well as Android ndk installed on your system</li>
	<li>You should change NDK_ROOT, NDK_PATH, PATH in file:  <b>app/src/main/misc/build-native.sh</b> appropriate to the path where your NDK is located</li>
	<li>Open terminal and <b>cd</b> <b>to_your_project/app/src/main</b> then run a script following way: <b>./misc/build-native.sh</b></li>
	<li>Then just open project in Android studio then build_gradle is autommatically invoked by Android studio</li>
</ul>
<p>That's all, when app is launched you can send openssl commands</p>
<p><b>Important!!!</b> Not all the openssl commands are tested to be run, if some commands are not handled just open a new issue, and please describe the details</p>

<p><b>Important!!!</b> Openssl library that is compiled in this project does not work properly on some SAMSUNG devices such as Samsung j5-prime, Samsung GALAXY Note-4. I don't know the exact reason, but if you fix the problem, please send me the patches </p>
