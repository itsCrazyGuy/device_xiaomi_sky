#!/vendor/bin/sh
#=============================================================================
# Ultra-Stable RAM Management for 'sky' 4GB/6GB
#=============================================================================

function configure_zram_parameters() {
	MemTotal=$(grep MemTotal /proc/meminfo | awk '{print $2}')
	let RamSizeGB="( $MemTotal / 1048576 ) + 1"
	
	# Balanced ZRAM Size
	if [ $RamSizeGB -le 4 ]; then
		let zRamSizeMB=2048 # 2GB is safer for 4GB RAM to reduce CPU overhead
		swappiness=60
	else
		let zRamSizeMB=4096
		swappiness=60
	fi

	# Algorithm selection (LZ4 is king for performance on low-end)
	if grep -q lz4 /sys/block/zram0/comp_algorithm; then
		echo lz4 > /sys/block/zram0/comp_algorithm
	fi

	if [ -f /sys/block/zram0/disksize ]; then
		echo "$zRamSizeMB""M" > /sys/block/zram0/disksize
		mkswap /dev/block/zram0
		swapon /dev/block/zram0 -p 32758
	fi
	echo $swappiness > /proc/sys/vm/swappiness
}

function configure_read_ahead_kb_values() {
	dmpts=$(ls /sys/block/*/queue/read_ahead_kb | grep -e dm -e mmc -e sd)
	for dm in $dmpts; do
		echo 128 > $dm
	done
}

function configure_variant_parameters() {
	MemTotal=$(grep MemTotal /proc/meminfo | awk '{print $2}')
	let RamSizeGB="( $MemTotal / 1048576 ) + 1"

	# Virtual Memory Tunings - Extreme Stability
	echo 100 > /proc/sys/vm/vfs_cache_pressure
	echo 0 > /proc/sys/vm/watermark_boost_factor
	echo 100 > /proc/sys/vm/watermark_scale_factor
	
	if [ $RamSizeGB -le 4 ]; then
		# 4GB Variant - Conservative
		echo 14336 > /proc/sys/vm/min_free_kbytes
		# Disable MGLRU on 4GB if it causes lag (Keep it optional)
		if [ -d /sys/kernel/mm/lru_gen ]; then
			echo 0 > /sys/kernel/mm/lru_gen/enabled 
		fi
	else
		# 6GB+ Variant
		echo 16384 > /proc/sys/vm/min_free_kbytes
		if [ -d /sys/kernel/mm/lru_gen ]; then
			echo 1 > /sys/kernel/mm/lru_gen/enabled
		fi
	fi
}

# Execute
configure_zram_parameters
configure_read_ahead_kb_values
configure_variant_parameters

# Soc-specific post-boot
if [ -f /sys/devices/soc0/soc_id ]; then
	platformid=`cat /sys/devices/soc0/soc_id`
fi

case "$platformid" in
	"537" | "583" | "613")
		/vendor/bin/sh /vendor/bin/init.kernel.post_boot-parrot.sh
		;;
	"568" | "602" | "581" | "582")
		/vendor/bin/sh /vendor/bin/init.kernel.post_boot-ravelin.sh
		;;
esac
