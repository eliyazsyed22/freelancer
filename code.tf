node {
    def server = Artifactory.server SERVERID
    def rtDotnet = Artifactory.newDotnetBuild()
    def buildInfo

    stage ('Clone') {
        git url: 'https://github.com/eliyazsyed22/dotnet-samples.git'
    }

    stage ('Artifactory configuration') {
        rtDotnet.resolver repo: 'artifactory-generic', server: server
        buildInfo = Artifactory.newBuildInfo()
    }

    stage ('.NET restore') {
        rtDotnet.run buildInfo: buildInfo, args: 'restore ./src/GraphQL.sln'
    }

    stage ('Publish build info') {
        server.publishBuildInfo buildInfo
    }
}