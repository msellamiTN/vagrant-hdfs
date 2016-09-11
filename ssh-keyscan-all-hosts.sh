for f in $(sed -n '/vagrant-hostmanager-start/ {
         :next
         n; /vagrant-hostmanager-end/q; p; b next
       }' /etc/hosts | grep -v $(hostname) | awk '{print $2}') ; do
         ssh-keyscan $f >> $HOME/.ssh/known_hosts
done
touch $HOME/.keyscan-done
