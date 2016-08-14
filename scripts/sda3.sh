
if [ $1 = "m" ]
then
    udisksctl mount -b /dev/sda3
fi

if [ $1 = "u" ]
then
    udisksctl unmount -b /dev/sda3
fi
