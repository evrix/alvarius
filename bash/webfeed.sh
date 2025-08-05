#!/bin/bash

# trepuntini …

# la data delle notizie in format GGMMAA
data=$1

# la data delle notizie in formato AAMMGG
millennio="20"
giorno=${data:4:2}
mese=${data:2:2}
anno=${data:0:2}

# il percorso di lavoro
path="/home/bruno/public_html/alvarius"
# path="/var/run/media/manjaro/c831f8f6-0ecf-4ed2-8bc8-3827cb0e7c9b/home/bruno/public_html/alvarius/"

# il titolo temporaneo in bash/
echo -e "<article id="container"><h3>rassegna stampa del $giorno / $mese / $anno</h3>\n<div class=\"notizie\">\n<ol>" > $path/bash/titolo.html.tmp

# il corpo temporaneo in bash/
cat $path/bash/${millennio}${anno}/$data | sed -e 's/^/\<li\>\<a href="/g' -e 's/\ |\ /"\ target="_blank"\ rel="noreferrer\ noopener"\>/g' -e 's/$/\<\/a\>\<\/li\>/g' > $path/bash/$data.html.tmp

# EOF temporaneo in bash/
echo -e "</ol>\n</div></article>" > $path/bash/tail.html.tmp

# il file definitivo nella directory dell'anno di riferimento in htdocs/<AA>/
cat $path/bash/titolo.html.tmp $path/bash/$data.html.tmp $path/bash/tail.html.tmp > $path/htdocs/${millennio}${anno}/$data.html

# il corpo temporaneo del feed in bash/
# sed -E "s/(.*)\ \|\ (.*)/<item>\n<title>\2<\/title>\n<link>\1<\/link>\n<description>http\:\/\/alvarius.mypressonline.com\/$data.$day.html<\/description>\n<guid>\1<\/guid>\n<\/item>\n/g" $path/bash/${millennio}${anno}/$data > $path/bash/feed.rss.tmp
sed -E "s/(.*)\ \|\ (.*)/<item>\n<title>\2<\/title>\n<link>\1<\/link>\n<description>https\:\/\/alvarius.mydiscussion.net\/feed\/$data.$day.html<\/description>\n<guid>\1<\/guid>\n<\/item>\n/g" $path/bash/${millennio}${anno}/$data > $path/bash/feed.rss.tmp

# il feed definitivo in feed/<AA>/
# date +"feed pubblicato alle %H:%M:%S di %A %d %B %Y" > $path/feed/oggi.tmp
# cat $path/feed/headstart.rss $path/feed/oggi.tmp $path/feed/headend.rss  $path/bash/feed.rss.tmp $path/feed/tail.rss > $path/feed/${millennio}${anno}/$data.rss
cat $path/feed/head.rss $path/bash/feed.rss.tmp $path/feed/tail.rss > $path/feed/${millennio}${anno}/$data.rss

# … ed il feed du jour
cp  $path/feed/${millennio}${anno}/$data.rss  $path/feed/feed.rss

# trasferisco sull'host VECCHIO
# sshpass -p "3s1zt0r%" sftp -P 221 3863457@alvarius.mypressonline.com:/alvarius.mypressonline.com/htdocs/${millennio}${anno}/ <<< $"put $path/htdocs/${millennio}${anno}/$data.html"
# sshpass -p "3s1zt0r%" sftp -P 221 3863457@alvarius.mypressonline.com:/alvarius.mypressonline.com/feed/${millennio}${anno}/ <<< $"put $path/feed/${millennio}${anno}/$data.rss"
# sshpass -p "3s1zt0r%" sftp -P 221 3863457@alvarius.mypressonline.com:/alvarius.mypressonline.com/feed/ <<< $"put $path/feed/feed.rss"

# sshpass -p "3s1zt0r%" sftp -P 221 3863457@alvarius.mypressonline.com:/alvarius.mypressonline.com/htdocs/${millennio}${anno}/ #<<#END

# trasferisco sull'host NUOVO usando .netrc, pasv [ -p ] e specificando il percorso remoto [ <filename> ]
# cd alvarius.mydiscussion.net/htdocs/htdocs/${millennio}${anno}/
# cd ../feed/${millennio}${anno}/
# cd ../

# ftp -pv 185.27.134.11 <<END
# put $path/htdocs/${millennio}${anno}/$data.html alvarius.mydiscussion.net/htdocs/htdocs/${millennio}${anno}/$data.html
# put $path/feed/${millennio}${anno}/$data.rss alvarius.mydiscussion.net/htdocs/feed/${millennio}${anno}/$data.rss
# put $path/feed/feed.rss alvarius.mydiscussion.net/htdocs/feed/feed.rss
# END

git_commit_and_push.sh main "aggiunta la rassegna stampa del $data"

# pulisco i file temporanei e le variabili
rm $path/bash/$data.html.tmp $path/bash/titolo.html.tmp $path/bash/tail.html.tmp $path/bash/feed.rss.tmp
unset data path giorno mese anno day

paplay ~bruno/Musica/system/candid.mp3

exit 0
