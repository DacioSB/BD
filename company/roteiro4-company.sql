--/c/Users/lowva/Documents/variosnadas/PROJETOSBD1/company
--Informações uteis:
--39 employees, me retornou 6 sem supervisor e 33 com supervisor imediato... Correto
--ALTER DATABASE dacio_db SET search_path TO company, public;
--SET search_path TO company,public;
--SELECT DISTINCT pnumber FROM project WHERE pnumber IN (SELECT pnumber FROM project, department, employee WHERE dnum = dnumber AND mgrssn = ssn AND lname = 'Wong') OR pnumber IN (SELECT pno FROM works_on, employee WHERE essn = ssn AND lname = 'Wong');
--SELECT fname, lname FROM employee WHERE NOT EXISTS((SELECT pnumber FROM PROJECT WHERE dnum = 5) EXCEPT(SELECT pno FROM works_on WHERE ssn = essn));
-- SELECT dnumber, COUNT(*) FROM department, employee WHERE dno = dnumber AND salary > 40000 AND SELECT dno FROM employee GROUP BY dno HAVING COUNT(*)> 5;



^





--Q1
SELECT * FROM department;
--Q2
SELECT * FROM dependent;
--Q3
SELECT * FROM dept_locations;
--Q4
SELECT * FROM employee;
--Q5
SELECT * FROM project;
--Q6
SELECT * FROM works_on;
--Q7
SELECT fname, lname FROM employee WHERE(sex = 'M');
--Q8
SELECT fname FROM employee WHERE(sex = 'M' AND superssn is NULL);
--Q9
SELECT F.fname, S.fname FROM employee AS F, employee AS S WHERE(F.superssn is NOT NULL AND F.superssn = S.ssn);
--Q10
SELECT F.fname FROM employee AS F, employee AS S WHERE(F.superssn = S.ssn AND S.fname = 'Franklin');
--Q11
SELECT D.dname, L.dlocation FROM department D, dept_locations L WHERE(D.dnumber = L.dnumber);
--Q12
SELECT D.dname FROM department D, dept_locations L WHERE D.dnumber = L.dnumber AND L.dlocation LIKE'%S%';
--Q13
SELECT F.fname, F.lname, D.dependent_name FROM employee AS F, dependent AS D WHERE(D.essn = F.ssn);
--Q14
SELECT fname || minit || lname AS full_name, salary FROM employee WHERE(salary > 50000);
--Q15
SELECT pname, dname FROM department, project WHERE(dnum = dnumber);
--Q16
SELECT P.pname, F.fname FROM employee F, project P, department D WHERE(P.pnumber > 30 AND P.dnum = D.dnumber AND D.mgrssn = F.ssn);
--Q17
SELECT P.pname, F.fname FROM employee F, project P, works_on W WHERE(P.pnumber = W.pno AND W.essn = F.ssn);
--Q18
SELECT D.dependent_name, F.fname, D.relationship FROM dependent AS D, employee AS F, works_on AS W WHERE(W.pno = 91 AND W.essn = F.ssn AND D.essn = F.ssn);