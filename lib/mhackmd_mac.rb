require "mhackmd_mac/version"

module MhackmdMac
	class Mac

		def initialize
			@action = Mhack::Dispatcher.new.action
			@params = Mhack::Dispatcher.new.params
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
	        when ":destroy", ":delete", ":drop", ":crush", ":remove", ":rm"
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



            
            # Public : Display help message for a command
            #
            # Examples
            #   > mhack @techno :help
            #   ##should be added here the results of command
            #
            # Returns list of available actions for the current technology.
            
	    def help
	        puts ""
	        puts Rainbow(":doc").color("#D65200")+"               Open documentation online"
	        puts Rainbow(":open").color("#D65200")+"              Open file or folder"
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



            # Public : Open a file or directory
            #
            # Examples
            #   > mhack @techno :open param
            #   ##should be added here the results of command
            #
            # Open a file or directory
	    def open
	    	exec 'open '+@params[0]
	    end



            # Public : Make file or directory
            #
            # Examples
            #   > mhack @techno :create param
            #   ##should be added here the results of command
            #
            # Create a file or directory
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


            # Public : Destroy file or directory
            #
            # Examples
            #   > mhack @techno :destroy param
            #   ##should be added here the results of command
            #
            # Remove a file or directory
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
