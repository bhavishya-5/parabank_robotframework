pipeline {
    agent any

    parameters {
        choice(name: 'ENV', choices: ['qa', 'dev'], description: 'Target environment (config/env.yaml)')
        string(name: 'TAGS', defaultValue: '', description: 'Optional: only run tests with these tags')
        string(name: 'SUITE', defaultValue: '', description: 'Optional: run a single suite/folder (e.g. API, Login)')
        booleanParam(name: 'HEADLESS', defaultValue: true, description: 'Run browser tests headless')
    }

    options {
        timestamps()
        timeout(time: 60, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '20'))
        disableConcurrentBuilds()
    }

    environment {
        VENV        = 'venv'
        RESULTS_DIR = 'results'
        ALLURE_DIR  = 'results\\allure'
        ENV_TARGET  = "${params.ENV}"
    }

    stages {
        stage('Setup Python venv') {
            steps {
                bat '''
                    python -m venv %VENV%
                    call %VENV%\\Scripts\\activate.bat
                    python -m pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Lint / Dry Run') {
            steps {
                bat '''
                    call %VENV%\\Scripts\\activate.bat
                    robot --dryrun --outputdir dryrun-results tests/
                    exit 0
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                bat '''
                    call %VENV%\\Scripts\\activate.bat
                    if not exist %RESULTS_DIR% mkdir %RESULTS_DIR%
                    if not exist %ALLURE_DIR% mkdir %ALLURE_DIR%

                    set TARGET=tests/
                    if not "%SUITE%"=="" set TARGET=tests/%SUITE%

                    set TAG_ARGS=
                    if not "%TAGS%"=="" set TAG_ARGS=--include %TAGS%

                    robot --variable ENV:%ENV_TARGET% --variable HEADLESS:%HEADLESS% --outputdir %RESULTS_DIR% --listener allure_robotframework:%ALLURE_DIR% --xunit xunit.xml %TAG_ARGS% %TARGET%
                    exit 0
                '''
            }
        }
    }

    post {
        always {
            junit testResults: "${RESULTS_DIR}/xunit.xml", allowEmptyResults: true
            archiveArtifacts artifacts: "${RESULTS_DIR}/**", allowEmptyArchive: true, fingerprint: true
        }
        cleanup {
            cleanWs()
        }
    }
}