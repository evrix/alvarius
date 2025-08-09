#!/bin/bash

# trepuntini …

# la data delle notizie in format AAMMGG
data=$1

# la data delle notizie in formato GGMMAA
millennio="20"
giorno=${data:4:2}
mese=${data:2:2}
anno=${data:0:2}

# il percorso di lavoro
# path="/home/bruno/public_html/alvarius"
cd /home/bruno/public_html/alvarius
# path="/var/run/media/manjaro/c831f8f6-0ecf-4ed2-8bc8-3827cb0e7c9b/home/bruno/public_html/alvarius/"

# il titolo temporaneo in bash/
echo -e "<article id="container"><h3>rassegna stampa del $giorno / $mese / $anno</h3>\n<div class=\"notizie\">\n<ol>" > /home/bruno/public_html/alvarius/bash/titolo.html.tmp

# il corpo temporaneo in bash/
cat /home/bruno/public_html/alvarius/bash/${millennio}${anno}/$data | sed -e 's/^/\<li\>\<a href="/g' -e 's/\ |\ /"\ target="_blank"\ rel="noreferrer\ noopener"\>/g' -e 's/$/\<\/a\>\<\/li\>/g' > /home/bruno/public_html/alvarius/bash/$data.html.tmp

# EOF temporaneo in bash/
echo -e "</ol>\n</div></article>" > /home/bruno/public_html/alvarius/bash/tail.html.tmp

# il file definitivo nella directory dell'anno di riferimento in htdocs/<AA>/
cat /home/bruno/public_html/alvarius/bash/titolo.html.tmp /home/bruno/public_html/alvarius/bash/$data.html.tmp /home/bruno/public_html/alvarius/bash/tail.html.tmp > /home/bruno/public_html/alvarius/htdocs/${millennio}${anno}/$data.html

# il corpo temporaneo del feed in bash/
# sed -E "s/(.*)\ \|\ (.*)/<item>\n<title>\2<\/title>\n<link>\1<\/link>\n<description>http\:\/\/alvarius.mypressonline.com\/$data.$day.html<\/description>\n<guid>\1<\/guid>\n<\/item>\n/g" /home/bruno/public_html/alvarius/bash/${millennio}${anno}/$data > /home/bruno/public_html/alvarius/bash/feed.rss.tmp
sed -E "s/(.*)\ \|\ (.*)/<item>\n<title>\2<\/title>\n<link>\1<\/link>\n<description>https\:\/\/alvarius.mydiscussion.net\/feed\/$data.$day.html<\/description>\n<guid>\1<\/guid>\n<\/item>\n/g" /home/bruno/public_html/alvarius/bash/${millennio}${anno}/$data > /home/bruno/public_html/alvarius/bash/feed.rss.tmp

# il feed definitivo in feed/<AA>/
# date +"feed pubblicato alle %H:%M:%S di %A %d %B %Y" > /home/bruno/public_html/alvarius/feed/oggi.tmp
# cat /home/bruno/public_html/alvarius/feed/headstart.rss /home/bruno/public_html/alvarius/feed/oggi.tmp /home/bruno/public_html/alvarius/feed/headend.rss  /home/bruno/public_html/alvarius/bash/feed.rss.tmp /home/bruno/public_html/alvarius/feed/tail.rss > /home/bruno/public_html/alvarius/feed/${millennio}${anno}/$data.rss
cat /home/bruno/public_html/alvarius/feed/head.rss /home/bruno/public_html/alvarius/bash/feed.rss.tmp /home/bruno/public_html/alvarius/feed/tail.rss > /home/bruno/public_html/alvarius/feed/${millennio}${anno}/$data.rss

# … ed il feed du jour
cp  /home/bruno/public_html/alvarius/feed/${millennio}${anno}/$data.rss  /home/bruno/public_html/alvarius/feed/feed.rss

# trasferisco sull'host VECCHIO
# sshpass -p "3s1zt0r%" sftp -P 221 3863457@alvarius.mypressonline.com:/alvarius.mypressonline.com/htdocs/${millennio}${anno}/ <<< $"put /home/bruno/public_html/alvarius/htdocs/${millennio}${anno}/$data.html"
# sshpass -p "3s1zt0r%" sftp -P 221 3863457@alvarius.mypressonline.com:/alvarius.mypressonline.com/feed/${millennio}${anno}/ <<< $"put /home/bruno/public_html/alvarius/feed/${millennio}${anno}/$data.rss"
# sshpass -p "3s1zt0r%" sftp -P 221 3863457@alvarius.mypressonline.com:/alvarius.mypressonline.com/feed/ <<< $"put /home/bruno/public_html/alvarius/feed/feed.rss"

# sshpass -p "3s1zt0r%" sftp -P 221 3863457@alvarius.mypressonline.com:/alvarius.mypressonline.com/htdocs/${millennio}${anno}/ #<<#END

# trasferisco sull'host NUOVO usando .netrc, pasv [ -p ] e specificando il percorso remoto [ <filename> ]
# cd alvarius.mydiscussion.net/htdocs/htdocs/${millennio}${anno}/
# cd ../feed/${millennio}${anno}/
# cd ../

# ftp -pv 185.27.134.11 <<END
# put /home/bruno/public_html/alvarius/htdocs/${millennio}${anno}/$data.html alvarius.mydiscussion.net/htdocs/htdocs/${millennio}${anno}/$data.html
# put /home/bruno/public_html/alvarius/feed/${millennio}${anno}/$data.rss alvarius.mydiscussion.net/htdocs/feed/${millennio}${anno}/$data.rss
# put /home/bruno/public_html/alvarius/feed/feed.rss alvarius.mydiscussion.net/htdocs/feed/feed.rss
# END

/home/bruno/Pubblici/115GB/local/bin/git_commit_and_push.sh main "aggiunta la rassegna stampa del $giorno / $mese / $millennio$anno"

# pulisco i file temporanei e le variabili
rm /home/bruno/public_html/alvarius/bash/$data.html.tmp /home/bruno/public_html/alvarius/bash/titolo.html.tmp /home/bruno/public_html/alvarius/bash/tail.html.tmp /home/bruno/public_html/alvarius/bash/feed.rss.tmp
unset data path giorno mese anno day

paplay ~bruno/Musica/system/candid.mp3

exit 0
