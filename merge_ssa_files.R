# Author: Ron Ammar
# Contact: ron.ammar@bms.com
# Description: Merge baby name files from SSA, national list.
#   (https://www.ssa.gov/oact/babynames/limits.html)


##### The following section improves reproducibility when scripting ------------

# Clear the current session, to avoid errors from persisting data structures
rm(list=ls())

# Free up memory by forcing garbage collection
invisible(gc())

# Manually set the seed to an arbitrary number for consistency in reports
set.seed(1234)

# Do not convert character vectors to factors unless explicitly indicated
options(stringsAsFactors=FALSE)

#-------------------------------------------------------------------------------

babyNames <- data.frame()
