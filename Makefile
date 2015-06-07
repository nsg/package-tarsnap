build:
	docker build -t tarsnap .

package:
	docker run -ti tarsnap
	docker cp $$(docker ps -aq | head -1):/build/tarsnap_1.0.35_amd64.deb $$PWD
