FROM centos:centos6

# Update latest packages
RUN yum -y update

# Install REMI and EPEL repositories
RUN yum -y localinstall http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum -y localinstall http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

# Install MySQL 5.5
RUN yum -y --enablerepo=remi install mysql-server

# Clean yum cache
RUN yum clean all

ENV DATADIR /var/lib/mysql
ENV ROOTPASSWD password123
ENV DBUSER wordpress
ENV DBNAME wordpress
ENV DBTESTNAME wordpress_test
ENV DBPASSWD password123
ENV DBSOURCEPATH /wordpress.sql

EXPOSE 3306

ADD docker/containers/mysql/start.sh /start.sh
ADD docker/containers/mysql/wordpress.sql /wordpress.sql

CMD ["/start.sh", "-D", "FOREGROUND"]
