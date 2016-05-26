require "rails_helper"

describe GithubService do
  VCR.use_cassette("github_service") do
    it 'returns a list of all organizations' do
      service = GithubService.new("treyx")
      organizations = service.organizations

      expect(organizations.count).to eq 2
      expect(organizations.first[:login]).to eq "captainu"
      expect(organizations.last[:login]).to eq "turingschool"
    end

    it "returns all repos" do
      service = GithubService.new("treyx")
      repos = service.repos
      expect(repos.count).to eq 26
      expect(repos.first[:name]).to eq "apicurious"
    end

    it "returns a list of commits" do
      service = GithubService.new("treyx")
      commits = service.recent_pushes
      expect(commits.count).to eq 4
      expect(commits.first[:type]).to eq "PushEvent"
      expect(commits.first[:payload][:commits].first[:message]).to eq "work email"
    end

    it "returns a list pull requests" do
      service = GithubService.new("treyx")
      pull_requests = service.recent_pull_requests
      expect(pull_requests.count).to eq 3
      expect(pull_requests.last[:type]).to eq "PullRequestEvent"
      expect(pull_requests.first[:payload][:pull_request][:title]).to eq "removing tincan role"
      expect(pull_requests.first[:payload][:pull_request][:body]).to eq "I've removed the tincan_role capistrano role, this will now be defined within the application itself so we have more control over where we want this running. "
    end

    it "returns a list of issues" do
      service = GithubService.new("treyx")
      issues = service.recent_issues
      expect(issues.count).to eq 3
      expect(issues.last[:type]).to eq "IssueCommentEvent"
      expect(issues.last[:type]).to eq "IssueCommentEvent"
    end

    it "returns all followers" do
      service = GithubService.new("treyx")
      followers = service.followers_hash
      expect(followers.count).to eq 30
      expect(followers.first[:login]).to eq "DSynergy"
    end

    it "returns following" do
      service = GithubService.new("treyx")
      following = service.following_hash
      expect(following.count).to eq 30
      expect(following.first[:login]).to eq "wycats"
    end

    it "returns starred objects" do
      service = GithubService.new("treyx")
      starred = service.starred_hash
      expect(starred.count).to eq 30
      expect(starred.first[:name]).to eq "sqs-to-lambda"
    end
  end
end
