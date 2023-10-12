BEGIN{loadavg1_failure=0;mem_failure=0;disk_failure=0}

{
    if ($2 >= 1) 
    {
        print $1 " " $2 " Warning! Load average is higher then normal!"
        loadavg1_failure++
    }
    if ($5/$6 >= 0.6) 
    {
        print $1 " " ($5/$6)*100"%" " Warning! Amount of free memory is lower then normal!"
        mem_failure++
    }
    if ($7/$8 >= 0.6) 
    {
        print $1 " " ($7/$8)*100"%" " Warning! Amount of available space on disk is lower then normal!"
        disk_failure++
    }
}
END{print "Amount of loadavg warnings: " loadavg1_failure "\nAmount of memfree warnings: " mem_failure "\nAmount of diskfree warnings: " disk_failure}