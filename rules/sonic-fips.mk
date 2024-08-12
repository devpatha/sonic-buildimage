# fips packages

FIPS_VERSION = 0.13
FIPS_OPENSSL_VERSION = 1.1.1n-0+deb11u5+fips
FIPS_OPENSSH_VERSION = 8.4p1-5+deb11u2+fips
FIPS_PYTHON_MAIN_VERSION = 3.9
FIPS_PYTHON_VERSION = 3.9.2-1+fips
FIPS_GOLANG_MAIN_VERSION = 1.15
FIPS_GOLANG_VERSION = 1.15.15-1~deb11u4+fips
FIPS_KRB5_VERSION = 1.18.3-6+deb11u5+fips
FIPS_URL_PREFIX = https://sonicstorage.blob.core.windows.net/public/fips/$(BLDENV)/$(FIPS_VERSION)/$(CONFIGURED_ARCH)

SYMCRYPT_OPENSSL_NAME = symcrypt-openssl
SYMCRYPT_OPENSSL = $(SYMCRYPT_OPENSSL_NAME)_$(FIPS_VERSION)_$(CONFIGURED_ARCH).deb
$(SYMCRYPT_OPENSSL)_SRC_PATH = $(SRC_PATH)/sonic-fips

FIPS_OPENSSL = openssl_$(FIPS_OPENSSL_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_OPENSSL_LIBSSL = libssl1.1_$(FIPS_OPENSSL_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_OPENSSL_LIBSSL_DEV = libssl-dev_$(FIPS_OPENSSL_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_OPENSSL_LIBSSL_DOC = libssl-doc_$(FIPS_OPENSSL_VERSION)_all.deb
FIPS_OPENSSL_ALL = $(FIPS_OPENSSL) $(FIPS_OPENSSL_LIBSSL) $(FIPS_OPENSSL_LIBSSL_DEV) $(FIPS_OPENSSL_LIBSSL_DOC)

FIPS_OPENSSH = ssh_$(FIPS_OPENSSH_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_OPENSSH_CLIENT = openssh-client_$(FIPS_OPENSSH_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_OPENSSH_SFTP_SERVER = openssh-sftp-server_$(FIPS_OPENSSH_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_OPENSSH_SERVER = openssh-server_$(FIPS_OPENSSH_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_OPENSSH_ALL = $(FIPS_SSH) $(FIPS_OPENSSH_CLIENT) $(FIPS_OPENSSH_SFTP_SERVER) $(FIPS_OPENSSH_SERVER)

FIPS_PYTHON = python$(FIPS_PYTHON_MAIN_VERSION)_$(FIPS_PYTHON_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_PYTHON_MINIMAL = python$(FIPS_PYTHON_MAIN_VERSION)-minimal_$(FIPS_PYTHON_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_LIBPYTHON = libpython$(FIPS_PYTHON_MAIN_VERSION)_$(FIPS_PYTHON_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_LIBPYTHON_MINIMAL = libpython$(FIPS_PYTHON_MAIN_VERSION)-minimal_$(FIPS_PYTHON_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_LIBPYTHON_STDLIB = libpython$(FIPS_PYTHON_MAIN_VERSION)-stdlib_$(FIPS_PYTHON_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_PYTHON_ALL = $(FIPS_PYTHON) $(FIPS_PYTHON_MINIMAL) $(FIPS_LIBPYTHON) $(FIPS_LIBPYTHON_MINIMAL) $(FIPS_LIBPYTHON_STDLIB)

FIPS_GOLANG = golang-$(FIPS_GOLANG_MAIN_VERSION)_$(FIPS_GOLANG_VERSION)_all.deb
FIPS_GOLANG_GO = golang-$(FIPS_GOLANG_MAIN_VERSION)-go_$(FIPS_GOLANG_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_GOLANG_SRC = golang-$(FIPS_GOLANG_MAIN_VERSION)-src_$(FIPS_GOLANG_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_GOLANG_DOC = golang-$(FIPS_GOLANG_MAIN_VERSION)-doc_$(FIPS_GOLANG_VERSION)_all.deb
FIPS_GOLANG_ALL = $(FIPS_GOLANG) $(FIPS_GOLANG_GO) $(FIPS_GOLANG_SRC) $(FIPS_GOLANG_DOC)

FIPS_KRB5 = libk5crypto3_$(FIPS_KRB5_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_KRB5_SUPPORT0 = libkrb5support0_$(FIPS_KRB5_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_KRB5_3 = libkrb5-3_$(FIPS_KRB5_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_KRB5_LIBGSSAPI = libgssapi-krb5-2_$(FIPS_KRB5_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_KRB5_LIBKADM5CLNT = libkadm5clnt-mit12_$(FIPS_KRB5_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_KRB5_LIBKADM5SRV = libkadm5srv-mit12_$(FIPS_KRB5_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_KRB5_LIBGSSRPC4 = libgssrpc4_$(FIPS_KRB5_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_KRB5_MULTIDEV = krb5-multidev_$(FIPS_KRB5_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_KRB5_DEV = libkrb5-dev_$(FIPS_KRB5_VERSION)_$(CONFIGURED_ARCH).deb
FIPS_KRB5_ALL = $(FIPS_KRB5) $(FIPS_KRB5_SUPPORT0) $(FIPS_KRB5_3) $(FIPS_KRB5_LIBGSSAPI) $(FIPS_KRB5_LIBKADM5CLNT) $(FIPS_KRB5_LIBKADM5SRV) $(FIPS_KRB5_LIBGSSRPC4) $(FIPS_KRB5_MULTIDEV) $(FIPS_KRB5_DEV)

FIPS_DERIVED_TARGET = $(FIPS_OPENSSL_ALL) $(FIPS_OPENSSH_ALL) $(FIPS_GOLANG_ALL) $(FIPS_PYTHON_ALL) $(FIPS_KRB5_ALL)
FIPS_PACKAGE_ALL = $(SYMCRYPT_OPENSSL) $(FIPS_DERIVED_TARGET)

$(foreach package,$(FIPS_DERIVED_TARGET),$(eval $(call add_extra_package,$(SYMCRYPT_OPENSSL),$(package))))

ifeq ($(INCLUDE_FIPS), y)
  FIPS_BASEIMAGE_INSTALLERS = $(FIPS_OPENSSL_LIBSSL) $(FIPS_OPENSSL_LIBSSL_DEV) $(FIPS_OPENSSL) $(SYMCRYPT_OPENSSL) $(FIPS_OPENSSH) $(FIPS_OPENSSH_CLIENT) $(FIPS_OPENSSH_SFTP_SERVER) $(FIPS_OPENSSH_SERVER) $(FIPS_KRB5)
  SONIC_MAKE_DEBS += $(SYMCRYPT_OPENSSL)
endif
