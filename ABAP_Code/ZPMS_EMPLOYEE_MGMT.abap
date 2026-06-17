REPORT zpms_employee_mgmt.

PARAMETERS:
  p_empno TYPE zpms_de_empno,
  p_name  TYPE zpms_de_ename,
  p_dept  TYPE zpms_de_dept,
  p_desig TYPE zpms_de_desig,
  p_email TYPE zpms_de_email.

PARAMETERS:
  rb_add  RADIOBUTTON GROUP g1 DEFAULT 'X',
  rb_disp RADIOBUTTON GROUP g1,
  rb_upd  RADIOBUTTON GROUP g1,
  rb_del  RADIOBUTTON GROUP g1.

DATA: ls_emp TYPE zpms_emp_mst.

START-OF-SELECTION.

* Add Employee
IF rb_add = 'X'.

  ls_emp-emp_no      = p_empno.
  ls_emp-emp_name    = p_name.
  ls_emp-department  = p_dept.
  ls_emp-designation = p_desig.
  ls_emp-email_id    = p_email.

  INSERT zpms_emp_mst FROM ls_emp.

  IF sy-subrc = 0.
    WRITE: / 'Employee Added Successfully'.
  ELSE.
    WRITE: / 'Employee Already Exists'.
  ENDIF.

ENDIF.

* Display Employee
IF rb_disp = 'X'.

  SELECT SINGLE * FROM zpms_emp_mst
    INTO ls_emp
    WHERE emp_no = p_empno.

  IF sy-subrc = 0.
    WRITE: / 'Employee Number :', ls_emp-emp_no,
           / 'Employee Name   :', ls_emp-emp_name,
           / 'Department      :', ls_emp-department,
           / 'Designation     :', ls_emp-designation,
           / 'Email           :', ls_emp-email_id.
  ELSE.
    WRITE: / 'Employee Not Found'.
  ENDIF.

ENDIF.

* Update Employee
IF rb_upd = 'X'.

  UPDATE zpms_emp_mst
    SET emp_name    = p_name
        department  = p_dept
        designation = p_desig
        email_id    = p_email
    WHERE emp_no    = p_empno.

  IF sy-subrc = 0.
    WRITE: / 'Employee Updated Successfully'.
  ELSE.
    WRITE: / 'Employee Not Found for Update'.
  ENDIF.

ENDIF.

* Delete Employee
IF rb_del = 'X'.

  DELETE FROM zpms_emp_mst
    WHERE emp_no = p_empno.

  IF sy-subrc = 0.
    WRITE: / 'Employee Deleted Successfully'.
  ELSE.
    WRITE: / 'Employee Not Found for Delete'.
  ENDIF.

ENDIF.
