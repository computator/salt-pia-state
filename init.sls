openvpn:
  pkg.installed: []
  service.running:
    - enable: true
    - init_delay: 5
    - watch:
      - file: pia-conf
      - file: pia-creds
      - file: pia-script
    - require:
      - pkg: openvpn

pia-conf:
  file.managed:
    - name: /etc/openvpn/pia.conf
    - source: salt://pia/pia-vpn.conf
    - require:
      - pkg: openvpn

pia-creds:
  file.managed:
    - name: /etc/openvpn/pia.cred
    - contents_pillar: pia:creds
    - mode: 600
    - require:
      - pkg: openvpn

pia-script:
  file.managed:
    - name: /etc/openvpn/pia_manage.sh
    - mode: 755
    - source: salt://pia/pia_script.sh
    - template: jinja
    - require:
      - pkg: openvpn
