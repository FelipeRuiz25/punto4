#Nombre de los archivos
nombre=punto4

#Elimina los archivos creados
rm $nombre.tab.*
rm $nombre.output
rm $nombre.yy.c
rm $nombre.exe

#Crea los archivos
bison -d -v $nombre.y
flex -o $nombre.yy.c $nombre.l
gcc $nombre.tab.c $nombre.yy.c -lfl -o $nombre.exe

echo "ejecutando: "$nombre.exe
./$nombre.exe $1