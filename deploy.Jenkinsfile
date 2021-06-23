def repoUrl = "https://github.com/octavianandrei/krktest.git"
properties([
  parameters([
    string(name: 'repo_branch', description: 'Branch to build and deploy Litecoin from', defaultValue: 'master'),
  ])
])

timestamps {
    node () {
        stage('Clear WORKSPACE') {
	  cleanWs()
      	}
      	stage("Clone Repo"){
      	  String repo_branch = "master"
          git branch: repo_branch, url: 'https://github.com/octavianandrei/krktest.git'
      	}

      	stage('Exec permissions') {
          println "Add exec permission"
      	  sh "chmod +x start_docker.sh"
        }

      	stage('Build the docker image locally'){
          sh "docker build -t litecoind:krakentest ."
      	}

        stage('Deploy on local k8s cluster') {
          sh "kubectl -f statefulset.yaml"
        }

        stage('Clear WORKSPACE') {
          cleanWs()
        }
    }  

}
