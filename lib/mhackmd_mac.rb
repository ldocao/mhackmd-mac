require "mhackmd_mac/version"

module MhackmdMac
	class MAC
	    def cmd
	    	case $cmd
	    	when ":open"
	    		open
	        when ":new"
	            create
	        when ":help"
	            help
	        when ":calendar"
	            calendar
	        when ":today"
	            today
	    	else
	    		"Unknow :action !"
	    	end
	    end

	    # > mhack @mac :help
	    def help
	        puts ""
	        puts Rainbow(":open").color("#D65200")+"              Open folder"
	        puts Rainbow(":new").color("#D65200")+"               Create file or directory"
	        puts Rainbow(":calendar").color("#D65200")+"          Show current month"
	        puts Rainbow(":today").color("#D65200")+"             Show date of day"
	        puts ""
	    end  

	    #Open directory
	    def open
	    	case $param_one
	    	when '@rails'
	    		exec 'open '+$rails_folder
	    	else
	    		exec 'open '+$param_one
	    	end
	    end

	    #Make file or directory
	    def create
	     
	        type = $param_one.split('.')

	        if type[1]

	            if $param_two
	                FileUtils.touch($param_two+'/'+$param_one)
	            else
	                FileUtils.touch($param_one)
	            end

	        else
	            
	            if $param_two
	                FileUtils::mkdir_p $param_two+'/'+$param_one
	            else
	                FileUtils::mkdir_p $param_one
	            end
	        end
	    end

	    def calendar
	        exec 'cal'
	    end

	    def today
	        exec 'date'
	    end
	end
end
