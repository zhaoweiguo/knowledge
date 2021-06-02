git fetch命令
#################

::

  $ git remote add upstream https://github.com/yeasy/blockchain_guide
  $ git fetch upstream

Check out, review, and merge locally::

    Step 1. Fetch and check out the branch for this merge request:
    git fetch git@gitlab.com:zhaowg3/cloud.git kafka-migrate
    git checkout -b zhaowg3/cloud-kafka-migrate FETCH_HEAD

    Step 2. Review the changes locally

    Step 3. Merge the branch and fix any conflicts that come up:
    git fetch origin
    git checkout origin/v4.6.3
    git merge --no-ff zhaowg3/cloud-kafka-migrate

    Step 4. Push the result of the merge to GitLab:
    git push origin v4.6.3






