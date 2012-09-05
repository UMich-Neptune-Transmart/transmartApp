/*************************************************************************
 * tranSMART - translational medicine data mart
 * 
 * Copyright 2008-2012 Janssen Research & Development, LLC.
 * 
 * This product includes software developed at Janssen Research & Development, LLC.
 * 
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
 * as published by the Free Software  * Foundation, either version 3 of the License, or (at your option) any later version, along with the following terms:
 * 1.	You may convey a work based on this program in accordance with section 5, provided that you retain the above notices.
 * 2.	You may convey verbatim copies of this program code as you receive it, in any medium, provided that you retain the above notices.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS    * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 *
 ******************************************************************/
  

grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"

//grails.plugin.location.rmodules = "C:\\SVN\\repo1\\pharma\\transmart\\trunk\\plugins\\Rmodules"

//grails.project.war.file = "target/${appName}-${appVersion}.war"
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    repositories {
        grailsPlugins()
        grailsHome()
        grailsCentral()

        // uncomment the below to enable remote dependency resolution
        // from public Maven repositories
        mavenLocal()

        mavenCentral()
		mavenRepo "http://developer2.ncibi.org/maven"
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }
    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
		// build - dependency that is only needed by the build process
		// runtime - dependency that is needed to run the application, but not compile it 
		//   e.g. JDBC implementation for specific database vendor. This would not typically be needed at compile-time
		//        because code depends only the JDBC API, rather than a specific implementation thereof
		// compile - dependency that is needed at both compile-time and runtime. This is the most common case
		// There are a couple of other dependency scopes:
		// test - dependency that is only needed by the tests
		// provided - dependency that is needed at compile-time but should not be packaged with the app
		//   (usually because it is provided by the container). An example is the Servlet API
		
		compile 'org.ncibi.metab:metab-ws-client:1.0'
		runtime 'postgresql:postgresql:9.0-801.jdbc4'
    }

    plugins {
        compile ":hibernate:$grailsVersion"
        build ":tomcat:$grailsVersion"
        compile ":quartz:1.0-RC2"
        build ":rdc-rmodules:0.2"
        compile ":spring-security-core:1.2.7.1"
        build ":build-info:1.1"
		runtime ":prototype:1.0"
		compile ":resources:1.1.6"
    }
}
