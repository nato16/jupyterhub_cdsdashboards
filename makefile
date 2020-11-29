image_name=jupyterhub_cds
hub_namespace=natihd16

build:
	docker build \
		--build-arg client_id=${client_id} \
		--build-arg client_secret=${client_secret} \
		--build-arg callback_url=${callback_url} \
		-t ${hub_namespace}/${image_name} .
push:
	docker push ${hub_namespace}/${image_name}
pull:
	docker pull ${hub_namespace}/${image_name}
stop:
	docker stop ${image_name}
rm:
	docker rm ${image_name}
run:
	docker run -p 8000:8000 \
		-v ~/jdata:/home \
		--name ${image_name} \
		-d ${hub_namespace}/${image_name}
