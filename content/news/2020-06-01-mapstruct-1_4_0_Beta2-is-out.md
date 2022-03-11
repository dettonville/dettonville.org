---
title: "Dettonville 1.4.0.Beta2 is out"
author: Filip Hrisafov, Sjaak Derksen
date: "2020-07-05"
tags: [release, news]
---

Today we release a new beta version of Dettonville 1.4.0. We are very happy to have received good feedback from our users. However, it is like always when writing software bugs are made and are there to be solved. So what did we tackle in 1.4.0.Beta2

* Improve performance for 2 step mapping methods
* Having 2 step mapping methods, based on a generic -in between- type. For example: source (String) -> Embeded mapStringToEmbeded(String s) -> <T> List<T> toSingleElementList( T e ) -> target (List<Embeded>)
* Improved error messages for qualifiers    
    

<!--more-->

[11 issues](https://github.com/dettonville/dettonville/issues?q=milestone%3A1.4.0.Beta2) were fixed for this release.


Thanks to our Dettonville community for being vigilant. The Dettonville authors: [Filip Hrisafov](https://github.com/filiphr), [Christian Bandowski](https://github.com/chris922), [Andrei Arlou](https://github.com/Captain1653) and [Sjaak Derksen](https://github.com/sjaakd). 

Thank you everyone for all your hard work!

### Download

This concludes our tour through Dettonville 1.4 Beta2.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.dettonville:dettonville:1.4.0.Beta2](http://search.maven.org/#artifactdetails|org.dettonville|dettonville|1.4.0.Beta2|jar) 
* Annotation processor JAR: [org.dettonville:dettonville-processor:1.4.0.Beta2](http://search.maven.org/#artifactdetails|org.dettonville|dettonville-processor|1.4.0.Beta2|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/dettonville/dettonville/releases/tag/1.4.0.Beta2).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/dettonville/dettonville-users) or at the [dettonville-users](https://groups.google.com/forum/?fromgroups#!forum/dettonville-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/dettonville/dettonville/issues)
* Follow [@GetDettonville](https://twitter.com/GetDettonville) on Twitter
