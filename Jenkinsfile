pipeline {
    agent any

    parameters {
        choice(name: 'ENV', choices: ['qa', 'dev'], description: 'Target environment (maps to config/env.yaml)')
        string(name: 'TAGS', defaultValue: '', description: 'Optional: only run tests with these tags (e.g. smoke OR api)')
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
        VENV          = '.venv'
        RESULTS_DIR   = 'results'
        ALLURE_DIR    = 'results/allure'
        // Selenium/Chrome: ensure a headless-capable driver is on the agent
        ENV_TARGET    = "${params.ENV}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup Python venv') {
            steps {
                sh '''
                    set -eux
                    python3 -m venv "${VENV}"
                    . "${VENV}/bin/activate"
                    python -m pip install --upgrade pip
                    pip install -r requirements.txt
                    robot --version || true
                '''
            }
        }

        stage('Lint / Dry Run') {
            steps {
                sh '''
                    set -eux
                    . "${VENV}/bin/activate"
                    # Dry run validates keywords/imports without executing tests
                    robot --dryrun --output NONE --report NONE --log NONE tests/ || true
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                sh '''
                    set -eux
                    . "${VENV}/bin/activate"
                    mkdir -p "${RESULTS_DIR}" "${ALLURE_DIR}"

                    TARGET="tests/"
                    if [ -n "${SUITE}" ]; then
                        TARGET="tests/${SUITE}"
                    fi

                    TAG_ARGS=""
                    if [ -n "${TAGS}" ]; then
                        TAG_ARGS="--include ${TAGS}"
                    fi

                    robot \
                        --variable ENV:${ENV_TARGET} \
                        --variable HEADLESS:${HEADLESS} \
                        --outputdir "${RESULTS_DIR}" \
                        --listener allure_robotframework:${ALLURE_DIR} \
                        --xunit xunit.xml \
                        ${TAG_ARGS} \
                        "${TARGET}"
                '''
            }
        }

        stage('Generate Metrics Report') {
            steps {
                sh '''
                    set -eux
                    . "${VENV}/bin/activate"
                    cd "${RESULTS_DIR}"
                    # robotframework-metrics: builds an HTML dashboard from output.xml
                    robotmetrics --inputpath . --output output.xml || true
                '''
            }
        }
    }

    post {
        always {
            // JUnit/xUnit results for trend graphs
            junit testResults: "${RESULTS_DIR}/xunit.xml", allowEmptyResults: true

            // Robot HTML report + logs
            archiveArtifacts artifacts: "${RESULTS_DIR}/**", allowEmptyArchive: true, fingerprint: true

            // If the Robot Framework Jenkins plugin is installed:
            robot(
                outputPath: "${RESULTS_DIR}",
                outputFileName: 'output.xml',
                reportFileName: 'report.html',
                logFileName: 'log.html',
                passThreshold: 90.0,
                unstableThreshold: 75.0,
                disableArchiveOutput: false,
                otherFiles: '**/*.png'
            )

            // If the Allure Jenkins plugin is installed:
            allure includeProperties: false, jdk: '', results: [[path: "${ALLURE_DIR}"]]
        }
        cleanup {
            cleanWs()
        }
    }
}
