require 'dockerspec'
require 'dockerspec/serverspec'
require_relative "spec_helper"

describe 'Dockerfile' do
  describe docker_build('.', tag: 'jenkins-job-builder') do
      it { should have_maintainer /Levi Smith/ }
      it { should have_env 'JJBVERSION' }

    describe docker_run('jenkins-job-builder', family: :alpine) do
      describe file('/etc/alpine-release') do
        it { should be_file }
        its(:content) { should match /^3\./ }
      end

      describe 'bash' do
        describe package('bash') do
          it { should be_installed }
        end
      end

      describe 'python' do
        it 'has python in the path' do
          expect(command('which python').exit_status).to eq 0
        end
      end

      describe 'jenkins-job-builder' do
        describe package('jenkins-job-builder') do
          it { should be_installed.by("pip").with_version(JENKINS_JOB_BUILDER_VERSION) }
        end

        it 'has jenkins-jobs in the path' do
          expect(command('which jenkins-jobs').exit_status).to eq 0
        end

        it "has jenkins job builder #{JENKINS_JOB_BUILDER_VERSION} installed" do
          expect(command("jenkins-jobs --version").stdout).to match(/^Jenkins Job Builder version: #{JENKINS_JOB_BUILDER_VERSION}/)
        end
      end
    end
  end
end
