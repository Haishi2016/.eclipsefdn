local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('iot.symphony', 'eclipse-symphony') {
  settings+: {
    description: "",
    name: "Eclipse Symphony",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  _repositories+:: [
    orgs.newRepo('docs') {
      description: "Symphony documentation",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      homepage: "https://eclipse-symphony.github.io/docs",
      has_projects: false,
      has_wiki: false,
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('symphony') {
      description: "Symphony project",
      has_discussions: true,
      has_projects: false,
      has_wiki: false,
      secrets: [
        orgs.newRepoSecret('BOT_GITHUB_TOKEN') {
          value: "pass:bots/iot.symphony/github.com/api-token",
        },
      ],
      branch_protection_rules: [
        # https://otterdog.readthedocs.io/en/stable/reference/organization/repository/branch-protection-rule/
        orgs.newBranchProtectionRule("main") {
          dismisses_stale_reviews: true,
          requires_pull_request: true,
          required_approving_review_count: 1,
          requires_status_checks: false,
          requires_conversation_resolution: true,
          bypass_pull_request_allowances+: [
            "@eclipse-symphony-bot",
            "user:Haishi2016",
            "@Haishi2016",
          ],
        },
      ],
    },
    orgs.newRepo('symphony-website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "Symphony project website",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      homepage: "https://eclipse-symphony.github.io/symphony-website",
      web_commit_signoff_required: false,
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}