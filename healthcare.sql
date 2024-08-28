with data as (
SELECT
Gender,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score

FROM nirmiti.ocd_patient_dataset
Group By 1
Order by 2
)
select
	sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
	sum(case when Gender = 'Male' then patient_count else 0 end) as count_male,

	round(sum(case when Gender = 'Female' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
	 as pct_female,

    round(sum(case when Gender = 'Male' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
	 as pct_male

from data
;
# -- 2. Count of Patients by Ethnicity and their respective Average Obsession Score

select
	Ethnicity,
	count(`Patient ID`) as patient_count,
	avg(`Y-BOCS Score (Obsessions)`) as obs_score
From nirmiti.ocd_patient_dataset
Group by 1
Order by 2;

alter table health_data.ocd_patient_dataset
modify `OCD Diagnosis Date` date;
select
date_format(`OCD Diagnosis Date`, '%Y-%m-01 00:00:00') as month,
count(`Patient ID`) patient_count
from nirmiti.ocd_patient_dataset
group by 1
Order by 1
;

Select
`Obsession Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from nirmiti.ocd_patient_dataset
group by 1
Order by 2
;
Select
`Compulsion Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from nirmiti.ocd_patient_dataset
group by 1
Order by 2
;
SELECT
    `Medications`,
    COUNT(`Patient ID`) AS medication_count
FROM nirmiti.ocd_patient_dataset
GROUP BY `Medications`
ORDER BY medication_count DESC;

SELECT
    SUM(CASE 
        WHEN `Depression Diagnosis` = 'Yes' AND `Anxiety Diagnosis` = 'No' AND `OCD Diagnosis Date` IS NOT NULL THEN 1
        ELSE 0
    END) AS count_depression_only,

    SUM(CASE 
        WHEN `Depression Diagnosis` = 'No' AND `Anxiety Diagnosis` = 'Yes' AND `OCD Diagnosis Date` IS NOT NULL THEN 1
        ELSE 0
    END) AS count_anxiety_only,

    SUM(CASE 
        WHEN `Depression Diagnosis` = 'Yes' AND `Anxiety Diagnosis` = 'Yes' AND `OCD Diagnosis Date` IS NOT NULL THEN 1
        ELSE 0
    END) AS count_depression_and_anxiety,

    SUM(CASE 
        WHEN `Depression Diagnosis` = 'Yes' AND `Anxiety Diagnosis` = 'Yes' AND `OCD Diagnosis Date` IS NOT NULL THEN 1
        ELSE 0
    END) AS count_all_three
FROM nirmiti.ocd_patient_dataset;
