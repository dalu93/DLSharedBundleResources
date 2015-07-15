#!/usr/bin/ruby

# Importing libraries
require 'Xcodeproj'
require 'colorize' 
# end import

# Setting the project path (absolute path, example: /Users/username/Documents/xcode_workspace/folder/to/project/project.xcodeproj)
# DO NOT USE THE ~/ TO REPRESENT /Users/username/ path
print "Insert your project path (do not use ~/ to represent /Users/username/ folder): "
path = gets.chomp
print "\nEnter the incomplete target name: "
notCompleteTargetName = gets.chomp
print "\nEnter the complete target name: "
completeTargetName = gets.chomp

# Settings a file "blacklist" that it makes you able to automatically skip files you won't be shared
# You can also specify only a part of the file name
blacklist = ["ADBM"]
# end settings

# Open the project
project = Xcodeproj::Project.open(path); 

# Setting the targets index
# The index in the array is the target position (top = 0; bottom = last one) on the project tab in Xcode
fullTargetIndex = 999			# Non-existing position to avoid not correct target name
incompleteTargetIndex = 999		# Non-existing position to avoid not correct target name
# end setting

print "Retrieving targets on project...\n"

currentIndex = 0
project.targets.each do |target|
	# If this target is equal to the one type as incompleteTarget...
	if target.name.casecmp(notCompleteTargetName).zero?
		# ... I will save its index
		incompleteTargetIndex = currentIndex
	# If this target is equal to the one typed as completeTarget...
	elsif target.name.casecmp(completeTargetName).zero?
		# ... I will save its index
		fullTargetIndex = currentIndex
	end
	# Incrementing the counter
	currentIndex+=1
end

# Setting targets
# The index in the array is the target position (top = 0; bottom = last one) on the project tab in Xcode
incompleteTarget = project.targets[incompleteTargetIndex];
fullTarget = project.targets[fullTargetIndex];
#end setting target

# Start iteration on fullTarget resources
fullTarget::resources_build_phase.files.each do |buildFile|
	fileReference = buildFile::file_ref
	# If it is a blacklisted file, I will skip it
	if blacklist.any? { |file| fileReference.display_name.include? file }
		print "#{fileReference.display_name} skipped\n".red
	else
		print "#{fileReference.display_name}\n"
		# If the file isn't in the resources of the incomplete target...
		unless incompleteTarget.resources_build_phase.files_references.include?(fileReference)
			print "Added #{fileReference.real_path}\n".green
			# ... I will add it
      		incompleteTarget.resources_build_phase.add_file_reference(fileReference) 
		end
	end
end

# Saving the project
project::save