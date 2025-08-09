#!/bin/bash

# trepuntini [ellipsis] …

data=$1
path="/home/bruno/public_html/alvarius"
# path="/var/run/media/manjaro/casa/bruno/public_html/alvarius"

giorno=${data:4:2}
mese=${data:2:2}
anno=${data:0:2}

cat $path/bash/$data | sed -e 's/^/\<li\>\<a href="/g' -e 's/\ |\ /"\ target="_blank"\ rel="noreferrer\ noopener"\>/g' -e 's/$/\<\/a\>\<\/li\>/g' > $path/bash/$data.html

echo "<h2>rassegna stampa del $giorno / $mese / $anno</h2><div class=\"notizie\"><ol>" > $path/bash/titolo.html
echo "</ol></div>" > $path/bash/tail.html
cat $path/bash/titolo.html $path/bash/$data.html $path/bash/tail.html > $path/htdocs/$data.$giorno$mese$anno.html

sshpass -p "3s1zt0r%" sftp -P 221 3863457@alvarius.mypressonline.com:/alvarius.mypressonline.com/htdocs/ <<< $"put $path/htdocs/$data.$giorno$mese$anno.html"

rm $path/bash/$data.html $path/bash/titolo.html $path/bash/tail.html

unset data giorno mese anno

exit 0
