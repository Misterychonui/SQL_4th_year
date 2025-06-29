/*d)  ���������� ���������� ��������� � ��������� ����������� � ������ �������� ���� � ��������� �� ���������: �� 14 �� 18 ���, �� 19 � 45, �� 46 �� 65, �� 66*/
WITH AgeGroups AS (
SELECT '�� � ���������� ����������' AS AgeGroup
UNION ALL
SELECT '14-18'
UNION ALL
SELECT '19-45'
UNION ALL
SELECT '46-65'
UNION ALL
SELECT '66+'
)
SELECT ag.AgeGroup, COALESCE(vc.VisitCount, 0) as VisitCount
FROM AgeGroups ag
LEFT JOIN (
SELECT CASE
			when p.Age < 14 then '�� � ���������� ����������'
			WHEN p.Age BETWEEN 14 AND 18 THEN '14-18'
			WHEN p.Age BETWEEN 19 AND 45 THEN '19-45'
			WHEN p.Age BETWEEN 46 AND 65 THEN '46-65'
			ELSE '66+'
		END AS AgeGroup, COUNT(*) as VisitCount
FROM patient p JOIN Stattalon s on s.[Aliling Patinet]=p.[Insurance policy] and s.Diagnosos = '���������' AND year(s.[Date of examination])= year(getdate())
GROUP BY CASE
			when p.Age < 14 then '�� � ���������� ����������'
			WHEN p.Age BETWEEN 14 AND 18 THEN '14-18'
			WHEN p.Age BETWEEN 19 AND 45 THEN '19-45'
			WHEN p.Age BETWEEN 46 AND 65 THEN '46-65'
			ELSE '66+'
		END
) vc ON ag.AgeGroup = vc.AgeGroup


