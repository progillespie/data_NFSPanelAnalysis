********************************************************************
********************************************************************
*
*       Patrick R. Gillespie
*       Walsh Fellow
*       Teagasc, REDP
*       patrick.gillespie@teagasc.ie
*
********************************************************************


README for: RAW_79_83 project directory


PURPOSE:

Code to convert raw NFS data (prepared by Gerry
  Quinlan - before he retired) to a Stata dataset
  for further analysis.

This will match dataset conventions in nfs_data.dta

A routine is also provided to rename vars to "SAS" style varnames 
  (e.g. fdairygo, dpnolu, etc.)



The required input files are named rawYY_head.xls and
  are located in:

         OrigData/RAW_79_83



The master file is :

         raw2Stata[_YYYYMMDD].do


with [_YYYYMMDD] being an optional suffix
  indicating a date of major edit



Subroutines are located in:

         sub_do



Files produced by master file and subroutines:

    raw_dta                           [directory]
    raw_dta/rawYY                     [sub-directory]
    raw_dta/rawYY/SheetNN.dta         [temp dataset]
    raw_dta/rawYY/SheetNN.dta         [temp dataset]
    raw_dta/rawYY/all_sheets.dta      [temp dataset]
    `outdata'/nfs_7983.dta            [finished dataset]
    `outdata'/nfs_7983varlist.csv     [dataset description]


where `outdata' is

         D:\Data/data_NFSPanelAnalysis/OutData





---------------------------------------------------------------------
Subroutine types
---------------------------------------------------------------------
There are lot of files in there, but this is mostly repetitive.
  The basic types of subroutines are


    _convertSheet     |gets raw data into usual panel structure
                      |
    _renameSheet      |renames raw data using IB varnames
                      |
    D_VARNAME         |folder containing D_ var definitions
                      |
    I_VARNAME         |same for I_vars
                      |
                      |
    create_rename*.do |reads code stored in Excel and writes it 
                      |    out again as a do file
                      |
    renameIB2SAS.do   |is written by a do-file. It will be 
                      |   overwritten, so don't edit it directly. 
                      |   Rather edit the AllVarsMapping sheet from
                      |   which the associated create_rename file 
                      |   reads.
                      |
    renameSheet*.do   |see renameIB2SAS.do. Same applies here.
                      |
                      |
    _TEMPLATES        |templates of structure of various do files or 
                      |  entire subdirectories.


    NOTE: Variable definitions files are called recursively (if a 
          D_var1, requires another D_var2, D_var2's definition is 
          automatically run). This is accomplished by including a 
          subfolder in D_var1's definition folder, which is then 
          detected by Stata. 
          
    NOTE: Linking do files. If D_var1 requires D_var2, then a "link"
          to D_var2's definition in sub_do is what is actually given
          to D_var1, rather than a copy of the definition itself.
          This solves two problems; 1) duplicated code is both error
          prone and difficult to maintain and 2) Windows has a limit
          to the number of characters in a filepath (which was being
          exceeded). Linking files are clearly marked at the end of
          the file or dir name, and there are templates for creating
          them in _TEMPLATES.             


Any files not described here will have brief descriptions at the 
  top of the file. The filenames are also somewhat descriptive. 
---------------------------------------------------------------------





---------------------------------------------------------------------
Algorithms/Procedures types for converting raw data
---------------------------------------------------------------------
Algorithm: Label for the basic procedure being applied to the data.
  The labels are:


    - RENAME: Data already in correct panel form (1 row per farm).
          Simply rename variables as necessary.


    - SUM ALL: Data has multiple rows per farm, but summing these
           variables (usually expense vars) is valid. Simply
           collapse (sum) data by farm.


    - SINGLE CODE: Several variables are recorded in a single column
               , indicated by a code in another. May also have
               multiple rows per farm. Create one column per
               code and collapse (sum) data by farm to correct
               panel form (1 row per farm).


    - MULTI CODE: Several variables are recorded in a multiple
              columns, indicated by a code in an adjacent column
              . May also have multiple rows per farm. Create one
              column per code per row, then sum across row for
              any codes repeated across columns in the same row,
              and collapse (sum)  data by farm to correct panel
              form (1 row per farm).
---------------------------------------------------------------------





---------------------------------------------------------------------
Accompanying spreadsheet
---------------------------------------------------------------------
The code has a complimentary (and necessary) spreadsheet

         raw2IBnamemappings.xlsx


NOTE: There are comments on the spreadsheet which may be helpful.



The individual sheets have the following uses

  FORMULA_TEMPLATE  -template for updating rows of AllVarsMapping

  D_Shortened       -shortens long derived varnames to < 32 char

  Raw Shortened     -does same for raw vars

  DataDictionary    -from DataDictionary.xls. SAS names & descrip.

  Enterprise Layout -from System_User_Guide... available on DMS
                        Maps some SAS names to IB names

  Calculation of Variables
                    -from System_User_Guide... available on DMS
                        XPath equations defining D_ and I_ vars

  AllVarsMapping    -Also gives mapping, but crucially some columns
                       are read by Stata to create a renaming do file
                       If vars are to be renamed, it should be done 
                       here, and the code should be run to build the
                       data again.

  VarnameCorrections 
                    -early sheet I used to deal with long or 
                        non-unique varnames. Retained for reference, 
                        but should not be used any longer.

  Algorithm         -Details the different procedures required for
                       different sheets of the Raw data files. These
                       roughly correspond to the svy tables used in 
                       the modern NFS database, but there are 
                       differences.

  Heading Matrices  -Sheet used to correct slight differences in 
                       column structure of the 5 rawYY_head.xls files
                       Retained for reference.

  Code Sheets       -codes and their meanings, self explanatory. 
    


Code sheets were taken from the file

         Data/data_NFSPanelAnalysis/OutData/ConvertIB/Codes.xls



I've worked alongside Brian Moran to this stage. He is not
  familiar with the code I've written, but he has reviewed the
  resulting datasets with me along the way, and I've been picking
  both his and Anne Kinsella's brain about how the raw data was
  structured and how one gets the correct calculation from them
  in general terms. I used those discusssions to generate this
  code and the spreadsheet. The errors are all my own.
---------------------------------------------------------------------





---------------------------------------------------------------------
Major issues
---------------------------------------------------------------------
The worksheet for 1981 has at least two major issues:

* Sheet 4
  It has 3679 rows, but farmcodes only appear up to row 1858.
  It appears that this is jus the same data pasted below and sorted
  by crop code. I've backed up the original data and simply deleted
  the extra rows in the working copy.

* Sheet 6
  The farm column is not right; they are non-integers. Seems like 
  cut-and-paste error. Variable from this sheet cannot be tied to
  farms. The easiest way to avoid this sheet is to allow it to import
  and conditionally drop all of the obs before merging.
---------------------------------------------------------------------
