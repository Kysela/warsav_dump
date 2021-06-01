#!/sbin/sh

if [ -d "/dev/block/bootdevice/by-name" ]; then
    exit 0
fi

mkdir -p /dev/block/bootdevice/by-name
BOOTDEVICE=$(cat /proc/bootdevice/name)
for file in /dev/block/platform/$BOOTDEVICE/by-name/*; do
    [ -e "$file" ] || continue
    FIXED=$(echo "$file" | sed 's/_a$//')
    FILENAME=$(basename "$FIXED")
    BLOCKDEVICE=$(readlink -f "$file")
    echo "File $FILENAME block $BLOCKDEVICE"
    ln -s $BLOCKDEVICE /dev/block/bootdevice/by-name/$FILENAME
done

