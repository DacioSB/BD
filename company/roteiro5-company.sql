--/c/Users/lowva/Documents/variosnadas/PROJETOSBD1/company


--Q1
SELECT COUNT(ssn) AS counts FROM employee WHERE(sex = 'F');
--Q2
SELECT AVG(salary) AS avgs FROM employee WHERE sex = 'M' AND address LIKE '%TX%';
--Q3
SELECT F.superssn AS ssn_supervisor, COUNT(F.ssn) AS qtd_supervisionados FROM employee AS F GROUP BY F.superssn ORDER BY qtd_supervisionados;
--Q4
SELECT S.fname AS name_supervisor, COUNT(*) AS qtd_supervisionados FROM (employee AS F JOIN employee AS S ON F.superssn = S.ssn) GROUP BY S.fname ORDER BY qtd_supervisionados;
--Q5
 SELECT S.fname AS name_supervisor, COUNT(*) AS qtd_supervisionados FROM (employee AS F LEFT OUTER JOIN employee AS S ON F.superssn = S.ssn) GROUP BY S.fname ORDER BY COUNT(*) ASC;
 --Q6
SELECT MIN(qtd) AS qtd FROM (SELECT COUNT(W.pno) AS qtd FROM works_on AS W, employee AS F WHERE W.essn = F.ssn GROUP BY W.pno) AS foo;
--Q7
SELECT num_project, MIN(qtd_func) AS qtd_func FROM (SELECT m.pnumber AS num_project, COUNT(pno) AS qtd_func from works_on as w, project as m WHERE w.pno = m.pnumber GROUP BY m.pnumber ORDER BY COUNT(pno) ASC, m.pnumber ASC) AS foo GROUP BY num_project, qtd_func HAVING qtd_func = 2;