webapp:
  cmd.run:
    - name: docker run -d -p 80:8000 emattiza/reactive:latest
    - require:
      - update pkgs


update pkgs:
  pkg.uptodate:
    - refresh: true
    - require:
      - install docker

install docker:
  pkg.installed:
    - name: docker.io

