# Dockerized Jenkins Job Builder
[![Build Status](https://travis-ci.org/TheFynx/docker-jenkins-job-builder.svg?branch=master)](https://travis-ci.org/TheFynx/docker-jenkins-job-builder) [![GitHub release](https://img.shields.io/github/release/TheFynx/docker-jenkins-job-builder.svg?maxAge=2592000)](https://github.com/TheFynx/docker-jenkins-job-builder/releases) [![Docker Automated buil](https://img.shields.io/docker/automated/thefynx/jenkins-job-builder.svg?maxAge=2592000)](https://hub.docker.com/r/thefynx/jenkins-job-builder/) [![Docker Stars](https://img.shields.io/docker/stars/thefynx/jenkins-job-builder.svg?maxAge=2592000)](https://hub.docker.com/r/thefynx/jenkins-job-builder/) [![Docker Pulls](https://img.shields.io/docker/pulls/thefynx/jenkins-job-builder.svg?maxAge=2592000)](https://hub.docker.com/r/thefynx/jenkins-job-builder/) [![](https://images.microbadger.com/badges/image/thefynx/jenkins-job-builder.svg)](https://microbadger.com/images/thefynx/jenkins-job-builder "Get your own image badge on microbadger.com")

A [docker](http://www.docker.com) containerized version of the [Jenkins Job Builder](https://github.com/openstack-infra/jenkins-job-builder) tool. A pre-built image is available via [Docker Hub](https://hub.docker.com/r/thefynx/jenkins-job-builder)

## Tags Explanation

### Docker Tags
* Latest: Last Tag Released
* Tag: Equivalent to git tag
* Dev: Any commits to Master branch

### Tag Semantics
* jjb_version.buildnumber

## Example usage

### Print version

##### Command:

```
docker run --interactive --tty --rm \
  thefynx/jenkins-job-builder \
  jenkins-jobs --version
```

##### Output:

```
Jenkins Job Builder version: See [Releases](https://github.com/TheFynx/docker-jenkins-job-builder/releases)
```

### Test job definition

##### Assumptions:

* You have a terminal open in the `/example_job` directory of this repo

##### Command:

```
docker run --interactive --tty --rm \
  --volume "$PWD":/opt/jenkins-job \
  --workdir /opt/jenkins-job \
  thefynx/jenkins-job-builder \
  jenkins-jobs test job.yml
```

##### Output:

```
INFO:root:Will use anonymous access to Jenkins if needed.
INFO:jenkins_jobs.builder:Number of jobs generated:  1
INFO:jenkins_jobs.builder:Job name:  hello-world
<?xml version="1.0" encoding="utf-8"?>
<project>
  <actions/>
  <description>Do not edit this job through the web!&lt;!-- Managed by Jenkins Job Builder --&gt;</description>
  <keepDependencies>false</keepDependencies>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <concurrentBuild>false</concurrentBuild>
  <canRoam>true</canRoam>
  <properties/>
  <scm class="hudson.scm.NullSCM"/>
  <builders>
    <hudson.tasks.Shell>
      <command>echo 'Hello world!'</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>
INFO:jenkins_jobs.builder:Cache saved
```

### Update job definition

##### Assumptions:

* You have a terminal open in the `/example_job` directory of this repo
* You have a jenkins server running at `http://192.168.99.100:8080/`

##### Command:

```
docker run --interactive --tty --rm \
  --volume "$PWD":/opt/jenkins-job \
  --workdir /opt/jenkins-job \
  thefynx/jenkins-job-builder \
  jenkins-jobs --conf jenkins.ini update job.yml
```

##### Output:

```
INFO:root:Will use anonymous access to Jenkins if needed.
INFO:root:Updating jobs in ['job.yml'] ([])
INFO:jenkins_jobs.builder:Number of jobs generated:  1
INFO:jenkins_jobs.builder:Reconfiguring jenkins job hello-world
INFO:root:Number of jobs updated: 1
INFO:jenkins_jobs.builder:Cache saved
```

## Development

### Building

```
docker build .
```

### Testing

```
bundle install
bundle exec rspec
```
 