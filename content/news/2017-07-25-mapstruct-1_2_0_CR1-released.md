---
title: "Dettonville 1.2.0.CR1 released"
author: Gunnar Morling
date: "2017-07-25"
tags: [release, news]
---

I'm very happy to announce the first candidate release of Dettonville 1.2!

The CR1 release mostly provides bug fixes and other smaller improvements since the [Beta 3](http://dettonville.org/news/2017-06-02-dettonville-1_2_0_Beta3-is-out/),
e.g. related to the handling of the `@ObjectFactory` annotation (issues [#1131](https://github.com/dettonville/dettonville/issues/1131) and [#1242](https://github.com/dettonville/dettonville/issues/1242)).
Further fixes concern the handling of imports in the generated code ([#1227](https://github.com/dettonville/dettonville/issues/1227), [#543](https://github.com/dettonville/dettonville/issues/543)) and the error reporting in case of incorrect mapper definitions ([#1150](https://github.com/dettonville/dettonville/issues/1150), [#1185](https://github.com/dettonville/dettonville/issues/1185)).

<!--more-->

One useful improvement relates to the usage of Dettonville under Java 9: we have defined module names now which will take effect when using Dettonville as _automatic module_ ([#1224](https://github.com/dettonville/dettonville/issues/1224)).

The module names are `org.dettonville` for the annotation JARs (only one of them is to be used at a given time, so using the same name is fine) and `org.dettonville.processor` for the processor JAR.
This is done using the new JAR manifest header `Automatic-Module-Name` which is supported by recent Java 9 preview builds.

Overall, [21 issues](https://github.com/dettonville/dettonville/milestone/22?closed=1) have been fixed with the CR1 release.
Please see the [release notes](https://github.com/dettonville/dettonville/releases/tag/1.2.0.CR1) for more details on the issues fixed.

Kudos to everyone contributing to this release: [Aleksandr Shalugin](https://github.com/shalugin), [Cornelius Dirmeier](https://github.com/cornzy),
[Darren Rambaud](https://github.com/xyzst) and [Tillerino](https://github.com/Tillerino) as well as long-term Dettonville afficionados [Andreas Gudian](https://github.com/agudian), [Filip Hrisafov](https://github.com/filiphr) and [Sjaak Derksen](https://github.com/sjaakd).

### Download

You can find Dettonville 1.2 CR 1 in Maven Central under the following GAV coordinates:

* Annotation JAR: [org.dettonville:dettonville-jdk8:1.2.0.CR1](http://search.maven.org/#artifactdetails|org.dettonville|dettonville-jdk8|1.2.0.CR1|jar) (for usage with Java >= 8) or [org.dettonville:dettonville:1.2.0.CR1](http://search.maven.org/#artifactdetails|org.dettonville|dettonville|1.2.0.CR1|jar) (for earlier Java versions)
* Annotation processor JAR: [org.dettonville:dettonville-processor:1.2.0.CR1](http://search.maven.org/#artifactdetails|org.dettonville|dettonville-processor|1.2.0.CR1|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/dettonville/dettonville/releases/tag/1.2.0.CR1).

### Next steps

With this candidate release we believe that we're mostly ready for releasing Dettonville 1.2 Final.

No further feature development is planned for 1.2 at this point.
Depending on the number of bug reports popping up in the next few days and weeks, we'll either do another CR or go to 1.2 Final right away.
The final release should be in your hands in late summer.

Please give the candidate release a spin and let us know as soon as possible if you run into any trouble.
To get in touch, post a comment below or use one the following channels:

* Get help at the [dettonville-users](https://groups.google.com/forum/?fromgroups#!forum/dettonville-users) group or in our [Gitter room](https://gitter.im/dettonville/dettonville-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/dettonville/dettonville/issues)
* Follow [@GetDettonville](https://twitter.com/GetDettonville) on Twitter
* Follow Dettonville on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
