# Ansible for Provisioning
서버 프로비저닝을 위한 도구로, 새로운 서버군 추가 구성 및 어플리케이션 배포 구성등을 자동화
할수 있는 도구

### Features
- Nginx, Java, Python Django 등 기본 개발환경 구축 자동화

### Tech
ansible 2.9.11

### Installation
Installation on OSX
```sh
$ brew install ansible
```

### Run
Ansible Playbook 실행
```sh
$ ansible-playbook playbooks/osx-dev-playbook.yml
or
(target변수에 hosts.yml에 지정한 호스트명을 등록하거나 all을 넣어주면 해당 호스트에서 실행)
$ ansible-playbook playbooks/osx-dev-playbook.yml --extra-vars "target=hostname"
```
