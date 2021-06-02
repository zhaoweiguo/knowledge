Specification
####################

struct::

    interface Resource {
      kind: string;
      type: string;
      name: string;
    }

    class Pipeline : Resource {
      kind:     string;
      type:     string;
      name:     string;
      platform: Platform;
      clone:    Clone;
      steps:    Step[];
      volumes:  Volume[];
      node:     [string, string];
      trigger:  Conditions;

      image_pull_secrets: string[]
    }

    class Platform {
      os:      OS;
      arch:    Arch;
      variant: string;
      version: string;
    }

    class Clone {
      depth:   number;
      disable: boolean;
    }

    class Step {
      name:        string;
      image:       string;
      detach:      boolean;
      pull:        Pull;
      failure:     Failure;
      command:     string[];
      entrypoint:  string[];
      commands:    string[];
      environment: [string, string];
      volumes:     Volume[];
      when:        Conditions;
    }

    class Conditions {
      action:   Constraint | string[];
      branch:   Constraint | string[];
      cron:     Constraint | string[];
      event:    Constraint | Event[];
      instance: Constraint | string[];
      ref:      Constraint | string[];
      repo:     Constraint | string[];
      status:   Constraint | Status[];
      target:   Constraint | string[];
    }

    class Constraint {
      exclude: string[];
      include: string[];
    }

    class Secret {
      from_secret: string;
    }

enum::

    enum Event {
      cron,
      promote,
      pull_request,
      push,
      rollback,
      tag,
    }

    enum Status {
      failure,
      success,
    }


    enum Pull {
      always,
      never,
      if-not-exists,
    }


    enum Failure {
      always,
      ignore,
    }

    enum OS {
      darwin,
      dragonfly,
      freebsd,
      linux,
      netbsd,
      openbsd,
      solaris,
      windows,
    }

    enum Arch {
      386,
      amd64,
      arm64,
      arm,
    }





