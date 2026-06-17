*&---------------------------------------------------------------------*
*& Report  ZPMS_PAYSLIP_RPT
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZPMS_PAYSLIP_RPT.


PARAMETERS:
  p_prid TYPE zpms_de_prid.

DATA: ls_pay TYPE zpms_pay_trn.

START-OF-SELECTION.

SELECT SINGLE * FROM zpms_pay_trn
  INTO ls_pay
  WHERE payroll_id = p_prid.

IF sy-subrc = 0.

  WRITE: / '******** EMPLOYEE PAYSLIP ********'.
  SKIP.

  WRITE: / 'Payroll ID   :', ls_pay-payroll_id.
  WRITE: / 'Employee No  :', ls_pay-emp_no.
  WRITE: / 'Pay Month    :', ls_pay-pay_month.
  WRITE: / 'Basic Pay    :', ls_pay-basic_pay.
  WRITE: / 'HRA Amount   :', ls_pay-hra_amt.
  WRITE: / 'Bonus Amount :', ls_pay-bonus_amt.
  WRITE: / 'PF Amount    :', ls_pay-pf_amt.
  WRITE: / 'Tax Amount   :', ls_pay-tax_amt.
  WRITE: / 'Net Salary   :', ls_pay-net_pay.
  WRITE: / 'Currency     :', ls_pay-currency.

ELSE.
  WRITE: / 'Payslip Record Not Found'.
ENDIF.
