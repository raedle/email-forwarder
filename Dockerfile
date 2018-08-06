FROM alpine:3.8

LABEL Roman Rädle <contact@romanraedle.com>

# Define environment variables for forward email, imap server, username, and password.
# Set the variables here or via the `--env | -e` argument when running the docker images.
# For example, `docker run -e EF_FORWARD_EMAIL=me@example.com <image>`.
ENV EF_FORWARD_EMAIL=EF_FORWARD_EMAIL \
    EF_IMAP_SERVER=EF_IMAP_SERVER \
    EF_USERNAME=EF_USERNAME \
    EF_PASSWORD=EF_PASSWORD

# Install procmail, fetchmail, and bash.
RUN apk add --no-cache procmail fetchmail bash

# Copy .fetchmailrc configuration to root directory.
COPY .fetchmailrc /root/.fetchmailrc

# Secure .fetchmailrc configuration.
RUN chmod 600 /root/.fetchmailrc

# Copy .procmail configuration to root directory.
COPY .procmailrc /root/.procmailrc

# Copy crontab configuration to image.
COPY crontab /var/spool/cron/crontabs/root

# Copy starter-script.sh to image.
COPY starter-script.sh /

# Make starter-script.sh executable.
RUN chmod +x /starter-script.sh

# Run crond in foreground mode with the log level set to 10:
ENTRYPOINT ["./starter-script.sh"]