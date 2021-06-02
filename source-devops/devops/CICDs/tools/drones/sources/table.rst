表
######

builds表::

    sqlite> .schema builds
    CREATE TABLE builds (
         build_id            INTEGER PRIMARY KEY AUTOINCREMENT
        ,build_repo_id       INTEGER      83
        ,build_trigger       TEXT         @hook
        ,build_number        INTEGER      1
        ,build_parent        INTEGER      0
        ,build_status        TEXT         failure
        ,build_error         TEXT         
        ,build_event         TEXT         push
        ,build_action        TEXT         
        ,build_link          TEXT         http://gitlab.com/tools/analysis-backend/commit/5e9980fxxx
        ,build_timestamp     INTEGER      0
        ,build_title         TEXT         整理封装
        ,build_message       TEXT         
        ,build_before        TEXT         
        ,build_after         TEXT         5e9980fe964afb59bae823664115dc0cccbc10c2
        ,build_ref           TEXT         refs/heads/master
        ,build_source_repo   TEXT         
        ,build_source        TEXT         master
        ,build_target        TEXT         master
        ,build_author        TEXT         zhaoweiguo
        ,build_author_name   TEXT         zhaoweiguo
        ,build_author_email  TEXT         admin@zhaoweiguo.com
        ,build_author_avatar TEXT         https://www.gravatar.com/avatar/a11d9xxx
        ,build_sender        TEXT         zhaoweiguo
        ,build_deploy        TEXT
        ,build_params        TEXT         null
        ,build_started       INTEGER      1570883277
        ,build_finished      INTEGER      1570883314
        ,build_created       INTEGER      1570883277
        ,build_updated       INTEGER      1570883277
        ,build_version       INTEGER      3
        , build_cron TEXT NOT NULL DEFAULT '',UNIQUE(build_repo_id, build_number)
    );
    CREATE INDEX ix_build_repo ON builds (build_repo_id);
    CREATE INDEX ix_build_author ON builds (build_author);
    CREATE INDEX ix_build_sender ON builds (build_sender);
    CREATE INDEX ix_build_ref ON builds (build_repo_id, build_ref);
    CREATE INDEX ix_build_incomplete ON builds (build_status)
    WHERE build_status IN ('pending', 'running');

    1|83|@hook|1|0|failure||push||http://gitcodecloud.zhaoweiguo.com.cn/tools/analysis-backend/commit/5e9980fe964afb59bae823664115dc0xxxxxx|0||整理封装
    ||5e9980fe964afb59bae823664115dc0cxxxx|refs/heads/master||master|master|zhaoweiguo|zhaoweiguo||https://www.gravatar.com/avatar/a11d9508187d0744109511002cxxx?s=80&d=identicon|zhaoweiguo||null|1570883277|1570883314|1570883277|1570883277|3|


log表::

    sqlite> .schema logs
    CREATE TABLE logs (
     log_id    INTEGER PRIMARY KEY
    ,log_data  BLOB
    ,FOREIGN KEY(log_id) REFERENCES steps(step_id) ON DELETE CASCADE
    );

    54|[{"pos":0,"out":"+ go build -o test-drone\n","time":0}]
    55|[{"pos":0,"out":"+ /usr/local/bin/dockerd --data-root /var/lib/docker\n","time":0},{"pos":1,"out":"time=\"2019-10-13T08:50:15Z\" level=fatal msg=\"Error authenticating: exit status 1\"\n","time":1}]
    56|[{"pos":0,"out":"2019/10/13 08:50:20 send message success!\n","time":0}]
    57|[{"pos":0,"out":"Initialized empty Git repository in /drone/src/.git/\n","time":0},{"pos":1,"out":"+ git fetch origin +refs/heads/master:\n","time":0},{"pos":2,"out":"From http://gitcodecloud.zhaoweiguo.com.cn/zhaoweiguo/test-drone2\n","time":0},{"pos":3,"out":" * branch            master     -\u003e FETCH_HEAD\n","time":0},{"pos":4,"out":" * [new branch]      master     -\u003e origin/master\n","time":0},{"pos":5,"out":"+ git checkout 2e9cbb1406862bedabfbe853cddxxxxxx -b master\n","time":0},{"pos":6,"out":"Already on 'master'\n","time":0}]
    58|[{"pos":0,"out":"+ go build -o test-drone\n","time":0}]

node表::

    sqlite> .schema nodes
    CREATE TABLE nodes (
         node_id         INTEGER PRIMARY KEY AUTOINCREMENT
        ,node_uid        TEXT
        ,node_provider   TEXT
        ,node_state      TEXT
        ,node_name       TEXT
        ,node_image      TEXT
        ,node_region     TEXT
        ,node_size       TEXT
        ,node_os         TEXT
        ,node_arch       TEXT
        ,node_kernel     TEXT
        ,node_variant    TEXT
        ,node_address    TEXT
        ,node_capacity   INTEGER
        ,node_filter     TEXT
        ,node_labels     TEXT
        ,node_error      TEXT
        ,node_ca_key     TEXT
        ,node_ca_cert    TEXT
        ,node_tls_key    TEXT
        ,node_tls_cert   TEXT
        ,node_tls_name   TEXT
        ,node_paused     BOOLEAN
        ,node_protected  BOOLEAN
        ,node_created    INTEGER
        ,node_updated    INTEGER
        ,node_pulled     INTEGER

        ,UNIQUE(node_name)
    );

perms表::

    sqlite> .schema perms
    CREATE TABLE perms (
     perm_user_id  INTEGER
    ,perm_repo_uid TEXT
    ,perm_read     BOOLEAN
    ,perm_write    BOOLEAN
    ,perm_admin    BOOLEAN
    ,perm_synced   INTEGER
    ,perm_created  INTEGER
    ,perm_updated  INTEGER
    ,PRIMARY KEY(perm_user_id, perm_repo_uid)
    );
    CREATE INDEX ix_perms_user ON perms (perm_user_id);
    CREATE INDEX ix_perms_repo ON perms (perm_repo_uid);

    1|103|1|0|0|0|1570865183|1570954767

secrets表::

    sqlite> .schema secrets
    CREATE TABLE secrets (
       secret_id                INTEGER PRIMARY KEY AUTOINCREMENT
      ,secret_repo_id           INTEGER
      ,secret_name              TEXT
      ,secret_data              BLOB
      ,secret_pull_request      BOOLEAN
      ,secret_pull_request_push BOOLEAN
      ,UNIQUE(secret_repo_id, secret_name)
      ,FOREIGN KEY(secret_repo_id) REFERENCES repos(repo_id) ON DELETE CASCADE
    );
    CREATE INDEX ix_secret_repo ON secrets (secret_repo_id);
    CREATE INDEX ix_secret_repo_name ON secrets (secret_repo_id, secret_name);

    1|83|dingding|d4a22b306d1c15a9e80504087cde8e637b8c66fa024554ffef0xxxxxx|0|0
    2|83|docker_user|luxl2@14177974xxxxx|0|0

steps表::

    sqlite> .schema steps
    CREATE TABLE steps (
         step_id          INTEGER PRIMARY KEY AUTOINCREMENT
        ,step_stage_id    INTEGER
        ,step_number      INTEGER
        ,step_name        TEXT
        ,step_status      TEXT
        ,step_error       TEXT
        ,step_errignore   BOOLEAN
        ,step_exit_code   INTEGER
        ,step_started     INTEGER
        ,step_stopped     INTEGER
        ,step_version     INTEGER
        ,UNIQUE(step_stage_id, step_number)
        ,FOREIGN KEY(step_stage_id) REFERENCES stages(stage_id) ON DELETE CASCADE
    );
    CREATE INDEX ix_steps_stage ON steps (step_stage_id);

    49|13|1|clone|success||0|0|1570955086|1570955087|4
    50|13|2|编译|success||0|0|1570955087|1570955091|4
    51|13|3|构建镜像|success||0|0|1570955091|1570955227|4
    52|13|4|钉钉通知|success||0|0|1570955227|1570955238|4

cron表::

    sqlite> .schema cron
    CREATE TABLE cron (
         cron_id          INTEGER PRIMARY KEY AUTOINCREMENT
        ,cron_repo_id     INTEGER
        ,cron_name        TEXT
        ,cron_expr        TEXT
        ,cron_next        INTEGER
        ,cron_prev        INTEGER
        ,cron_event       TEXT
        ,cron_branch      TEXT
        ,cron_target      TEXT
        ,cron_disabled    BOOLEAN
        ,cron_created     INTEGER
        ,cron_updated     INTEGER
        ,cron_version     INTEGER
        ,UNIQUE(cron_repo_id, cron_name)
        ,FOREIGN KEY(cron_repo_id) REFERENCES repos(repo_id) ON DELETE CASCADE
    );
    CREATE INDEX ix_cron_repo ON cron (cron_repo_id);
    CREATE INDEX ix_cron_next ON cron (cron_next);

migrations表::

    sqlite> .schema migrations
    CREATE TABLE migrations (
     name VARCHAR(255)
    ,UNIQUE(name)
    );

    create-table-users
    create-table-repos

orgsecrets表::

    sqlite> .schema orgsecrets
    CREATE TABLE orgsecrets (
         secret_id                INTEGER PRIMARY KEY AUTOINCREMENT
        ,secret_namespace         TEXT COLLATE NOCASE
        ,secret_name              TEXT COLLATE NOCASE
        ,secret_type              TEXT
        ,secret_data              BLOB
        ,secret_pull_request      BOOLEAN
        ,secret_pull_request_push BOOLEAN
        ,UNIQUE(secret_namespace, secret_name)
    );

repos表::

    sqlite> .schema repos
    CREATE TABLE repos (
         repo_id                    INTEGER PRIMARY KEY AUTOINCREMENT
        ,repo_uid                   TEXT            117
        ,repo_user_id               INTEGER         1
        ,repo_namespace             TEXT            zhaoweiguo
        ,repo_name                  TEXT            test-drone
        ,repo_slug                  TEXT            zhaoweiguo
        ,repo_scm                   TEXT            
        ,repo_clone_url             TEXT            http://gitlab.com/zhaoweiguo/test-drone
        ,repo_ssh_url               TEXT            git@gitlab.com:zhaoweiguo/test-drone.git
        ,repo_html_url              TEXT            
        ,repo_active                BOOLEAN         1
        ,repo_private               BOOLEAN         1
        ,repo_visibility            TEXT            private
        ,repo_branch                TEXT            master
        ,repo_counter               INTEGER         6
        ,repo_config                TEXT            .drone.yml
        ,repo_timeout               INTEGER         60
        ,repo_trusted               BOOLEAN         1
        ,repo_protected             BOOLEAN         0
        ,repo_synced                INTEGER         1570891808
        ,repo_created               INTEGER         1570891808
        ,repo_updated               INTEGER         1570954767
        ,repo_version               INTEGER         6
        ,repo_signer                TEXT            DvNWngbe7SBujanLqdxxxxxxxxxxx
        ,repo_secret                TEXT            1AlolzhvWHOFQVoTdqmxxxxxxxxxx
        ,repo_no_forks BOOLEAN NOT NULL DEFAULT 0   1
        ,repo_no_pulls BOOLEAN NOT NULL DEFAULT 0   1
        ,UNIQUE(repo_slug)
        ,UNIQUE(repo_uid)
    );

    116|117|1|zhaoweiguo|test-drone|zhaoweiguo/test-drone||http://gitcodecloud.gitlab.com.cn/zhaoweiguo/test-drone.git|git@gitcodecloud.gitlab.com.cn:zhaoweiguo/test-drone.git||1|1|private|master|6|.drone.yml|60|1|0|1570891808|1570891808|1570954767|9|EJQPedjapuBIoDWj4UGKvirxNVB49QFh|OuOm6qe4w3EXuqS2yxxxxxxxxxxxx|1|1
    117|118|1|zhaoweiguo|test-drone2|zhaoweiguo/test-drone2||http://gitcodecloud.gitlab.com.cn/zhaoweiguo/test-drone2.git|git@gitcodecloud.gitlab.com.cn:zhaoweiguo/test-drone2.git||1|1|private|master|3|.drone.yml|60|1|0|1570954767|1570954767|1570954767|6|DvNWngbe7SBujanLqd2Kxxxxxxxx|1AlolzhvWHOFQVoTdqm7Ybxxxxxxxx|1|1

stages表::

    sqlite> .schema stages
    CREATE TABLE stages (
         stage_id          INTEGER PRIMARY KEY AUTOINCREMENT
        ,stage_repo_id     INTEGER      83
        ,stage_build_id    INTEGER      5
        ,stage_number      INTEGER      1
        ,stage_kind        TEXT
        ,stage_type        TEXT
        ,stage_name        TEXT         demo-go
        ,stage_status      TEXT         failure
        ,stage_error       TEXT         
        ,stage_errignore   BOOLEAN      0
        ,stage_exit_code   INTEGER      1
        ,stage_limit       INTEGER      0
        ,stage_os          TEXT         linux
        ,stage_arch        TEXT         amd64
        ,stage_variant     TEXT         
        ,stage_kernel      TEXT         
        ,stage_machine     TEXT         a9578114bf36
        ,stage_started     INTEGER      1570886974
        ,stage_stopped     INTEGER      1570886974
        ,stage_created     INTEGER      1570886974
        ,stage_updated     INTEGER      1570886974
        ,stage_version     INTEGER      4
        ,stage_on_success  BOOLEAN      1
        ,stage_on_failure  BOOLEAN      0
        ,stage_depends_on  TEXT         null
        ,stage_labels      TEXT         null
        ,UNIQUE(stage_build_id, stage_number)
        ,FOREIGN KEY(stage_build_id) REFERENCES builds(build_id) ON DELETE CASCADE
    );
    CREATE INDEX ix_stages_build ON stages (stage_build_id);
    CREATE INDEX ix_stage_in_progress ON stages (stage_status)
    WHERE stage_status IN ('pending', 'running');

    5|83|5|1|||demo-go|failure||0|1|0|linux|amd64|||a9578114bf36|1570886974|1570887104|1570886974|1570887104|4|1|0|null|null

users表::

    sqlite> .schema users
    CREATE TABLE users (
         user_id            INTEGER PRIMARY KEY AUTOINCREMENT
        ,user_login         TEXT COLLATE NOCASE
        ,user_email         TEXT
        ,user_admin         BOOLEAN         1
        ,user_machine       BOOLEAN         0
        ,user_active        BOOLEAN         1
        ,user_avatar        TEXT
        ,user_syncing       BOOLEAN         0
        ,user_synced        INTEGER         1570954767
        ,user_created       INTEGER         1570954767
        ,user_updated       INTEGER         1570954767
        ,user_last_login    INTEGER         1570954767
        ,user_oauth_token   TEXT            237e2477ca13bf86b5cd965962951cd45xxx
        ,user_oauth_refresh TEXT            6c4f555c0bbe761a1467a481e2e112dfbxxx
        ,user_oauth_expiry  INTEGER         1570952353
        ,user_hash          TEXT            9j0gPHtP49LTvWUpqJAsxxxxxxxxx
        ,UNIQUE(user_login COLLATE NOCASE)
        ,UNIQUE(user_hash)
    );

    1|zhaoweiguo|admin@zhaoweiguo.com|1|0|1|https://www.gravatar.com/avatar/a11d9508187d0744109511002c5dfd26?s=80&d=identicon|0|1570954767|1570864780|1570864780|1570952353|237e2477ca13bf86b5cd965962951cd45c86446120f59d9831092xxxxxxxxx|6c4f555c0bbe761a1467a481e2e112dfb562e37044b27998ade6aexxxxxxxxx|1570952353|9j0gPHtP49LTvWUpqJAxxxxxxxx






