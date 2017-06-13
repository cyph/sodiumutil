all:
	rm -rf dist tmp 2> /dev/null
	mkdir dist tmp

	wget https://raw.githubusercontent.com/jedisct1/libsodium.js/d4fcfd5/wrapper/wrap-template.js -O tmp/wrap-template.js

	cat pre.js > tmp/sodiumutil.js
	cat tmp/wrap-template.js | tr '\n' '☁' | perl -pe 's/.*Codecs(.*?)Memory management.*/\1/g' | tr '☁' '\n' >> tmp/sodiumutil.js
	echo >> tmp/sodiumutil.js
	cat tmp/wrap-template.js | tr '\n' ' ' | perl -pe 's/\s+/ /g' | perl -pe 's/.*(function memcmp.*?)\s+function.*/\1/g' >> tmp/sodiumutil.js
	echo >> tmp/sodiumutil.js
	cat tmp/wrap-template.js | tr '\n' ' ' | perl -pe 's/\s+/ /g' | perl -pe 's/.*(function memzero.*?)\s+function.*/\1/g' >> tmp/sodiumutil.js
	echo >> tmp/sodiumutil.js
	cat post.js >> tmp/sodiumutil.js

	uglifyjs tmp/sodiumutil.js -cmo dist/sodiumutil.js

	rm -rf tmp

clean:
	rm -rf dist tmp
