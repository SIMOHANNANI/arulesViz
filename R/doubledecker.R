#######################################################################
# arulesViz - Visualizing Association Rules and Frequent Itemsets
# Copyrigth (C) 2011 Michael Hahsler and Sudheer Chelluboina
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


doubledecker_arules <- function(rules, measure ="support", data, 
	control=list(), ...) {

  if(pmatch(control$engine, c("default"), nomatch = 0) != 1) 
    stop("Unknown engine for scatterplot: '", control$engine, 
      "' Valid engines: 'default'.")
  
  if(length(rules) != 1) stop("only can visualize one rule.")
  if(is.null(data)) stop("data has to be specified, but is missing.")

  control <- c(control, list(...))

  control <- .get_parameters(control, list(
    main = "Doubledecker plot for 1 rule",
    type = "doubledecker",
    engine = "default",
    interactive = FALSE,
    plot_options = list()
  ))

  if(control$interactive) stop("No interactive visualization available for doubledecker/mosaic plot.")
    
  table <- getTable(rules, data)
  
  if(control$type=="doubledecker")
    do.call(vcd::doubledecker, c(list(table, margins=c(2,8,length(dim(table) + 2), 2), 
      main = control$main), control$plot_options)) 
  else {
    control$main <- "Mosaic plot for 1 rule"
    do.call(vcd::mosaic, c(list(table, highlighting = length(dim(table)),
      main = control$main), control$plot_options))
  }
}


