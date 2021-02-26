# docker and snaps really fuck up df
function dfd
    df -h --type ext4 --type ext3 --type ext2 --type vfat --type iso9660 --type btrfs
end
