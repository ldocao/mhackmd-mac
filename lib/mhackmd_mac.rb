require "mhackmd_mac/version"

module MhackmdMac
	class Mac

		def initialize
			@action = Mhack::Dispatcher.new.get_action
			@params = Mhack::Dispatcher.new.get_params
		end

	    def launcher
	    	case @action

	   		#Standard actions
	   		when ":doc"
	            documentation
	    	when ":help"
	            help
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
	        puts Rainbow(":doc").color("#D65200")+"               Open documentation online"
	        puts Rainbow(":open").color("#D65200")+"              Open folder"
	        puts Rainbow(":new").color("#D65200")+"               Create file or directory"
	        puts Rainbow(":destroy").color("#D65200")+"           Destroy Params file or current directory"
	        puts Rainbow(":clean").color("#D65200")+"             Clean the trash"
	        puts Rainbow(":calendar").color("#D65200")+"          Show current month"
	        puts Rainbow(":today").color("#D65200")+"             Show date of day"
	        puts ""
	    end  

	    def documentation
			Launchy.open( "https://github.com/nicolaslechenic/mhackmd-mac.git" )
	    end

	    #Open directory
	    def open

	    	case @params[0]
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
	    		exec 'open '+@params[0]
	    	end
	    end

	    #Make file or directory
	    def create
	        type = @params[0].split('.')

	        if type[1]

	            if @params[1]
	                FileUtils.touch(@params[1]+'/'+@params[0])
	            else
	                FileUtils.touch(@params[0])
	            end
	        else
	            if @params[1]
	                FileUtils::mkdir_p @params[1]+'/'+@params[0]
	            else
	                FileUtils::mkdir_p @params[0]
	            end
	        end
	    end

	    #Destroy file or directory
	    def destroy

	    	current_dir = Dir.pwd

	    	if @params[0]
	    		puts ""
				puts Rainbow("/!\\ Are you sure you want destroy "+@params[0]+" ? \n Enter your answer Yes/No").background("#F7A000") 
				puts ""
				answer = STDIN.gets.chomp

				if answer == "Yes"
					FileUtils.rm_rf(@params[0])
					puts ""
					puts @params[0]+" are remove"
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
