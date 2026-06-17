*----------------------------------------------------------------------*
***INCLUDE ZPMS_PAYROLL_MP_USER_COMMANI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.

    WHEN 'EMP'.
      SUBMIT zpms_employee_mgmt VIA SELECTION-SCREEN AND RETURN.

    WHEN 'SAL'.
      SUBMIT zpms_salary_mgmt VIA SELECTION-SCREEN AND RETURN.

    WHEN 'PAY'.
      SUBMIT zpms_payroll_process VIA SELECTION-SCREEN AND RETURN.

    WHEN 'SLP'.
      SUBMIT zpms_payslip_rpt VIA SELECTION-SCREEN AND RETURN.

    WHEN 'EXIT' OR 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
      LEAVE PROGRAM.

    WHEN OTHERS.
      MESSAGE 'Choose a valid function' TYPE 'I'.

  ENDCASE.

ENDMODULE.
