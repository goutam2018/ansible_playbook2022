---
- name: To install tomcat server on RHEL & Debian OS. 
  hosts: all
  become: true
  tasks: 
  - name: to install java pkg on RHEL
    yum:
      name: java
      state: installed
    when: ansible_os_family == "RedHat"

  - name: install jdk on debian
    apt: 
      name: default-jdk
      state: present
    when: ansible_os_family == "Debian"

  - name: download tomcat pkg
    ansible.builtin.uri:
      url: https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.84/bin/apache-tomcat-8.5.84.tar.gz
      dest: /opt

  - name: to unarchive tomcat pkg
    unarchive:
      src: /opt/apache-tomcat-8.5.84.tar.gz
      dest: /opt
      remote_src: yes     

  - name: to ptovide permission
    file:
      path: /opt/apache-tomcat-8.5.84/bin/startup.sh
      mode: 0777
  
  - name: to start service
    shell: nohup ./startup.sh
    args:
      chdir: /opt/apache-tomcat-8.5.84/bin
