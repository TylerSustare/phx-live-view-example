build:
	docker build -t studio .

run:
	docker run -p 4000:4000 studio