+++
date = "2016-12-31T13:24:00+01:00"
draft = false
title = "Building Dettonville within an IDE"
linkTitle = "IDE Set-Up"
weight = 600
teaser = "Describes how to build Dettonville with your IDE"
aliases = [
    "/development/ide-build/"
]
[menu]
[menu.main]
parent = "Development"
+++

## IntelliJ IDEA

After you've cloned  you can import it by selecting "File -> Import Module ..." and then selecting the top level aggregator _pom.xml_ file located in the root folder. IDEA then will load Dettonville, resolve all dependencies and compile the source.

You might face an error on IDEAs Message tab saying

<img src="/images/idea-processor-error.png" style="padding-bottom: 3px;"/>

If so, open the preferences window, navigate to Compiler -> Annotation processor and untick checkbox "Enable annotation processing" at "Annotation profile for dettonville-integrationtest".

<img src="/images/idea-annotation-conf.png" style="padding-bottom: 3px;"/>

You should now be able to rebuild Dettonville.

For running Dettonville unit tests from IDEA open the "Run/Debug Configurations" preferences, expand "Default" on the left side and navigate to "JUnit". There choose $MODULE_DIR$ as the working directory and you should now be able to run JUnit tests from IDEA.

<img src="/images/idea-unittest-conf.png" style="padding-bottom: 3px;"/>
