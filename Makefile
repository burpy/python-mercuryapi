APIVER = 1.27.3.16

.PHONY: all mercuryapi

all: mercuryapi
	python3 setup.py build

mercuryapi: mercuryapi-$(APIVER)/.done
	make -C mercuryapi-$(APIVER)/c/src/api

	mkdir -p build/mercuryapi/include
	find mercuryapi-*/c/src/api -type f -name '*.h' ! -name '*_imp.h' | xargs cp -t build/mercuryapi/include

	mkdir -p build/mercuryapi/lib
	find mercuryapi-*/c/src/api -type f -name '*.a' -or -name '*.so.1' | xargs cp -t build/mercuryapi/lib

mercuryapi-$(APIVER)/.done: mercuryapi-$(APIVER).zip
	unzip mercuryapi-$(APIVER).zip
	patch -p0 -d mercuryapi-$(APIVER) < mercuryapi.patch
	touch mercuryapi-$(APIVER)/.done

mercuryapi-$(APIVER).zip:
	wget http://www.thingmagic.com/images/Downloads/software/mercuryapi-$(APIVER).zip
