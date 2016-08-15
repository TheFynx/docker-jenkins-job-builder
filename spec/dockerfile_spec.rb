require 'dockerspec/serverspec'
require_relative "spec_helper"

describe 'Dockerfile' do
  describe docker_build('.') do

    it { should have_maintainer /Levi Smith/ }

    describe "build" do
      describe file('/etc/alpine-release') do
        it { should be_file }
        its(:content) { should match /^3\./ }
      end

      it "installs jenkins job builder" do
        expect(package("jenkins-job-builder")).to be_installed.by("pip").with_version(JENKINS_JOB_BUILDER_VERSION)
      end
    end

    describe "run" do
      it "has python installed" do
        expect(command("python --version").stderr).to match(/^Python/)
      end

      it "has jenkins job builder #{VERSION} installed" do
        expect(command("jenkins-jobs --version").stderr).to match(/^Jenkins Job Builder version: #{JENKINS_JOB_BUILDER_VERSION}/)
      end
    end

  end
end
