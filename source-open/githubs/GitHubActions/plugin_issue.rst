Issue相关插件
#############


Close Issue
===========


实例::

    name: Close as a support issue
    on:
      issues:
        types: [labeled]

    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
        - name: Close Issue
          uses: peter-evans/close-issue@v1
          if: contains(github.event.issue.labels.*.name, 'support')
          with:
            comment: |
              Sorry, but we'd like to keep issues related to code in this repository. Thank you 🙇 

* https://github.com/actions/starter-workflows/blob/main/.github/workflows/label-support.yml




