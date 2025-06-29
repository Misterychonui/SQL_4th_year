select [Group],FIO,[Averege Score],[Course]   from Stydents
where [Averege Score] in
(
select Max([Averege Score]) from Stydents
group by [Group]
);