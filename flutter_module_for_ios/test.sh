a=$(cat .ios/Podfile)
if [[ $a == use* ]]; then
    echo 'yes'
else
    echo 'no'
fi
