GitHub Action插件
#################

Upload-Artifact
---------------

构件允许您在作业完成后保留数据，并与同一工作流程中的另一个作业共享该数据。 构件是指在工作流程运行过程中产生的文件或文件集。 例如，在工作流程运行结束后，您可以使用构件保存您的构建和测试输出。

By default, GitHub stores build logs and artifacts for 90 days, and this retention period can be customized. 

* 官网: https://github.com/actions/upload-artifact

实例::

    steps:
    - uses: actions/checkout@v2

    - run: mkdir -p path/to/artifact

    - run: echo hello > path/to/artifact/world.txt

    - uses: actions/upload-artifact@v2
      with:
        name: my-artifact
        path: path/to/artifact/world.txt

Download-Artifact
-----------------

* 官网: https://github.com/actions/download-artifact

实例::

    steps:
    - uses: actions/checkout@v2

    - uses: actions/download-artifact@v2
      with:
        name: my-artifact
        
    - name: Display structure of downloaded files
      run: ls -R

webhook
-------

* 官网: https://github.com/marketplace/actions/fast-webhook

实例::

    uses: jasongitmail/fast-webhook@v1
    with:
      url: ${{ secrets.WEBHOOK_URL }}
      json: '{"foo": "bar"}'



Sphinx Build
------------

* 官网: https://github.com/marketplace/actions/sphinx-build
* 实例: https://github.com/ammaraskar/sphinx-action-test

示例::

    name: "Pull Request Docs Check"
    on: 
    - pull_request

    jobs:
      docs:
        runs-on: ubuntu-latest
        steps:
        - uses: actions/checkout@v1
        - uses: ammaraskar/sphinx-action@master
          with:
            docs-folder: "docs/"

示例2::

    - uses: ammaraskar/sphinx-action@master
      with:
        docs-folder: "docs/"
        build-command: "sphinx-build -b html . _build"

示例3::

    - uses: ammaraskar/sphinx-action@master
      with:
        docs-folder: "docs2/"
        pre-build-command: "apt-get update -y && apt-get install -y latexmk texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended"
        build-command: "make latexpdf"




GitHub Push
-----------

* 官网: https://github.com/ad-m/github-push-action

示例::

    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
        - uses: actions/checkout@master
          with:
            persist-credentials: false # otherwise, the token used is the GITHUB_TOKEN, instead of your personal token
            fetch-depth: 0 # otherwise, you will failed to push refs to dest repo
        - name: Create local changes
          run: |
            ...
        - name: Commit files
          run: |
            git config --local user.email "action@github.com"
            git config --local user.name "GitHub Action"
            git commit -m "Add changes" -a
        - name: Push changes
          uses: ad-m/github-push-action@master
          with:
            github_token: ${{ secrets.GITHUB_TOKEN }}
            branch: ${{ github.ref }}
            directory: gh-pages
            repository: zhaoweiguo/demo

Build and push Docker images
----------------------------

* 官网: https://github.com/marketplace/actions/build-and-push-docker-images


安装java环境
------------

* 官网: https://github.com/actions/setup-java

示例::

    steps:
    - uses: actions/checkout@v2
    - uses: actions/setup-java@v1
      with:
        java-version: '9.0.4' # The JDK version to make available on the path.
        java-package: jdk # (jre, jdk, or jdk+fx) - defaults to jdk
        architecture: x64 # (x64 or x86) - defaults to x64
    - run: java -cp java HelloWorldApp





