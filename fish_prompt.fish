function _rider_theme_git_branch_name
	echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function fish_prompt
	# this must be the first line
	set -l last_status $status

	set -l yellow (set_color yellow)
	set -l green (set_color green)
	set -l normal (set_color normal)
	set -l magenta (set_color magenta)
	set -l red (set_color red)
	set -l blue (set_color blue)
	set -l cyan (set_color cyan)
	set -l gray (set_color 555)
	set -l orange (set_color df5f00)

	set -l cwd (prompt_pwd)

	if test $last_status -eq 0
		set status_indicator $green"λ"
	else
		set status_indicator $red"λ"
	end

	if [ (_rider_theme_git_branch_name) ]
		if test (_rider_theme_git_branch_name) = 'master' -o (_rider_theme_git_branch_name) = 'main'
			set -l git_branch (_rider_theme_git_branch_name)
			set git_info "$cyan ($red$git_branch$cyan)$normal"
		else if test (_rider_theme_git_branch_name) = 'develop' -o (_rider_theme_git_branch_name) = 'dev'
			set -l git_branch (_rider_theme_git_branch_name)
			set git_info "$cyan ($yellow$git_branch$cyan)$normal"
		else
			set -l git_branch (_rider_theme_git_branch_name)
			set git_info "$cyan ($green$git_branch$cyan)$normal"
		end
	end

	#set -l lambda "߷"
	set -l lambda "in"

	echo -n "$green$USER$normal at $orange$hostname $magenta$lambda $blue$cwd $status_indicator$git_info $normal"
end
