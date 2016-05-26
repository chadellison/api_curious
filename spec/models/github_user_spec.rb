require "rails_helper"

describe GithubUser do
  VCR.use_cassette("github_user") do
    it "displays public 'organizations'" do
      organizations = GithubUser.new(login: "treyx").organizations
      expect(organizations.count).to eq 2
      expect(organizations.first[:login]).to eq "captainu"
    end

    it "displays all repos" do
      repos = GithubUser.new(login: "chadellison").repos
      expect(repos.count).to eq 30
      expect(repos.first).to eq "1511_task_manager"
    end

    it "displays recent commits" do
      commits = GithubUser.new(login: "treyx").recent_pushes
      expect(commits.count).to eq 4
      expect(commits.first).to eq ["work email"]
    end

    it "displays recent pull requests" do
      pull_requests = GithubUser.new(login: "treyx").recent_pull_requests
      expect(pull_requests.count).to eq 3
      expect(pull_requests.first).to eq "I've removed the tincan_role capistrano role, this will now be defined within the application itself so we have more control over where we want this running. "
    end

    it "displays issues" do
      issues = GithubUser.new(login: "treyx").issues
      expect(issues.count).to eq 3
      expect(issues.first).to eq ["Update supported os", "Repo: chef-cookbooks/iptables", "created"]
    end

    it "displays followers" do
      followers = GithubUser.new(login: "treyx").followers
      expect(followers.count).to eq 30
      expect(followers.first[:login]).to eq "DSynergy"
    end

    it "displays following" do
      following = GithubUser.new(login: "treyx").following
      expect(following.count).to eq 30
      expect(following.first[:login]).to eq "wycats"
    end

    it "displays starred objects" do
      starred = GithubUser.new(login: "treyx").starred
      expect(starred.count).to eq 30
      expect(starred.first[:name]).to eq "sqs-to-lambda"
    end
  end
end
