au BufNewFile,BufRead *.gradle setf groovy
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/*,/usr/local/etc/nginx/* if &ft == '' | setfiletype nginx | endif 
