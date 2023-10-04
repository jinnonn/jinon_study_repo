#!/bin/bash

# Add script to $PATH to simplify usage. Also, script is intended to use with cron or .service w/ .timer, or another task planning option.
# backup_script syntax is [path_to_directory_for_backuping] [path_to_backup_directory]

# Checking if bzip2 archivator is installed or not, it's neccesary for script running.

if bzip2 --version &> /dev/null
then
	echo "bzip2 is exists"
else
	echo "bzip2 is not installed. Initiate installing..."
	apt install bzip2 -y 2> backup_script_error_log
	if ! command -v bzip2 > /dev/null
	then
		echo "There is bzip2 installation failure, please check up the \"backup_script_error_log\""
		exit
	else
		echo "bzip2 installed successfully"
	fi
fi

# folders checking and getting from threads

if [ -n "$1" ]
then
	dir_to_backup=$1
else
	echo "No specific directory insrted, backup current directory?[y/n]:"
	read -s y_n
	if [ "$y_n" = "y" ]
	then
		dir_to_backup=$( pwd )
	else
		echo "Bye"
		exit
	fi
fi

if [ -n "$2" ]
then
	backup_dir=$2 
else
	backup_dir=~/backup_files
	if [ ! -d $backup_dir ]; then
		mkdir $backup_dir 2>> backup_script_error_log
	fi
fi

# echo's just for manual testing

echo "Directory to backup: $dir_to_backup"
echo "Directory WHERE to backup: $backup_dir"

# Main backup function.

backup() 
{
	dir_to_backup=$1
	backup_dir=$2
	backup_type=$3 # types are daily, weekly, monthly, yearly

	if [ ! -d $backup_dir/$backup_type ]; then	# creating a directory with "backup_type" name 
		mkdir $backup_dir/$backup_type 2>> backup_script_error_log
	fi

	# Beggining to arhive with tar + bzip2 compression

	tar_name=$(date +%Y-%m-%d_%H-%M-%S_"$dir_to_backup" | tr / "+" 2> /dev/null) # "+" is instead of "/" because tar working painfully with "/" in name of archive
	echo "Tar name is $tar_name"
	tar cfj "$tar_name".tar.bz2 $dir_to_backup 2> backup_script_error_log
	status=$?
	if [ $status -eq 0 ] || [ $status -eq 1 ]
	then
		mv "$tar_name".tar.bz2 $backup_dir/$backup_type 2> backup_script_error_log
		echo "Success with exit code: $status"
	else
		mv "$tar_name".tar.bz2 $backup_dir/$backup_type 2> backup_script_error_log
		echo "Something maybe went wrong with exit code $status, please check \"backup_script_error_log\""
	fi
}

# function for backup folder cleaning
# amount of backups:
# daily is 6 max
# weekly is 4 max
# monthly is 3 max
# yearly is 1 max

backup_clean() 
{
	dir_to_backup=$1
	backup_dir=$2
	
	# daily backups clearing

	files_list=$(ls $backup_dir/daily/*"$(basename $dir_to_backup)"*)
	count_files=$(echo "$files_list" | wc -l)

	if [ $count_files -gt 6 ]; then
		echo "$files_list" | head -n $(($count_files - 6)) | xargs rm -f
	fi

	# weekly backups clearing

	files_list=$(ls $backup_dir/weekly/*"$(basename $dir_to_backup)"*)
	count_files=$(echo "$files_list" | wc -l)

	if [ $count_files -gt 4 ]; then
		echo "$files_list" | head -n $(($count_files - 4)) | xargs rm -f
	fi

	# monthly backups clearing

	files_list=$(ls $backup_dir/monthly/*"$(basename $dir_to_backup)"*)
	count_files=$(echo "$files_list" | wc -l)

	if [ $count_files -gt 3 ]; then
		echo "$files_list" | head -n $(($count_files - 3)) | xargs rm -f
	fi

	# yearly backups clearing

	files_list=$(ls $backup_dir/yearly/*"$(basename $dir_to_backup)"*)
	count_files=$(echo "$files_list" | wc -l)

	if [ $count_files -gt 1 ]; then
		echo "$files_list" | head -n $(($count_files - 1)) | xargs rm -f
	fi

}

# Making a daily backup

backup_type="daily"
backup $dir_to_backup $backup_dir $backup_type

# Making other type's backup if condition is met

if [ "$(date +%d-%m)" == "31-12" ]; then # making backups every 31 December
	backup_type="yearly"
	backup $dir_to_backup $backup_dir $backup_type
fi
if [ "$(date +%d)" == "01" ]; then # macking backups every first day of the month
	backup_type="monthly"
	backup $dir_to_backup $backup_dir $backup_type
fi
if [ "$(date +%w)" == 7 ]; then # making backups on Sunday
	backup_type="weekly"
	backup $dir_to_backup $backup_dir $backup_type
fi

# CALL FOR EXTERMINATUS

backup_clean $dir_to_backup $backup_dir
