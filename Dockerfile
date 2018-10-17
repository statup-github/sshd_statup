FROM phusion/baseimage

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN rm -f /etc/service/sshd/down
EXPOSE 22

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN mkdir -p /root/.ssh \
  && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/M4ZcWZU01b8SQgyUvaG4lRBXvNVvMZVy27/2klIK6/TZQLsMB/o6xBvumMx/v2D+iqvLozUGk2JgyxZP/1pvh9IOIHkUhNsNhSjXJAqnlP1uOR1cJlwM6YOq5/TsH/G2ao7b/VMsM70JNL85+04agYklHdednEx8kJUcnOw2/6fGVAJvuUqzb2DLFMILLkp1V38MhD2F2D1hJxD9uiRMxf6LEikON815MOjatJSyecWGa5qPe1l/ol5sEcQ2Izx8SP/yfa/oYvWNfasOIGOjfE/xkkES6RxDezj73wJTb/rOFwQMso8aJzKRXhtTCOmPPCzGeGlp+pHjdvXBQmEDKmUwd1IjWYxeeJnY3G8drH6eP9YZVDieaqSQD4eoiZrb3GKn1dpWIf2WS/BDOcGo79+whcn2my191Ii4mh8EAZnER5HxJM+7RHfoSQMylKdZv7lWmzQp1hn72g3gFPymPemG48mknKOuMwghQhPP2h1YVRzYXAT0DE6eZWCt62GDtfV7huIsRVNXPFCR17y9URv01ecNV9mQ/Dt1z1G91UID/4WInwCpGqa7FI0sNoUP03vSZZgQwd1osdA4cG4djkeQbr2KHxEI3evct1KNW7GuZrhNZzaGPrtEviHi8qwA5B7BX2/ppF0RUSSHECJDyqAi+4KGCwsOG55ft9wIQ== root@control-0" > /root/.ssh/authorized_keys

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
