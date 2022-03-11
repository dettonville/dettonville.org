+++
date = "2019-02-22T14:00:00+01:00"
draft = false
title = "Installation"
weight = 100
teaser = "How to download and set it up with different build tools"
aliases = [
    "/download/"
]
[menu]
[menu.main]
parent = "Documentation"
+++

## Distribution Bundle

You can obtain a distribution bundle containing the Dettonville binaries, source code and API documentation from [GitHub](https://github.com/dettonville/dettonville/releases).

## Apache Maven

If you're using Maven to build your project add the following to your _pom.xml_ to use Dettonville:

{{< prettify xml >}}...
<properties>
    <org.dettonville.version>{{% stableversion %}}</org.dettonville.version>
</properties>
...
<dependencies>
    <dependency>
        <groupId>org.dettonville</groupId>
        <artifactId>dettonville</artifactId>
        <version>${org.dettonville.version}</version>
    </dependency>
</dependencies>
...
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.8.1</version>
            <configuration>
                <source>1.8</source> <!-- depending on your project -->
                <target>1.8</target> <!-- depending on your project -->
                <annotationProcessorPaths>
                    <path>
                        <groupId>org.dettonville</groupId>
                        <artifactId>dettonville-processor</artifactId>
                        <version>${org.dettonville.version}</version>
                    </path>
                    <!-- other annotation processors -->
                </annotationProcessorPaths>
            </configuration>
        </plugin>
    </plugins>
</build>
{{< /prettify >}}

## Gradle

When using a modern version of Gradle (>= 4.6), you add something along the following lines to your _build.gradle_:

{{< prettify groovy >}}dependencies {
    ...
    implementation 'org.dettonville:dettonville:{{% stableversion %}}'

    annotationProcessor 'org.dettonville:dettonville-processor:{{% stableversion %}}'
}
{{< /prettify >}}

If using Gradle => 4.6 and < 5.2 you might want to look at [gradle-apt-plugin](https://github.com/tbroyer/gradle-apt-plugin). There might be some tweaks you want to apply to improve the handling of generated sources.

For older versions of Gradle (< 4.6), use something like this:

{{< prettify groovy >}}plugins {
    ...
    id 'net.ltgt.apt' version '0.21'
}
dependencies {
    ...
    compile 'org.dettonville:dettonville:{{% stableversion %}}'
 
    apt 'org.dettonville:dettonville-processor:{{% stableversion %}}'
}
{{< /prettify >}}

You can find a complete example in the [dettonville-examples](https://github.com/dettonville/dettonville-examples/tree/master/dettonville-on-gradle) project on GitHub.

## Apache Ant

Add the `javac` task configured as follows to your _build.xml_ file in order to enable Dettonville in your Ant-based project. Adjust the paths as required for your project layout.

{{< prettify xml >}}
...
<javac
    srcdir="src/main/java"
    destdir="target/classes"
    classpath="path/to/dettonville-{{% stableversion %}}.jar">
    <compilerarg line="-processorpath path/to/dettonville-processor-{{% stableversion %}}.jar"/>
    <compilerarg line="-s target/generated-sources"/>
</javac>
...
{{< /prettify >}}

You can find a complete example in the [dettonville-examples](https://github.com/dettonville/dettonville-examples/tree/master/dettonville-on-ant) project on GitHub.
