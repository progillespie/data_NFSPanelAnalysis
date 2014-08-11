* Notes to attach to nfs_7983.dta
*  - Used a lot of note commands to mimic normal formatting
*  - Written in separate file to avoid excessive output when running
*    master file (single line in output if done quietly) 

note:.Data from RAW_79_83 folder. Created using raw2Stata.do     ///
(or most recently dated version of that file).


note:.                                                            
note:.The data are historical NFS data going back as far as       ///
1979 at time of writing . The data were retrieved from            ///
magnetic tapes by Gerry Quinlan before his retirement, and        ///
stored in spreadsheets. Preparation of the data from that point   ///
on was carried out by Patrick R. Gillespie as part of his Ph.D.   ///
Questions on the data should be sent to him.

note:.                                                            
note:.The modern NFS stores the raw data in an XML                ///
database, and a programming language called XPath (or possibly    /// 
XQuery, which is an extension to XPath) is used to manipulate it  ///
before most REDP researchers ever see it as a Stata .dta file.    ///
A database will be perfectly ok with having data in               ///
different shapes, but Stata is more rigid. This data file is      ///
what the raw data looks like when forced into the usual one-      ///
column-per-variable, one-row-per-observation form that Stata      ///
-and most statistical packages- require. The data is VERY wide;   ///
there will be thousands of variables, mainly due to certain vars  ///
being repeated per crop code, bulk feed code, etc. Many vars will ///
also have a lot of 0 valued observations. For these               ///
reasons, you will most likely NOT be working with this data       ///
directly, but will use it to derive the usual variables of        ///
interest and take a subset of this for your own purposes.

note:.                                                            
note:.Most derived vars, i.e. D_VARNAME are not present in this   /// 
data. There is separate code available to do those calculations   ///
as needed. (See below)

note:.                                                            
note:.If you were expecting the 8 digit "SAS" varnames, then      ///
you'll be glad to know that THERE IS CODE to rename the           ///
appropriate vars. Many of these will be derived vars for which    ///
you'll have to run the variable's definition file first. There is ///
also code for renaming crop specific vars (will end in 4 digits). ///
Please consult Patrick R. Gillespie. 


note:.                                                            
note:.                                                            
note:.-----------------------------                                                           
note:.Example of how to derive vars
note:.-----------------------------                                                           
note:.                                                            
note:.First move to the folder containing the variable definitions.
note:.                                                          
note:.                                                            
note:.   cd D:\Data\data_NFSPanelAnalysis\Do_Files\RAW_79_83\sub_do
note:.   (Filepaths may differ from computer to computer.)
note:.                                                            
note:.                                                         
note:.Then run the file with the definition, which will be in a  ///
      filepath following this pattern:                           
note:.                                                         
note:.                                                            
note:.   IB_varname/IB_varname.do                               
note:.                                                            
note:.                                                            
note:.... where IB_varname is the IB style variable name, e.g.     
note:.                                                            
note:.                                                            
note:.   do D_FARM_GROSS_OUTPUT/D_FARM_GROSS_OUTPUT.do          
note:.                                                         
note:.                                                            
note:.IB varnames will have been shortened if they exceeded       ///
     Stata's varname character limit (32 characters). Varnames    ///
     are documented in the mapping spreadsheet, including the     ///
     shortened IB varnames and their corresponding original       ///
     versions.  
note:.                                                         
note:.Varnames were shortened systematically using the            ///
     SUBSTITUTE() function in Excel. See the D_Shortened          ///
     sheet.                

