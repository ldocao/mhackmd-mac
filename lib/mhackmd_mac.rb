require "mhackmd_mac/version"

module MhackmdMac
	class MAC
	    def cmd
	    	case $cmd
	    	when ":help"
	            help
	        #Standard actions
	    	when ":open", ":go"
	    		open
	        when ":new", ":create"
	            create
	        when ":destroy", ":delete", ":drop", ":crush", ":remove"
	            destroy
	            

	        when ":clean"
	        	cleaner
	        when ":calendar"
	            calendar
	        when ":today"
	            today
	    	else
	    		puts ""
            	puts Rainbow("/!\\ Unknown :action").background("#EA1B00") 
            	puts ""
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
	    	when 'Desktop'
	    		exec 'open '+$desktop_path
	    	when 'Images'
	    		exec 'open '+$images_folder
	    	when 'Download'
	    		exec 'open '+$download_folder
	    	when 'Music'
	    		exec 'open '+$music_folder
	    	when 'Movies'
	    		exec 'open '+$movies_folder
	    	when 'Sites'
	    		exec 'open '+$sites_folder
	    	when 'Rails'
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

	    #Destroy file or directory
	    def destroy

	    	current_dir = Dir.pwd

	    	if $param_one
	    		puts ""
				puts Rainbow("/!\\ Are you sure you want destroy "+$param_one+" ? \n Enter your answer Yes/No").background("#F7A000") 
				puts ""
				answer = STDIN.gets.chomp

				if answer == "Yes"
					FileUtils.rm_rf($param_one)
					puts ""
					puts $param_one+" are remove"
					puts ""
				elsif answer == "No"
					puts ""
					puts puts Rainbow("Phew ! That was close ...").color("#D65200")
					puts ""
				else
					puts "Wrong answer, please write Yes or No"
				end

			else
				puts ""
				puts Rainbow("/!\\ Are you sure you want destroy "+current_dir+" ? \n Enter your answer Yes/No").background("#F7A000") 
				puts ""
				answer = STDIN.gets.chomp

				if answer == "Yes"
					FileUtils.rm_rf(current_dir)
					puts ""
					puts current_dir+" are remove"
					puts ""
				elsif answer == "No"
					puts ""
					puts puts Rainbow("Phew ! That was close ...").color("#D65200")
					puts ""
				else
					puts "Wrong answer, please write Yes or No"
				end
			end
	    end


	    #Clean the trash
	    def cleaner
			puts ""
			puts Rainbow("/!\\ Are you sure you want empty trash ? \n Enter your answer Yes/No").background("#F7A000") 
			puts ""
			answer = STDIN.gets.chomp

			if answer == "Yes"
				system "rm -rf ~/.Trash/*"
				puts ""
				puts "The trash is cleaned"
				puts ""
			elsif answer == "No"
				puts ""
				puts puts Rainbow("The trash stinks, will soon be emptied !").color("#D65200")
				puts ""
			else
				puts "Wrong answer, please write Yes or No"
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
