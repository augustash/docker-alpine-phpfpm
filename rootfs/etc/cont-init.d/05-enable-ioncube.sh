#!/usr/bin/with-contenv bash

# enable IonCube extension
if [[ ! -z "${PHP_ENABLE_IONCUBE}" ]]; then
    echo "============> Enabling IonCube extension"
    sed -i "s/;zend_extension/zend_extension/" /etc/php7/conf.d/00-ioncube.ini
fi
