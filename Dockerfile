FROM python:3.9-alpine

WORKDIR /usr/src/app

# Oracle Client Download and Setup
ENV LD_LIBRARY_PATH="/usr/lib/instantclient"
RUN apk add --no-cache libaio libnsl libc6-compat libffi-dev build-base openssl-dev &&\
    wget --no-check-certificate https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basiclite-linux.x64-21.1.0.0.0.zip -O /tmp/instantclient.zip &&\
    unzip /tmp/instantclient.zip -d /tmp/ && rm -r /tmp/instantclient.zip &&\
    mv /tmp/instantclient_21_1 ${LD_LIBRARY_PATH} &&\
    ln -s ${LD_LIBRARY_PATH}/libclntsh.so.21.1 /usr/lib/libclntsh.so && \
    ln -s ${LD_LIBRARY_PATH}/libocci.so.21.1 /usr/lib/libocci.so && \
    ln -s ${LD_LIBRARY_PATH}/libociicus.so /usr/lib/libociicus.so && \
    ln -s ${LD_LIBRARY_PATH}/libnnz19.so /usr/lib/libnnz19.so && \
    ln -s /usr/lib/libnsl.so.2 /usr/lib/libnsl.so.1 && \
    ln -s /lib/libc.so.6 /usr/lib/libresolv.so.2 && \
    ln -s /lib64/ld-linux-x86-64.so.2 /usr/lib/ld-linux-x86-64.so.2

# Chrome and Chrome Driver Setup
RUN apk add --no-cache chromium chromium-chromedriver xvfb

# Adding exclusions for the zscaler-ca
COPY cacerts.pem /tmp/cacerts.pem
RUN cat /tmp/cacerts.pem >> /usr/local/lib/python3.9/site-packages/pip/_vendor/certifi/cacert.pem

# Installing Requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && cat /tmp/cacerts.pem >> $(python -m certifi)

COPY webui.robot .

ENV DISPLAY=:99

#CMD [ "robot", "--variable", "BROWSER:chrome", "--outputdir", "results", "webui.robot" ]
CMD [ "robot", "--outputdir", "results", "webui.robot" ]
