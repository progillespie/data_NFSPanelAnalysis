********************************************************
********************************************************
* Patrick R. Gillespie				
* Research Officer				
* Teagasc, REDP					
* Athenry, Co Galway, Ireland			
* patrick.gillespie@teagasc.ie	
*											
********************************************************
* RSF Project DAF RSF 07 505 (GO1390)		
*											
* A micro level analysis of the Irish 	
* agri-food sector: lessons and 		
* recommendations from Denmark and 	
* the Netherlands				
*										
* Task 4
*
********************************************************
* Loads graphs that are in gph format and exports them
*   to other file formats, e.g. Windows' .emf format 
*   Handy, but not necessary for the overall model to *   run. 
********************************************************
*
local gph: dir "output/graphs/" file *gph
*
* This loop loads and exports all the graph files.
* NOTE: If output/gph has non-graph files in it then 
*       this loop will fail
*
 foreach file of local gph{
  local emf: subinstr local file ".gph" ".emf", all
  local png: subinstr local file ".gph" ".png", all
  graph use output/graphs/gph/`file'
  graph export output/graphs/emf/`emf', as(emf) replace fontface("Times New Roman")
  graph export output/graphs/png/`png', as(png) replace 
  discard
 }
********************************************************
