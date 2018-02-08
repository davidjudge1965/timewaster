FROM postgres:9.5
#
#

RUN update-rc.d postgresql enable
RUN service postgresql restart

# RUN    /etc/init.d/postgresql start &&\
run echo "Sleeping for a while"
RUN sleep 20
run echo "DONE Sleeping for a while"
RUN    psql --command "create role ddload login password 'ddload';" 
RUN    psql --command "CREATE SCHEMA test;" 
RUN    psql --command "GRANT ALL ON SCHEMA test TO ddload;" 
RUN    psql --command "create table test.consumecpu (result varchar(128));" 
RUN    psql --command "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA test TO ddload;" 
RUN    psql --command "create user datadog with password 'iXqadU3qIZpyYCYEessha7KZ';" 
RUN    psql --command "grant SELECT ON pg_stat_database to datadog;"

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.5/main/pg_hba.conf
RUN echo "host all all 192.168.0.0/16 md5" >> /etc/postgresql/9.5/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.5/main/postgresql.conf

# Expose the PostgreSQL port
# sudo sed -i.bak "s/# - Connection Settings -/listen_addresses = '*'/g" /etc/postgresql/9.5/main/postgresql.conf
# sudo echo "host all all * md5" >> /tmp/pg_hba.conf2
# sudo echo "host all all 192.168.0.0/16 md5" >> /tmp/pg_hba.conf2
# sudo cat /etc/postgresql/9.5/main/pg_hba.conf /tmp/pg_hba.conf2 >/tmp/pg_hba.conf3
# sudo cp /tmp/pg_hba.conf3 /etc/postgresql/9.5/main/pg_hba.conf

# RUN sudo update-rc.d postgresql enable
# RUN sudo service postgresql restart

ENV PG_MAJOR 9.5
ENV PATH $PATH:/usr/lib/postgresql/$PG_MAJOR/bin
ENV PGDATA /var/lib/postgresql/data


EXPOSE 5432

ENTRYPOINT ["docker-entrypoint.sh"]


CMD ["postgres"]
