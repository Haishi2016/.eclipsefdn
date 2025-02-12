local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-symphony') {
  settings+: {
    description: "",
    name: "Eclipse Symphony",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  _repositories+:: [
    orgs.newRepo('symphony') {
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "doc-site",
      gh_pages_source_path: "/landing/public",
      description: "Symphony project",
      has_discussions: true,
      has_projects: false,
      has_wiki: false,
      secrets: [
        orgs.newRepoSecret('BOT_GITHUB_TOKEN') {
          value: "pass:bots/iot.symphony/github.com/api-token",
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "doc-site"
          ],
          deployment_branch_policy: "selected",
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
          ],
        },
      ],
    },
    orgs.newRepo('symphony-website') {
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "Symphony project website",
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
}
