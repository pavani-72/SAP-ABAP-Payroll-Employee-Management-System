REPORT zpms_salary_mgmt.

TABLES: zpms_sal_mst.

DATA: ls_sal TYPE zpms_sal_mst.

*--------------------------------------------------
* Selection Screen - Salary Details
*--------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

PARAMETERS:
  p_empno TYPE zpms_de_empno,
  p_basic TYPE zpms_de_amt,
  p_hra   TYPE zpms_de_perc,
  p_bonus TYPE zpms_de_perc,
  p_pf    TYPE zpms_de_perc,
  p_tax   TYPE zpms_de_perc,
  p_curr  TYPE waers.

SELECTION-SCREEN END OF BLOCK b1.

*--------------------------------------------------
* Selection Screen - Operations
*--------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.

PARAMETERS:
  rb_add  RADIOBUTTON GROUP g1 DEFAULT 'X',
  rb_disp RADIOBUTTON GROUP g1,
  rb_upd  RADIOBUTTON GROUP g1,
  rb_del  RADIOBUTTON GROUP g1.

SELECTION-SCREEN END OF BLOCK b2.

*--------------------------------------------------
* Main Logic
*--------------------------------------------------

START-OF-SELECTION.

* Add Salary Record
IF rb_add = 'X'.

  ls_sal-emp_np     = p_empno.
  ls_sal-baisc_pay  = p_basic.
  ls_sal-hra_perc   = p_hra.
  ls_sal-bonus_perc = p_bonus.
  ls_sal-pf_perc    = p_pf.
  ls_sal-tax_perc   = p_tax.
  ls_sal-currency   = p_curr.

  INSERT zpms_sal_mst FROM ls_sal.

  IF sy-subrc = 0.
    WRITE: / 'Salary Record Added Successfully'.
  ELSE.
    WRITE: / 'Salary Record Already Exists'.
  ENDIF.

ENDIF.

* Display Salary Record
IF rb_disp = 'X'.

  SELECT SINGLE * FROM zpms_sal_mst
    INTO ls_sal
    WHERE emp_np = p_empno.

  IF sy-subrc = 0.
    WRITE: / 'Employee Number :', ls_sal-emp_np,
           / 'Basic Pay       :', ls_sal-baisc_pay,
           / 'HRA %           :', ls_sal-hra_perc,
           / 'Bonus %         :', ls_sal-bonus_perc,
           / 'PF %            :', ls_sal-pf_perc,
           / 'Tax %           :', ls_sal-tax_perc,
           / 'Currency        :', ls_sal-currency.
  ELSE.
    WRITE: / 'Salary Record Not Found'.
  ENDIF.

ENDIF.

* Update Salary Record
IF rb_upd = 'X'.

  UPDATE zpms_sal_mst
    SET baisc_pay  = p_basic
        hra_perc   = p_hra
        bonus_perc = p_bonus
        pf_perc    = p_pf
        tax_perc   = p_tax
        currency   = p_curr
    WHERE emp_np   = p_empno.

  IF sy-subrc = 0.
    WRITE: / 'Salary Record Updated Successfully'.
  ELSE.
    WRITE: / 'Salary Record Not Found for Update'.
  ENDIF.

ENDIF.

* Delete Salary Record
IF rb_del = 'X'.

  DELETE FROM zpms_sal_mst
    WHERE emp_np = p_empno.

  IF sy-subrc = 0.
    WRITE: / 'Salary Record Deleted Successfully'.
  ELSE.
    WRITE: / 'Salary Record Not Found for Delete'.
  ENDIF.

ENDIF.
