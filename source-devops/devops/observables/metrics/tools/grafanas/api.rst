API
#########

更新创建DashBoard [1]_
======================

* POST /api/dashboards/db

请求::

    POST /api/dashboards/db HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    Authorization: Bearer eyJrIjoiT0tTcG1pUlY2RnVKZTFVaDFsNFZXdE9ZWmNrMkZYbk

    {
      "dashboard": {
        "id": null,
        "uid": null,
        "title": "Production Overview",
        "tags": [ "templated" ],
        "timezone": "browser",
        "schemaVersion": 16,
        "version": 0
      },
      "folderId": 0,
      "overwrite": false
    }

    dashboard – The complete dashboard model, id = null to create a new dashboard.
    dashboard.id – id = null to create a new dashboard.
    dashboard.uid – Optional unique identifier when creating a dashboard. uid = null will generate a new uid.
    folderId – The id of the folder to save the dashboard in.
    overwrite – Set to true if you want to overwrite existing dashboard with newer version, same dashboard title in folder or same dashboard uid.
    message - Set a commit message for the version history.

返回::

    HTTP/1.1 200 OK
    Content-Type: application/json; charset=UTF-8
    Content-Length: 78

    {
      "id":      1,
      "uid":     "cIBgcSjkk",
      "url":     "/d/cIBgcSjkk/production-overview",
      "status":  "success",
      "version": 1,
      "slug":    "production-overview" //deprecated in Grafana v5.0
    }





.. [1] https://grafana.com/docs/http_api/dashboard/