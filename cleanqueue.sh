#!/bin/sh

cd /home/user-data/mail/mailboxes/
domains=( $( ls . ) )
for i in "${domains[@]}"
do
        :
        cd $i
        names=($( ls . ))
        for n in "${names[@]}"
        do
                :
                echo $n"@"$i
                mailq | tail -n +2 | awk 'BEGIN { RS = "" }
                # $7=sender, $8=recipient1, $9=recipient2
                { if ($7 == $n"@"$i)
                print $1 }
                ' | tr -d '*!' | postsuper -d -
        done
        cd ..
done

