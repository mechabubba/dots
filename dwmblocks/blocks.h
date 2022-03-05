//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/ /*Command*/                                                    /*Update Interval*/ /*Update Signal*/
        {"",     "exec ./helpers.sh get_battery",                               5,                  0},
	{"Mem:", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",     30,                 0},
	{"",     "date '+%B %d, %y @ %I:%M:%S %P'",                             1,                  0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;

//set a cwd to automatically switch to here. useful for running scripts inside .sh files.
static char cwd[] = "/home/steven/.dots/dwmblocks";

