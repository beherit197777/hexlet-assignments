# frozen_string_literal: true

# BEGIN
require 'octokit'
# END

class GitHubService
  class << self
    def call(link)
      owner_and_repo = Octokit::Repository.from_url(link)

      response = Octokit::Client.new.repo(
        owner: owner_and_repo.owner,
        repo: owner_and_repo.repo
      )

      attr = {
        owner_name: owner_and_repo.owner,
        repo_name: owner_and_repo.repo,
        link: owner_and_repo.url,
        description: response[:description],
        default_branch: response[:default_branch],
        watchers_count: response[:watchers_count],
        language: response[:language],
        repo_created_at: response[:created_at],
        repo_updated_at: response[:updated_at]
      }
      repo = Repository.new(attr)
      repo.save
      repo
    rescue StandardError
      Repository.new
    end
  end
end