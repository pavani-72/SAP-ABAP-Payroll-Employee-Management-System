*&---------------------------------------------------------------------*
*& Report  ZPMS_PAYROLL_PROCESS
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zpms_payroll_process.

PARAMETERS:
  p_empno TYPE zpms_de_empno,
  p_month TYPE zpms_de_month.

DATA:
  ls_sal TYPE zpms_sal_mst,
  ls_pay TYPE zpms_pay_trn.

DATA:
  lv_hra   TYPE p DECIMALS 2,
  lv_bonus TYPE p DECIMALS 2,
  lv_pf    TYPE p DECIMALS 2,
  lv_tax   TYPE p DECIMALS 2,
  lv_net   TYPE p DECIMALS 2.

START-OF-SELECTION.

SELECT SINGLE * INTO ls_sal
  FROM zpms_sal_mst
  WHERE emp_np = p_empno.

IF sy-subrc = 0.

  lv_hra   = ls_sal-baisc_pay * ls_sal-hra_perc / 100.
  lv_bonus = ls_sal-baisc_pay * ls_sal-bonus_perc / 100.
  lv_pf    = ls_sal-baisc_pay * ls_sal-pf_perc / 100.
  lv_tax   = ls_sal-baisc_pay * ls_sal-tax_perc / 100.

  lv_net = ls_sal-baisc_pay + lv_hra + lv_bonus - lv_pf - lv_tax.

  ls_pay-payroll_id = sy-datum.
  ls_pay-emp_no     = p_empno.
  ls_pay-pay_month  = p_month.
  ls_pay-basic_pay  = ls_sal-baisc_pay.
  ls_pay-hra_amt    = lv_hra.
  ls_pay-bonus_amt  = lv_bonus.
  ls_pay-pf_amt     = lv_pf.
  ls_pay-tax_amt    = lv_tax.
  ls_pay-net_pay    = lv_net.
  ls_pay-currency   = ls_sal-currency.

  INSERT zpms_pay_trn FROM ls_pay.

  IF sy-subrc = 0.
    WRITE: / 'Payroll Processed Successfully',
           / 'Net Salary:', lv_net.
  ELSE.
    WRITE: / 'Payroll Already Processed'.
  ENDIF.

ELSE.
  WRITE: / 'Salary Structure Not Found'.
ENDIF.
