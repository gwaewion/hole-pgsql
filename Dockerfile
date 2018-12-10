FROM alpine:latest
LABEL maintainer="gwaewion@gmail.com"
EXPOSE 5432
VOLUME /data
COPY run.sh /root

ENV POSTGRES_DATAPATH /data
ENV POSTGRES_PASSWORD password

RUN apk update && apk add postgresql
	
CMD ["sh", "/root/run.sh"]