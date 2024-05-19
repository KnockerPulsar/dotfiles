# set -x

internal_storage_path="/run/user/1000/gvfs/mtp:host=Xiaomi_SDM636-MTP__SN%3A8744B8C8_4242bd5f/Internal shared storage/"
sd_card_path="/run/user/1000/gvfs/mtp:host=Xiaomi_SDM636-MTP__SN%3A8744B8C8_4242bd5f/SD card/"
backup_path="/home/tarek/phone_backup_rsync"

internal_dirs_to_backup=(
	"DCIM/"
	"Download/"
	"Music/"
	"Omnichan/"
	"Pictures/"
	"ReadChan/"
	"Snapseed/"
	"Tachiyomi/"
)

internal_dirs=("${internal_dirs_to_backup[@]/#/$internal_storage_path}")

if [ ! -d $backup_path ]; then
	echo "backup path doesn't exist, creating it..."
	mkdir -p $backup_path
fi

# Backup phone internal storage
rsync --info=progress2 --info=name0 -azRs "${internal_dirs[@]}" "$backup_path" --exclude=.thumbnails

# Backup SD card
rsync --info=progress2 --info=name0 -azRs "$sd_card_path" "$backup_path" --exclude=.thumbnails
