install-deps:
	cpanm --installdeps -n .

test:
	prove -Ilib -r t/

run:
	morbo ./myapp.pl -l http://*:9900

init-db:
	mkdir -p ./db/data
	sqlite3 ./db/data/development.sqlite3 < ./db/schema.sql