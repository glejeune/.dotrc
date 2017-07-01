#!/bin/bash

new_mail=0
last_sum=0
maildir=" "

sum_mail=0

mailcheck | grep new 2>&1 >/dev/null
if [ $? -eq 0 ];
then

  maildir=`mailcheck | grep new | awk '{ print $NF }' \
    | sed 's/\// /g' | awk '{ print $(NF-1) }' \
    | awk '{ printf "%s ", $0 }' | sed 's/ /, /g' \
    | sed 's/, $//'`

  new_mail=`mailcheck | grep new | awk '{ print $3 }'`

  for N in `echo $new_mail`
  do
    sum_mail=`expr $sum_mail + $N`
  done

  if [ $sum_mail -ne $last_sum ];
  then
    if [ $sum_mail -eq 1 ] ;
    then
      notify-send -c email.arrived -u normal -i mail_new \
        "You have $sum_mail new mail:" "$maildir"
    else
      notify-send -c email.arrived -u normal -i mail_new \
        "You have $sum_mail new mails:" "$maildir"
    fi
    last_sum=$sum_mail
  fi
fi
