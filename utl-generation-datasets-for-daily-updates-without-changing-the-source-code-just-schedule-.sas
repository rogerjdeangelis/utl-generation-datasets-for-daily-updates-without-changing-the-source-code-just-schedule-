%let pgm=utl-generation-datasets-for-daily-updates-without-changing-the-source-code-just-schedule;

Generation datasets for daily updates without changing the source code just schedule

Useful with database triggers

* documentation;
http://analytics.ncsu.edu/sesug/2006/SC18_06.PDF

inspired by
https://goo.gl/FQJGmj
https://communities.sas.com/t5/Base-SAS-Programming/SAS-Automation-Running-a-report-for-JUST-a-few-previous-days/m-p/329245

/**************************************************************************************************************************/
/*                                          |                                          |                                  */
/*          INPUT                           |                PROCESS                   |    OUTPUT (Sat Feb 4,2017 added  */
/*                                          |                                          |                                  */
/*                                          |                                          | data fourgen;                    */
/* CREATE A RING WITH A MAX OF FOUR         |  Roll off the oldest "Tue Jan 31, 2017"  |   retain gen;                    */
/* GENERATIONS LIKE THIS                    |  and add "Sat Feb 4,2017";               |   set                            */
/*                                          |                                          |       genum(gennum=-3)           */
/* WORK.FOURGEN                             |  data genum;                             |       genum(gennum=-2)           */
/*    GEN              DOC                  |    retain doc 'This is Sat Feb 4, 2017'; |       genum(gennum=-1)           */
/*                                          |  run;quit;                               |       genum                      */
/* 1 gennum=-3 This is Tue Jan 31 2017      |                                          |   ;                              */
/* 2 gennum=-2 This is Wed Feb 1,2017       |                                          |   select (_n_);                  */
/* 3 gennum=-1 This is Thu Feb 2,2017       |                                          |      when (1) gen='gennum=-3';   */
/* 4 genum     This is Fri Feb 3,2017       |                                          |      when (2) gen='gennum=-2';   */
/*                                          |                                          |     when (3) gen='gennum=-1';    */
/*                                          |                                          |      when (4) gen='current'  ;   */
/* THIS WILL CREATE THE RING                |                                          |   end;                           */
/*                                          |                                          |   ;                              */
/*  proc datasets lib=work kill;            |                                          | run;quit;                        */
/*  run;quit;                               |                                          |                                  */
/*                                          |                                          | THE NEW RING                     */
/*  data genum(genmax=4);                   |                                          |                                  */
/*    retain doc 'This is Tue Jan 31, 2017';|                                          |    GEN              DOC          */
/*  run;quit;                               |                                          |                                  */
/*                                          |                                          | gennum=-3 This is Wed Feb 1,2017 */
/*  data genum;                             |                                          | gennum=-2 This is Thu Feb 2,2017 */
/*    retain doc 'This is Wed Feb 1, 2017'; |                                          | gennum=-1 This is Fri Feb 3,2017 */
/*  run;quit;                               |                                          | current   This is Sat Feb 4,2017 */
/*                                          |                                          |                                  */
/*  data genum;                             |                                          |                                  */
/*    retain doc 'This is Thu Feb 2, 2017'; |                                          |                                  */
/*  run;quit;                               |                                          |                                  */
/*                                          |                                          |                                  */
/*  data genum;                             |                                          |                                  */
/*    retain doc 'This is Fri Feb 3, 2017'; |                                          |                                  */
/*  run;quit;                               |                                          |                                  */
/*                                          |                                          |                                  */
/*                                          |                                          |                                  */
/* data fourgen;                            |                                          |                                  */
/*   retain gen;                            |                                          |                                  */
/*   set                                    |                                          |                                  */
/*       genum(gennum=-3)                   |                                          |                                  */
/*       genum(gennum=-2)                   |                                          |                                  */
/*       genum(gennum=-1)                   |                                          |                                  */
/*       genum                              |                                          |                                  */
/*   ;                                      |                                          |                                  */
/*   select (_n_);                          |                                          |                                  */
/*      when (1) gen='gennum=-3';           |                                          |                                  */
/*      when (2) gen='gennum=-2';           |                                          |                                  */
/*      when (3) gen='gennum=-1';           |                                          |                                  */
/*      when (4) gen='current'  ;           |                                          |                                  */
/*   end;                                   |                                          |                                  */
/*   ;                                      |                                          |                                  */
/* run;quit;                                |                                          |                                  */
/*                                          |                                          |                                  */
/* WORK.FOURGEN                             |                                          |                                  */
/*    GEN               DOC                 |                                          |                                  */
/*                                          |                                          |                                  */
/* gennum=-3 This is Tue Jan 31,2017        |                                          |                                  */
/* gennum=-2 This is Wed Feb 1,2017         |                                          |                                  */
/* gennum=-1 This is Thu Feb 2,2017         |                                          |                                  */
/*                                          |                                          |                                  */
/* genum     This is Fri Feb 3,2017 CURRENT |                                          |                                  */
/*                                          |                                          |                                  */
/********************************************|*****************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

 proc datasets lib=work kill;
 run;quit;

 data genum(genmax=4);
   retain doc 'This is Tue Jan 31, 2017'
 run;quit;

 data genum;
   retain doc 'This is Wed Feb 1, 2017';
 run;quit;

 data genum;
   retain doc 'This is Thu Feb 2, 2017';
 run;quit;

 data genum;
   retain doc 'This is Fri Feb 3, 2017';
 run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  data fourgen;                                                                                                         */
/*    retain gen;                                                                                                         */
/*    set                                                                                                                 */
/*        genum(gennum=-3)                                                                                                */
/*        genum(gennum=-2)                                                                                                */
/*        genum(gennum=-1)                                                                                                */
/*        genum                                                                                                           */
/*    ;                                                                                                                   */
/*    select (_n_);                                                                                                       */
/*       when (1) gen='gennum=-3';                                                                                        */
/*       when (2) gen='gennum=-2';                                                                                        */
/*       when (3) gen='gennum=-1';                                                                                        */
/*       when (4) gen='current'  ;                                                                                        */
/*    end;                                                                                                                */
/*    ;                                                                                                                   */
/*  run;quit;                                                                                                             */
/*                                                                                                                        */
/*  WORK.FOURGEN                                                                                                          */
/*     GEN               DOC                                                                                              */
/*                                                                                                                        */
/*  gennum=-3 This is Tue Jan 31,2017                                                                                     */
/*  gennum=-2 This is Wed Feb 1,2017                                                                                      */
/*  gennum=-1 This is Thu Feb 2,2017                                                                                      */
/*  genum     This is Fri Feb 3,2017 CURRENT                                                                              */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

data genum;
  retain doc 'This is Sat Feb 4, 2017';
run;quit;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*  data fourgen;                                                                                                         */
/*    retain gen;                                                                                                         */
/*    set                                                                                                                 */
/*        genum(gennum=-3)                                                                                                */
/*        genum(gennum=-2)                                                                                                */
/*        genum(gennum=-1)                                                                                                */
/*        genum                                                                                                           */
/*    ;                                                                                                                   */
/*    select (_n_);                                                                                                       */
/*       when (1) gen='gennum=-3';                                                                                        */
/*       when (2) gen='gennum=-2';                                                                                        */
/*      when (3) ge ='gennum=-1';                                                                                         */
/*       when (4) gen='current'  ;                                                                                        */
/*    end;                                                                                                                */
/*    ;                                                                                                                   */
/*  run;quit;                                                                                                             */
/*                                                                                                                        */
/*  THE NEW RING                                                                                                          */
/*                                                                                                                        */
/*     GEN              DOC                                                                                               */
/*                                                                                                                        */
/*  gennum=-3 This is Wed Feb 1,2017                                                                                      */
/*  gennum=-2 This is Thu Feb 2,2017                                                                                      */
/*  gennum=-1 This is Fri Feb 3,2017                                                                                      */
/*  current   This is Sat Feb 4,2017                                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
