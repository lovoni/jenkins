node {
	withEnv(["PATH=${tool 'docker'}/bin:$PATH"]){
	  	docker.image('maven:3.5.0-jdk-8').inside{
	    	sh 'maven --version'
	  	}
	}
}
