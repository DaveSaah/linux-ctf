compgen -u | grep level

if ! [ $? -eq 0 ]; then
	echo "There are no levels created"
fi
