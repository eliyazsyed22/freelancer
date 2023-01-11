node {
   
    def rtServer = Artifactory.server 'SERVERID'
    def rtDotnet = Artifactory.newDotnetBuild()
    def buildInfo

    stage ('Clone') {
        git branch: 'main', url: 'https://github.com/BladeofJesus/dotnet_sample_project'
    }
    
     stage ('.NET restore') {
        //rtDotnet.run buildInfo: buildInfo, args: 'restore /var/lib/jenkins/workspace/jfrogtest/src/GraphQL.sln'
       sh "dotnet build '/var/lib/jenkins/workspace/jfrogtest@2/TeamCityDotNet.sln'"
    }

    stage ('Artifactory zip configuration publish') {
        rtDotnet.resolver repo: 'deepti', server: rtServer
        buildInfo = Artifactory.newBuildInfo()
       sh "zip '/var/lib/jenkins/workspace/jfrogtest@2/TeamCityDotNet/bin/Debug/netcoreapp3.zip' '/var/lib/jenkins/workspace/jfrogtest@2/TeamCityDotNet/bin/Debug/netcoreapp3.1/'"
       sh "curl -u admin:eliyaz123 -T '/var/lib/jenkins/workspace/jfrogtest@2/TeamCityDotNet/bin/Debug/netcoreapp3.zip' 'http://3.110.119.40:8081/artifactory/deepti/jfrog110123'"
        
    }
     

    /*stage ('Publish build info') {
        rtServer.publishBuildInfo buildInfo
    }*/

}