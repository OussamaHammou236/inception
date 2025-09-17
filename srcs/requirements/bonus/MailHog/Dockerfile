# FROM debian:bullseye

# RUN apt-get update && apt-get install -y \
#     golang-go \
#     git \
#     ca-certificates \
#     && rm -rf /var/lib/apt/lists/*

# RUN go install github.com/mailhog/MailHog@latest \
#     && go install github.com/mailhog/mhsendmail@latest

# EXPOSE 1025 8025

FROM debian:bullseye

RUN apt-get update && apt-get install -y wget ca-certificates

RUN wget -qO /usr/local/bin/MailHog https://github.com/mailhog/MailHog/releases/download/v1.0.1/MailHog_linux_amd64 \
    && chmod +x /usr/local/bin/MailHog

RUN wget -qO /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 \
    && chmod +x /usr/local/bin/mhsendmail

CMD ["MailHog"]
